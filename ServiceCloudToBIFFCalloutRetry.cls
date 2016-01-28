global class ServiceCloudToBIFFCalloutRetry implements Schedulable {
	
	public Integer retriesInterval;
	public Integer retriesRemaining;
	public String caseId;
	public List<String> biffEmailList;
	public Integer retryAttempts;
	
	public void initiateAndScheduleRetry(String cId, List<String> biffEmails) {
		this.retriesInterval			= ((Integer) Giant_Eagle_Config__c.getInstance('BIFFRetriesInterval').Number__c == null || 
											(Integer) Giant_Eagle_Config__c.getInstance('BIFFRetriesInterval').Number__c < 1 ? 0 : 
											(Integer) Giant_Eagle_Config__c.getInstance('BIFFRetriesInterval').Number__c);
											
		this.retriesRemaining			= ((Integer) Giant_Eagle_Config__c.getInstance('BIFFRetriesNumber').Number__c == null || 
											(Integer) Giant_Eagle_Config__c.getInstance('BIFFRetriesNumber').Number__c < 1 ? 0 : 
											((Integer) Giant_Eagle_Config__c.getInstance('BIFFRetriesNumber').Number__c) - (this.retryAttempts-1));
		this.caseId						= cId;
		this.biffEmailList				= biffEmails;
		
		//Schedule a retry
		retryScheduler(this.retriesInterval, this.retriesRemaining, this.caseId, this.retryAttempts, this.biffEmailList);
	}
	
	//Schedules a retry using System.schedule()
	public static void retryScheduler(Integer retriesInterval, Integer retriesRemaining, String caseId, Integer retryAttempts, List<String> biffEmailList) {
		//Retry if there are retries remaining.
		if(retriesRemaining > 0 && retriesInterval > 0) {
			ServiceCloudToBIFFCalloutRetry retry	= new ServiceCloudToBIFFCalloutRetry();
        	retry.retriesInterval					= retriesInterval + retriesInterval;
        	retry.retryAttempts						= retryAttempts + 1;
        	retry.retriesRemaining					= retriesRemaining;
        	retry.caseId							= caseId;
        	retry.biffEmailList						= biffEmailList;
        			
        	Datetime retryTime = System.now();
			retryTime = retryTime.addSeconds(60*retriesInterval);
			String chron_exp = '' + retryTime.second() + ' ' + retryTime.minute() + ' ' + retryTime.hour() + ' ' + retryTime.day() + ' ' + retryTime.month() + ' ? ' + retryTime.year();
			System.schedule('Retry ServiceCloudToBIFF Transaction at ' + retryTime + ' Case ID: ' + caseId, chron_exp, retry);
		} else {
			//Log - Cannot schedule another retry because there are no more retries remaining or the interval is set to < 1
			Web_Service_Log__c wsl					= new Web_Service_Log__c();
			String input							= '##No Retries## - Interval or Retries is set to 0.\nIntervals: '  + retriesInterval + 'minutes, # of Retries remaining: ' + retriesRemaining;
			wsl										= WS_ServiceNow.startWS('ServiceCloudToBIFF Transaction', input);
			wsl										= WS_ServiceNow.endWS(wsl, 0, 1, 'Retries Exceeded', 'ServiceCloudToBIFF - Out of retries or interval is set to 0 ', 'Interal: ' + retriesInterval + '\nRetries: ' + retriesRemaining);
			//Log the error
    		writeLog(wsl);
    		//Send admin an email
    		ServiceCloudToBIFF.sendErrorEmail('SFToBIFF Error: Maximum retries exceeded', 
    											'The maximum number of retries (' + (Integer) Giant_Eagle_Config__c.getInstance('BIFFRetriesNumber').Number__c + 
    											') has been exceeded.\nThis process has stopped attempting to process Case Id: ' + caseId + ' at: ');
		}
	}
	
    global void execute(SchedulableContext ctx) {
		retryBIFFCall(this.caseId, this.retriesInterval, this.retriesRemaining, this.retryAttempts, this.biffEmailList);
	}
	
	@future (callout=true)
	public static void retryBIFFCall(String caseId, Integer interval, Integer retries, Integer retryAttempts, List<String> emailList) {
		if(retries > 0 && interval > 0) {
			try {
				Case thisCase =  Database.query(ServiceCloudToBIFF.getQueryString(caseId));
                
        		if(thisCase != null) {
        		
        			//If we have non-BIFF emails, send them only to the non-BIFF addresses that were sorted, otherwise, we skip sending the email by emptying the contactEmails list - Ahamadu
        			if(!emailList.isEmpty()) {
        				ServiceCloudToBIFF scToBiff			= new ServiceCloudToBIFF(thisCase);
        				scToBiff.callBIFFRetryAttempt(caseId, retryAttempts, emailList);
        			} else {
        				//Log empty list error - very unlikely but just in case
        				Web_Service_Log__c wsl				= new Web_Service_Log__c();
						String input						= 'No BIFF Email List available for this retry.\nRetry #: ' + retries + '\nCase ID: ' + caseId;
						wsl									= WS_ServiceNow.startWS('ServiceCloudToBIFF Transaction', input);
						wsl									= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF - Email list is empty', 'BIff Email list is empty.\nNumber of emails in list: ' + emailList.size());
						//Log the error
    					writeLog(wsl);
    					ServiceCloudToBIFF.sendErrorEmail('SFToBIFF Error: BIFF email list is empty', 'An attempt to make a call to callBIFF was unsuccessful because the BIFF email list is empty.  The call happened at: ');
        			}
        		} else {
        			//Log failed DB query
        			Web_Service_Log__c wsl					= new Web_Service_Log__c();
					String input							= 'Database query failed for this retry.\nCase ID: ' + caseId;
					wsl										= WS_ServiceNow.startWS('ServiceCloudToBIFF Transaction', input);
					wsl										= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF Database query returned null', 'Case query returned null\nCase Id: ' + caseId);
					//Log the error
    				writeLog(wsl);
        			ServiceCloudToBIFF.sendErrorEmail('SFToBIFF Error: Problem setting up retry', 'Database query failed (returned null) for Case Id: ' + caseId + ' at: ');
        		}
                
			} catch(Exception e) {
				//Log the exception
				Web_Service_Log__c wsl						= new Web_Service_Log__c();
				String input								= 'An error occurred while attempting to run a retry\n' + 'Case ID: ' + caseId + ' Intervals/Every: '  
																+ interval + 'minutes, # of Retries remaining: ' + retries;
				wsl											= WS_ServiceNow.startWS('ServiceCloudToBIFF Error Transaction', input);
				wsl											= WS_ServiceNow.endWS(wsl, 0, 1, 'Failed', 'ServiceCloudToBIFF Error Output/Message: ', e.getMessage());
				//Log the error
    			writeLog(wsl);
    			
				//call retry scheduler to schedule another attempt
				retryScheduler(interval, retries, caseId, retryAttempts, emailList);
			}
		} else {
			ServiceCloudToBIFF.sendErrorEmail('SFToBIFF Error: Problem in callBIFF method execution', 'Maximum retries exceeded while attempting to execute the callBIFF method at: ');
		}
	}
	
	//Local method to write log
	private static void writeLog(Web_Service_Log__c wsl) {
		ServiceCloudToBIFF.writeBIFFLog(wsl);
	}
}