public with sharing class ServiceCloudToBIFF {
	private Case thisCase					= new Case();
	public static final String OPERATION	= 'ServiceCloudToBIFF Transaction';
	private String assignGroup1				= '';
	private String assignGroup2				= '';
	private String assignGroup3				= '';
	private String assignGroup4				= '';	
	
	//Default constructor - TODO - Remove
	public ServiceCloudToBIFF() {
		//does nothing interesting
	}
	
	//Constructor
	public ServiceCloudToBIFF(Case aCase) {
		if(aCase != null && aCase.Id != null) {
			try{
				this.thisCase						= aCase;
				this.assignGroup1					= (this.thisCase.CC_Assignment_Group_1__r.Name != null ? thisCase.CC_Assignment_Group_1__r.Name.trim() : '');
    			this.assignGroup2					= (this.thisCase.CC_Assignment_Group_2__r.Name != null ? thisCase.CC_Assignment_Group_2__r.Name.trim() : '');
    			this.assignGroup3					= (this.thisCase.CC_Assignment_Group_3__r.Name != null ? thisCase.CC_Assignment_Group_3__r.Name.trim() : '');
    			this.assignGroup4					= (this.thisCase.CC_Assignment_Group_4__r.Name != null ? thisCase.CC_Assignment_Group_4__r.Name.trim() : '');
			} catch(Exception e) {
				//Write to log
				String input						= 'A Case object with ID: ' + aCase.Id;
				Web_Service_Log__c wsl				= new Web_Service_Log__c();
				wsl									= WS_ServiceNow.startWS(ServiceCloudToBIFF.OPERATION, input);
				wsl									= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF Object Instantiation Failed\n', e.getMessage());
				closeBIFFTransaction(wsl);
			}    		
		} else {
			//Write to log about a null case
			String input							= 'A null Case object was used to instantiate a ServiceCloudToBIFF object';
			Web_Service_Log__c wsl					= new Web_Service_Log__c();
			wsl										= WS_ServiceNow.startWS(ServiceCloudToBIFF.OPERATION, input);
			wsl										= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF Object Instantiation Failed due to a null Case object', 'Case object is null');
			closeBIFFTransaction(wsl);
		}
	}
	
	//Checks if the assigned Provider Group is one of the BIFF required groups.
    public Boolean isBIFFProviderGroup() {
    	
    	List<Giant_Eagle_Config__c> confs	= Giant_Eagle_Config__c.getAll().values();			//get the full list of configured properties
    	
    	for(Giant_Eagle_Config__c conf : confs) {
    		if(conf.Name.trim().startsWithIgnoreCase('BIFFProviderGroup')) {					//BIFFProviderGroup is the prefix for all the provider groups custom elements
    			if( (Pattern.matches(conf.Text__c.trim(), this.assignGroup1)) ||						
    				(Pattern.matches(conf.Text__c.trim(), this.assignGroup2)) ||
    				(Pattern.matches(conf.Text__c.trim(), this.assignGroup3)) ||
    				(Pattern.matches(conf.Text__c.trim(), this.assignGroup4))
    			) {
    				return true;
    			}
    		}
    	}
    	return false;
    }
    
    //Creates 2 separate list from the original provider group members email list. List 1 = BIFF emails, List 2 = Non BIFF emails
    public Map<String, String[]> getSortedProviderGroupMembers(List<String> providerGroupMemberEmails) {
    	Map<String, String[]> output			= new Map<String, List<String>>();
    	String[] biffEmailList					= new List<String>();
    	String[] nonBiffEmailList				= new List<String>();
    	
    	List<Giant_Eagle_Config__c> propList	= Giant_Eagle_Config__c.getAll().values();		//get all custom elements from cached memory

    	if(propList != null && propList.size() > 0) {
    		Boolean biffEmail			= false;
    		for(String providerGroupMemberEmail : providerGroupMemberEmails) {
    			for(Integer i=0; i<propList.size(); i++) {
    				if(propList[i].Name.trim().startsWithIgnoreCase('BIFFNotify') && providerGroupMemberEmail != null) {									//BIFFNotify is the prefix used for each email-starts-with custom element in the Giant_Eagle_Config__c custom element object
    					if(providerGroupMemberEmail.startsWithIgnoreCase(propList.get(i).Text__c.trim())) {
    						biffEmailList.add(providerGroupMemberEmail);
    						biffEmail	= true;
    					}
    				}
    			}
    			if(Pattern.matches('.*@gianteagle.com', providerGroupMemberEmail) && biffEmail == false && providerGroupMemberEmail != null) {
    				nonBiffEmailList.add(providerGroupMemberEmail);
    			}
    			biffEmail				= false;
    		}
    	} 
    	
    	output.put('BIFFList', biffEmailList);
    	output.put('NonBIFFList', nonBiffEmailList);
    	
    	return output;
    }
    
    //Sort the BIFF mapping elements based on the Priority specified in the Priority field.
    private List<BIFF_Field_Mapping__c> getSortedBiffFieldMapping() {
    	List<BIFF_Field_Mapping__c> scToBiffMap			= BIFF_Field_Mapping__c.getAll().values();
    	for (Integer i=1; i < scToBiffMap.size(); i++) {
      		BIFF_Field_Mapping__c ele = scToBiffMap.get(i); 
	  		Integer j = i;
      		while (j > 0 && scToBiffMap.get(j-1).Priority__c > ele.Priority__c)
      		{
          	 	scToBiffMap.set(j, scToBiffMap.get(j-1));
           		j--;
      		}
      		scToBiffMap.set(j, ele);
		} 
		return scToBiffMap;
    }
    
    //Makes the HTTP request to the BIFF WebAPI service 
    public Boolean callBIFF(List<String> biffEmailList) {
    	if(this.thisCase.Id != null) {
    		//Check if this is a test run
    		//if(Test.isRunningTest()) {
    		//	System.debug('This is a TEST run');
    		//	return true;
    		//}
    		    			
    		String biffJSONRequestBody							= buildHttpReqJson(biffEmailList);
    		
    		//Instantiate a request object
    		HttpRequest httpRequest								= new HttpRequest();
    		
    		//Set the request method
    		httpRequest.setMethod('POST');
    		
    		//Set the header parameters
    		httpRequest.setHeader('Content-Type','application/JSON');
    		Blob authValue 										= Blob.valueOf(Giant_Eagle_Config__c.getInstance('BIFFIntegrationUser').Text__c.trim() + 
    																		':' + Giant_Eagle_Config__c.getInstance('BIFFIntegrationPwd').Text__c.trim());
    		String authorizationHeader 							= 'Basic ' + EncodingUtil.base64Encode(authValue);
    		//String authorizationHeader 							= 'Basic ' + Giant_Eagle_Config__c.getInstance('BIFFIntegrationUser').Text__c.trim() + ':' + Giant_Eagle_Config__c.getInstance('BIFFIntegrationPwd').Text__c.trim();
			httpRequest.setHeader('Authorization', authorizationHeader);
    		
    		//Set the service endpoint
    		//httpRequest.setEndpoint(EncodingUtil.urlEncode(Giant_Eagle_Config__c.getInstance('BIFFDevEndpoint').Text__c,'UTF-8'));
    		httpRequest.setEndpoint(Giant_Eagle_Config__c.getInstance('BIFFDevEndpoint').Text__c);
    		
    		//Set the message payload
    		httpRequest.setBody(biffJSONRequestBody);
    		
    		//Instantiate the HTTP object.
    		Http http											= new Http();
    		
    		//Make the service call
    		try{
    			HTTPResponse httpResponse						= http.send(httpRequest);
    			
    			//Check the status code for 200 == success
    			if(httpResponse.getStatusCode() != 200) {
    				//Log the error response and initiate retries
    				throw new BIFFException('##Exception## - BIFF WebAPI Service returned the following:\n\nStatus Code: ' + httpResponse.getStatusCode() 
    											+ '\nStatus: ' + httpResponse.getStatus()
    											+ '\nMessage: ' + httpResponse.getBody()
    											+ '\nAuthorization String: ' + authorizationHeader
    											+ '\nAuthValue: ' + authValue.toString()
    										);
    			} else {
    				//TODO - Comment out all the lines below (except the return statement) to stop logging all successes
    				Web_Service_Log__c wsl	= new Web_Service_Log__c();
    				String input			= 'Successful call to BIFF WebAPI service\n' + biffJSONRequestBody;
					wsl						= WS_ServiceNow.startWS(ServiceCloudToBIFF.OPERATION, input);
					wsl						= WS_ServiceNow.endWS(wsl, 1, 0, 'Success', 'ServiceCloudToBIFF HTTP call returned successfully', 'Date: ' + httpResponse.getHeader('Date') + '\nResponse: ' + httpResponse.toString());
					//Log the error 
    				closeBIFFTransaction(wsl);
    				System.debug('**HTTP Request Successful**\n' + biffJSONRequestBody + '\nBIFF Response: ' + httpResponse.getBody());
    				return true;
    			}
    		} catch(Exception e) {
    			Web_Service_Log__c wsl		= new Web_Service_Log__c();
    			String input				= 'An error occurred while making a call to BIFF WebAPI service\n' + biffJSONRequestBody;
				wsl							= WS_ServiceNow.startWS(ServiceCloudToBIFF.OPERATION, input);
				wsl							= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF HTTP Service Call Exception', e.getMessage()); 
				   			
    			//Log the error and clean up
    			closeBIFFTransaction(wsl);
    			System.debug('Exception thrown - JSON: ' + biffJSONRequestBody + '\nException: ' + e.getMessage() + '\nStack trace: ' + e.getStackTraceString() + '\nCause: ' + e.getCause());
    			return false;
    		}
    	} else {
    		Web_Service_Log__c wsl			= new Web_Service_Log__c();
    		String input					= 'callBIFF method called with a null Case object';
			wsl								= WS_ServiceNow.startWS(ServiceCloudToBIFF.OPERATION, input);
			wsl								= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF: callBIFF method call failed due to a null Case object', 'Case object is null');
			
			//Log the error and clean up 
    		closeBIFFTransaction(wsl);
    		return false;
    	}
    }
    
    //Helper method that keeps track of the number of retries
    public void callBIFFRetry(String caseId, Integer retryAttempts, List<String> biffEmailList) {
    	//Schedule a retry
    	ServiceCloudToBIFFCalloutRetry scToBiffCallout		= new ServiceCloudToBIFFCalloutRetry();
    	scToBiffCallout.retryAttempts						= retryAttempts;
    	scToBiffCallout.initiateAndScheduleRetry(caseId, biffEmailList);
    }
    
    //Helper method to call the BIFF callout method
    public void callBIFFRetryAttempt(String caseId, Integer retryAttempts, List<String> biffEmailList) {
    	if(!callBIFF(biffEmailList)) {
    		callBIFFRetry(caseId, retryAttempts, biffEmailList);
    	}
    }
    
    //Helper functon to build the HTTP request body into a JSON string.
    public String buildHttpReqJson(List<String> biffEmailList) {					//TODO - Change the method visibility back to private
    	List<BIFF_Field_Mapping__c> biffParameters			= getSortedBiffFieldMapping();
    	JSONGenerator	jsonGen								= JSON.createGenerator(true);
    	String emailListString								= '';
    	for(Integer j = 0; j < biffEmailList.size(); j++) {
    		emailListString									+= biffEmailList.get(j);
    		if(j < biffEmailList.size()-1) {
    			emailListString								+= ',';
    		}
    	}
    	jsonGen.writeStartObject();
    	
    	jsonGen.writeStringField('providerGroupEmailContacts',emailListString);
    	if(biffParameters != null && biffParameters.size() > 0) {
    		for(Integer i = 0; i < biffParameters.size(); i++) {
    			if(biffParameters.get(i).Name.trim().endsWithIgnoreCase('NoSOQL')) {			//Check for special cases. Fields that are not part of the Case object
    				jsonGen.writeStringField(biffParameters.get(i).BIFF_Field__c, biffParameters.get(i).Case_Field__c + ((biffParameters.get(i).BIFF_Field__c.equalsIgnoreCase('caseResLink')) ? this.thisCase.CaseNumber : ''));
    			} 
    			else {
    				try{
    					if(!biffParameters.get(i).Name.trim().endsWithIgnoreCase('NoJSON')) {
    						if(biffParameters.get(i).BIFF_Field__c.equalsIgnoreCase('dateTimeOpened')) {	//Check and reformat the "dateTimeOpened" value.
    							String biffDateFormat		= Giant_Eagle_Config__c.getInstance('BIFFDateFormat').Text__c;
    							DateTime createdDate		= (DateTime) getValue(this.thisCase, biffParameters.get(i).Case_Field__c);    							
    							jsonGen.writeStringField(biffParameters.get(i).BIFF_Field__c, (createdDate != null ? String.valueOf(createdDate.format(biffDateFormat)) : ''));
    						} else {
    							jsonGen.writeStringField(biffParameters.get(i).BIFF_Field__c, ((getValue(this.thisCase, biffParameters.get(i).Case_Field__c) != null) 
    													? String.valueOf(getValue(this.thisCase, biffParameters.get(i).Case_Field__c)).escapeEcmaScript() : ''));
    						}
    					}
    					
    				} catch(SObjectException soe) {
    					Web_Service_Log__c wsl				= new Web_Service_Log__c();
    					String input						= 'An error occurred while building the JSON string\nJSON: ' + jsonGen.getAsString();
						wsl									= WS_ServiceNow.startWS(ServiceCloudToBIFF.OPERATION, input);
						wsl									= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF JSON Generation process exception', soe.getMessage());
						//Log the error 
    					ServiceCloudToBIFF.writeBIFFLog(wsl);
    				}
    			}

    		}
    		jsonGen.writeEndObject();
    	}
    	return jsonGen.getAsString();
    }
        
    //Helper method to document error activities in the log object
    public static void writeBIFFLog(Web_Service_Log__c wsl) {		//TODO - Change the method visibility back to private
		try{
			insert wsl;
		} catch(Exception e) {
			//Send alert email
			sendErrorEmail('ServiceCloudToBIFF Logging Exception', 'An error occurred while making a log entry.\nWhen: ' + System.now() + '\nError message: ' + e.getMessage());
		} 	
    }
    
    //Writes the transaction log if it contains data and erases the variables associated with this ServiceCloudToBIFF object.
    public void closeBIFFTransaction(Web_Service_Log__c wsl) {
    	if(wsl != null) {
    		ServiceCloudToBIFF.writeBIFFLog(wsl);
    	}
    	this.thisCase					= null;
		this.assignGroup1				= '';
		this.assignGroup2				= '';
		this.assignGroup3				= '';
		this.assignGroup4				= '';
    }
    
    //Custom exception.  Used when a traditional exception is not thrown but a failure occurred and confirmed by the http status code.
    private Class BIFFException extends Exception {}
    
    //Handle all fields in an object including lookup fields.
    private Object getValue( sObject s, String f ) {
        if ( s == null || f == null || f == '' ) return null;
        String[] fList = f.split('\\.');
        Integer fLast = fList.size() - 1;
        sObject t = s;
        for ( Integer i = 0; i < fLast; i++ ) {
            t = t.getSObject( fList[i] );
            if ( t == null ) return null;
        }
        return t.get(fList[fLast]);
    }
    
    //Send an email to the administrator in cases of major failures
    public static Boolean sendErrorEmail(String subject, String message) {
    	// Build message body
        String mailBody							= '\n';
        mailBody								+= message + System.now();
        // Send an error notification email
        Messaging.SingleEmailMessage mailAdmin 	= new Messaging.SingleEmailMessage();
        String[] toAddresses 					= new String[] {Giant_Eagle_Config__c.getInstance('BIFFErrorContact').Text__c};
        mailAdmin.setToAddresses(toAddresses);
        mailAdmin.setSubject(subject);
        mailAdmin.setPlainTextBody(mailBody);
        Messaging.SendEmailResult[] res 		= Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mailAdmin });
        if(res[0].success) {
        	return true;
        } else {
        	Web_Service_Log__c wsl				= new Web_Service_Log__c();
    		String input						= 'Error occurred while sending an email about an error which occured to the System Administrator';
			wsl									= WS_ServiceNow.startWS(ServiceCloudToBIFF.OPERATION, input);
			wsl									= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF: Error occurred while sending email to System Administrator', res[0].errors[0].message);
			
			//Log the error and clean up 
    		writeBIFFLog(wsl);
        	return false;
        }
    }
    
    //Prepare the SOQL string
	public static String getQueryString(String caseId) {
		List<BIFF_Field_Mapping__c> scToBiffMap			= BIFF_Field_Mapping__c.getAll().values();
		String soql			= 'SELECT ';
		for(Integer i = 0; i < scToBiffMap.size(); i++) {
			if(!scToBiffMap.get(i).Name.trim().endsWithIgnoreCase('NoSOQL')) {			//'NoSOQL' appended at the end of a field name indicates that the BIFF_Field_Mapping__c field should not be used to query an object
				soql		+= scToBiffMap.get(i).Case_Field__c;
				if(i < scToBiffMap.size() -1) {
					soql	+= ', ';
				}
			}
		}
		soql 				+= ' FROM Case WHERE id=\'' + caseId + '\'';
		return soql;
	}
	
	//For testing only - Used in Test Class (BIFFIntegrationTest.cls)
    public List<String> getStringOfEmails(List<Provider_Group_Member__c> emailList) {
    	List<String> emails = new List<String>();
    	for(Provider_Group_Member__c mem : emailList) {
    		emails.add(mem.User_Email__c);
    	}
    	return emails;
    }
    
}