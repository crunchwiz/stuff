@isTest(SeeAllData=true)
public class BIFFIntegrationTest {
	                
    private static testMethod void testClassInstantiation() {
    	Case testCase = [Select c.OwnerId,
                				c.Id,							
                                c.Call_Tone__c,
                                c.CaseNumber,
                                c.Case_Call_Back__c,
								c.Product_Description__c,	
                                c.Case_Call_Back_Ext__c,
                                c.CC_Additional_Detail__c,
                                c.CC_Assignment_Group_1__c,
                                c.CC_Assignment_Group_2__c,
                                c.CC_Assignment_Group_3__c,
                                c.CC_Assignment_Group_4__c,
                                c.CC_Assignment_Group_1__r.Name,
                                c.CC_Assignment_Group_2__r.Name,
                                c.CC_Assignment_Group_3__r.Name,
                                c.CC_Assignment_Group_4__r.Name,
                                c.CC_Case_Creation_Notes__c,
                                c.CC_Case_Site__c,
                                c.CC_Case_Site_Name__c,
                                c.CC_Case_Site_Phone__c,
                                c.CC_Case_Site__r.Name,
                                c.CC_Case_Site__r.Store_number__c,
                                c.CC_Product_Dept_SubGroup__c,
                                c.CC_SubCategory1__c,
                                c.CC_SubCategory2__c,
                                c.CC_TM_Recognition_Name__c,
                                c.Consumer_Address__c,
                                c.Consumer_Name__c,
                                c.Consumer_Name__r.FirstName,
                                c.Consumer_Name__r.LastName,
                                c.Consumer_Phone__c,
                                c.Consumer_Email__c,
                                c.CreatedDate,
                                c.ContactId,
								c.Department__c,
                                c.Description,
                                c.Discontinued_Product__c,
                                c.Employee_Name__c,
                                c.Expiration_Date__c,
                                c.GEAC__c,
                                c.GEAC__r.Name,
                                c.Key_Word__c,
                                c.Lot_Number__c,
                                c.Name_of_Recall__c,
                                c.Name_of_Recall__r.Name,
                                c.Origin,
                                c.Other_Coding__c,
                                c.Owner.Name,
                                c.Owner.LastName,
                                c.Owner.FirstName,
                                c.Problem_Type__c,						
                                c.Primary_Assignee__c,
                                c.Product__c,
                                c.Product__r.Name,
                                c.Product__r.UPC_Code__c,
                                c.Product__r.CC_Product_Dept_SubGroup__c,
                                c.Product__r.Key_Word__c,
                                c.Product_Name__c,
                                c.Product_Size__c,
                                c.Product_Origin__c,
                                c.Ready_To_Email_Customer__c,
                                c.RecordTypeId,
                                c.Subject,
                                c.Status,
                                c.Type,
                                c.UPC_Available__c,
                                c.UPC_Code__c,
                                c.ParentId, c.Parent.casenumber,
                                c.Letter_Type__c, 
                                c.GC_Fulfillment_Status__c,
                                c.Gave_Gift_Card_Value__c,
                                c.Gave_Refund_DMB_Value__c,
                                c.X6_Month_Spend_at_Case_Total__c, 
                                c.Self_Recognition_EXTRA_MILE_Ticket__c,
                                c.X6_Month_Spend_at_Case_w_out_Gift_Cards__c
                           From Case c
                          Where c.CC_Assignment_Group_1__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_1__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_1__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_2__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_3__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_4__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE 'RX____' Limit 1];
                          		
        Case nullCase							= null;
    	        
    	Test.startTest();
    		ServiceCloudToBIFF scToBiff			= new ServiceCloudToBIFF(testCase);
    		ServiceCloudToBIFF scToBiffNull		= new ServiceCloudToBIFF(nullCase);
    	Test.stopTest();
    }
    
    private static testMethod void testGetQueryString() {
    	Case testCase = [Select c.OwnerId,
                				c.Id,							
                                c.Call_Tone__c,
                                c.CaseNumber,
                                c.Case_Call_Back__c,
								c.Product_Description__c,	
                                c.Case_Call_Back_Ext__c,
                                c.CC_Additional_Detail__c,
                                c.CC_Assignment_Group_1__c,
                                c.CC_Assignment_Group_2__c,
                                c.CC_Assignment_Group_3__c,
                                c.CC_Assignment_Group_4__c,
                                c.CC_Assignment_Group_1__r.Name,
                                c.CC_Assignment_Group_2__r.Name,
                                c.CC_Assignment_Group_3__r.Name,
                                c.CC_Assignment_Group_4__r.Name,
                                c.CC_Case_Creation_Notes__c,
                                c.CC_Case_Site__c,
                                c.CC_Case_Site_Name__c,
                                c.CC_Case_Site_Phone__c,
                                c.CC_Case_Site__r.Name,
                                c.CC_Case_Site__r.Store_number__c,
                                c.CC_Product_Dept_SubGroup__c,
                                c.CC_SubCategory1__c,
                                c.CC_SubCategory2__c,
                                c.CC_TM_Recognition_Name__c,
                                c.Consumer_Address__c,
                                c.Consumer_Name__c,
                                c.Consumer_Name__r.FirstName,
                                c.Consumer_Name__r.LastName,
                                c.Consumer_Phone__c,
                                c.Consumer_Email__c,
                                c.CreatedDate,
                                c.ContactId,
								c.Department__c,
                                c.Description,
                                c.Discontinued_Product__c,
                                c.Employee_Name__c,
                                c.Expiration_Date__c,
                                c.GEAC__c,
                                c.GEAC__r.Name,
                                c.Key_Word__c,
                                c.Lot_Number__c,
                                c.Name_of_Recall__c,
                                c.Name_of_Recall__r.Name,
                                c.Origin,
                                c.Other_Coding__c,
                                c.Owner.Name,
                                c.Owner.LastName,
                                c.Owner.FirstName,
                                c.Problem_Type__c,						
                                c.Primary_Assignee__c,
                                c.Product__c,
                                c.Product__r.Name,
                                c.Product__r.UPC_Code__c,
                                c.Product__r.CC_Product_Dept_SubGroup__c,
                                c.Product__r.Key_Word__c,
                                c.Product_Name__c,
                                c.Product_Size__c,
                                c.Product_Origin__c,
                                c.Ready_To_Email_Customer__c,
                                c.RecordTypeId,
                                c.Subject,
                                c.Status,
                                c.Type,
                                c.UPC_Available__c,
                                c.UPC_Code__c,
                                c.ParentId, c.Parent.casenumber,
                                c.Letter_Type__c, 
                                c.GC_Fulfillment_Status__c,
                                c.Gave_Gift_Card_Value__c,
                                c.Gave_Refund_DMB_Value__c,
                                c.X6_Month_Spend_at_Case_Total__c, 
                                c.Self_Recognition_EXTRA_MILE_Ticket__c,
                                c.X6_Month_Spend_at_Case_w_out_Gift_Cards__c
                           From Case c
                          Where c.CC_Assignment_Group_1__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_1__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_1__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_2__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_3__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_4__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE 'RX____' Limit 1];

    	Test.startTest();
    		String soql								= ServiceCloudToBIFF.getQueryString(testCase.Id);
    		Case aCase								= Database.query(soql);
    		System.debug('Testing getQueryString(). Case Id: ' + aCase.Id + '\nSOQL: ' + soql);
    	Test.stopTest();
    }
    
    private static testMethod void testIsBIFFProviderGroup() {
    	Case testCase = [Select c.OwnerId,
                				c.Id,							
                                c.Call_Tone__c,
                                c.CaseNumber,
                                c.Case_Call_Back__c,
								c.Product_Description__c,	
                                c.Case_Call_Back_Ext__c,
                                c.CC_Additional_Detail__c,
                                c.CC_Assignment_Group_1__c,
                                c.CC_Assignment_Group_2__c,
                                c.CC_Assignment_Group_3__c,
                                c.CC_Assignment_Group_4__c,
                                c.CC_Assignment_Group_1__r.Name,
                                c.CC_Assignment_Group_2__r.Name,
                                c.CC_Assignment_Group_3__r.Name,
                                c.CC_Assignment_Group_4__r.Name,
                                c.CC_Case_Creation_Notes__c,
                                c.CC_Case_Site__c,
                                c.CC_Case_Site_Name__c,
                                c.CC_Case_Site_Phone__c,
                                c.CC_Case_Site__r.Name,
                                c.CC_Case_Site__r.Store_number__c,
                                c.CC_Product_Dept_SubGroup__c,
                                c.CC_SubCategory1__c,
                                c.CC_SubCategory2__c,
                                c.CC_TM_Recognition_Name__c,
                                c.Consumer_Address__c,
                                c.Consumer_Name__c,
                                c.Consumer_Name__r.FirstName,
                                c.Consumer_Name__r.LastName,
                                c.Consumer_Phone__c,
                                c.Consumer_Email__c,
                                c.CreatedDate,
                                c.ContactId,
								c.Department__c,
                                c.Description,
                                c.Discontinued_Product__c,
                                c.Employee_Name__c,
                                c.Expiration_Date__c,
                                c.GEAC__c,
                                c.GEAC__r.Name,
                                c.Key_Word__c,
                                c.Lot_Number__c,
                                c.Name_of_Recall__c,
                                c.Name_of_Recall__r.Name,
                                c.Origin,
                                c.Other_Coding__c,
                                c.Owner.Name,
                                c.Owner.LastName,
                                c.Owner.FirstName,
                                c.Problem_Type__c,						
                                c.Primary_Assignee__c,
                                c.Product__c,
                                c.Product__r.Name,
                                c.Product__r.UPC_Code__c,
                                c.Product__r.CC_Product_Dept_SubGroup__c,
                                c.Product__r.Key_Word__c,
                                c.Product_Name__c,
                                c.Product_Size__c,
                                c.Product_Origin__c,
                                c.Ready_To_Email_Customer__c,
                                c.RecordTypeId,
                                c.Subject,
                                c.Status,
                                c.Type,
                                c.UPC_Available__c,
                                c.UPC_Code__c,
                                c.ParentId, c.Parent.casenumber,
                                c.Letter_Type__c, 
                                c.GC_Fulfillment_Status__c,
                                c.Gave_Gift_Card_Value__c,
                                c.Gave_Refund_DMB_Value__c,
                                c.X6_Month_Spend_at_Case_Total__c, 
                                c.Self_Recognition_EXTRA_MILE_Ticket__c,
                                c.X6_Month_Spend_at_Case_w_out_Gift_Cards__c
                           From Case c
                          Where c.CC_Assignment_Group_1__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_1__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_1__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_2__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_3__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_4__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE 'RX____' Limit 1];
       	
    	Test.startTest();
    		ServiceCloudToBIFF scToBiffStore		= new ServiceCloudToBIFF(testCase);
    		if(scToBiffStore.isBIFFProviderGroup()) {
    			System.debug('This is a BIFF Provider Group');
    		} else {
    			System.debug('This is NOT a BIFF Provider Group');
    		}
    	Test.stopTest();
    }
    
    private static testMethod void testBuildHttpReqJson() {
    	Case testCase = [Select c.OwnerId,
                				c.Id,							
                                c.Call_Tone__c,
                                c.CaseNumber,
                                c.Case_Call_Back__c,
								c.Product_Description__c,	
                                c.Case_Call_Back_Ext__c,
                                c.CC_Additional_Detail__c,
                                c.CC_Assignment_Group_1__c,
                                c.CC_Assignment_Group_2__c,
                                c.CC_Assignment_Group_3__c,
                                c.CC_Assignment_Group_4__c,
                                c.CC_Assignment_Group_1__r.Name,
                                c.CC_Assignment_Group_2__r.Name,
                                c.CC_Assignment_Group_3__r.Name,
                                c.CC_Assignment_Group_4__r.Name,
                                c.CC_Case_Creation_Notes__c,
                                c.CC_Case_Site__c,
                                c.CC_Case_Site_Name__c,
                                c.CC_Case_Site_Phone__c,
                                c.CC_Case_Site__r.Name,
                                c.CC_Case_Site__r.Store_number__c,
                                c.CC_Product_Dept_SubGroup__c,
                                c.CC_SubCategory1__c,
                                c.CC_SubCategory2__c,
                                c.CC_TM_Recognition_Name__c,
                                c.Consumer_Address__c,
                                c.Consumer_Name__c,
                                c.Consumer_Name__r.FirstName,
                                c.Consumer_Name__r.LastName,
                                c.Consumer_Phone__c,
                                c.Consumer_Email__c,
                                c.CreatedDate,
                                c.ContactId,
								c.Department__c,
                                c.Description,
                                c.Discontinued_Product__c,
                                c.Employee_Name__c,
                                c.Expiration_Date__c,
                                c.GEAC__c,
                                c.GEAC__r.Name,
                                c.Key_Word__c,
                                c.Lot_Number__c,
                                c.Name_of_Recall__c,
                                c.Name_of_Recall__r.Name,
                                c.Origin,
                                c.Other_Coding__c,
                                c.Owner.Name,
                                c.Owner.LastName,
                                c.Owner.FirstName,
                                c.Problem_Type__c,						
                                c.Primary_Assignee__c,
                                c.Product__c,
                                c.Product__r.Name,
                                c.Product__r.UPC_Code__c,
                                c.Product__r.CC_Product_Dept_SubGroup__c,
                                c.Product__r.Key_Word__c,
                                c.Product_Name__c,
                                c.Product_Size__c,
                                c.Product_Origin__c,
                                c.Ready_To_Email_Customer__c,
                                c.RecordTypeId,
                                c.Subject,
                                c.Status,
                                c.Type,
                                c.UPC_Available__c,
                                c.UPC_Code__c,
                                c.ParentId, c.Parent.casenumber,
                                c.Letter_Type__c, 
                                c.GC_Fulfillment_Status__c,
                                c.Gave_Gift_Card_Value__c,
                                c.Gave_Refund_DMB_Value__c,
                                c.X6_Month_Spend_at_Case_Total__c, 
                                c.Self_Recognition_EXTRA_MILE_Ticket__c,
                                c.X6_Month_Spend_at_Case_w_out_Gift_Cards__c
                           From Case c
                          Where c.CC_Assignment_Group_1__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_1__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_1__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_2__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_3__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_4__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE 'RX____' Limit 1];
    	Test.startTest();
    		ServiceCloudToBIFF scToBiff			= new ServiceCloudToBIFF(testCase);
    		List<Provider_Group_Member__c> pgMembers=[Select User_Email__c From Provider_Group_Member__c Where (User__c!=null or Contact__c!=null) Limit 1000];
	        Map<String, String[]> sortedEmails	= scToBiff.getSortedProviderGroupMembers(scToBiff.getStringOfEmails(pgMembers));
	        System.debug('NonBIFFList in JSON format: ' + scToBiff.buildHttpReqJson(sortedEmails.get('NonBIFFList')));
    	Test.stopTest();
    }
    
    private static testMethod void testGetSortedProviderGroupMembers() {
    	Test.startTest();
    		ServiceCloudToBIFF scToBiff			= new ServiceCloudToBIFF();
    		List<Provider_Group_Member__c> pgMembers=[Select User__c,Contact__c,User_Email__c,Provider_Group__c,Provider_Group__r.Name, 
            											First_Name__c,Last_Name__c,Send_Email__c,Primary_Assignee__c, Name From 
	           											Provider_Group_Member__c Where (User_Email__c != null) Limit 1000];
	        Map<String, String[]> sortedEmails	= scToBiff.getSortedProviderGroupMembers(scToBiff.getStringOfEmails(pgMembers));
	        System.debug('Map: ' + sortedEmails + '\n\nBIFF List: ' + sortedEmails.get('BIFFList').size() + ' ' + sortedEmails.get('BIFFList') + '\nNon BIFF List: ' + sortedEmails.get('NonBIFFList').size() + ' ' + sortedEmails.get('NonBIFFList'));
    	Test.stopTest();
    }
    
    private static testMethod void testSendErrorEmail() {
    	Test.startTest();
    		if(ServiceCloudToBIFF.sendErrorEmail('Test subject','Test message sent at ')) {
    			System.debug('Email successfully sent');
    		} else {
    			System.debug('Email failed to send');
    		}
    	Test.stopTest();
    }
    
    private static testMethod void testWriteToLogForNullCase() {
    	Test.startTest();
    		Case testCase					= null;
    		ServiceCloudToBIFF scToBiff		= new ServiceCloudToBIFF(testCase);
    	Test.stopTest();
    }
    
    private static testMethod void testRetryBiffCall() {
    	Case testCase = [Select c.OwnerId,
                				c.Id,							
                                c.Call_Tone__c,
                                c.CaseNumber,
                                c.Case_Call_Back__c,
								c.Product_Description__c,	
                                c.Case_Call_Back_Ext__c,
                                c.CC_Additional_Detail__c,
                                c.CC_Assignment_Group_1__c,
                                c.CC_Assignment_Group_2__c,
                                c.CC_Assignment_Group_3__c,
                                c.CC_Assignment_Group_4__c,
                                c.CC_Assignment_Group_1__r.Name,
                                c.CC_Assignment_Group_2__r.Name,
                                c.CC_Assignment_Group_3__r.Name,
                                c.CC_Assignment_Group_4__r.Name,
                                c.CC_Case_Creation_Notes__c,
                                c.CC_Case_Site__c,
                                c.CC_Case_Site_Name__c,
                                c.CC_Case_Site_Phone__c,
                                c.CC_Case_Site__r.Name,
                                c.CC_Case_Site__r.Store_number__c,
                                c.CC_Product_Dept_SubGroup__c,
                                c.CC_SubCategory1__c,
                                c.CC_SubCategory2__c,
                                c.CC_TM_Recognition_Name__c,
                                c.Consumer_Address__c,
                                c.Consumer_Name__c,
                                c.Consumer_Name__r.FirstName,
                                c.Consumer_Name__r.LastName,
                                c.Consumer_Phone__c,
                                c.Consumer_Email__c,
                                c.CreatedDate,
                                c.ContactId,
								c.Department__c,
                                c.Description,
                                c.Discontinued_Product__c,
                                c.Employee_Name__c,
                                c.Expiration_Date__c,
                                c.GEAC__c,
                                c.GEAC__r.Name,
                                c.Key_Word__c,
                                c.Lot_Number__c,
                                c.Name_of_Recall__c,
                                c.Name_of_Recall__r.Name,
                                c.Origin,
                                c.Other_Coding__c,
                                c.Owner.Name,
                                c.Owner.LastName,
                                c.Owner.FirstName,
                                c.Problem_Type__c,						
                                c.Primary_Assignee__c,
                                c.Product__c,
                                c.Product__r.Name,
                                c.Product__r.UPC_Code__c,
                                c.Product__r.CC_Product_Dept_SubGroup__c,
                                c.Product__r.Key_Word__c,
                                c.Product_Name__c,
                                c.Product_Size__c,
                                c.Product_Origin__c,
                                c.Ready_To_Email_Customer__c,
                                c.RecordTypeId,
                                c.Subject,
                                c.Status,
                                c.Type,
                                c.UPC_Available__c,
                                c.UPC_Code__c,
                                c.ParentId, c.Parent.casenumber,
                                c.Letter_Type__c, 
                                c.GC_Fulfillment_Status__c,
                                c.Gave_Gift_Card_Value__c,
                                c.Gave_Refund_DMB_Value__c,
                                c.X6_Month_Spend_at_Case_Total__c, 
                                c.Self_Recognition_EXTRA_MILE_Ticket__c,
                                c.X6_Month_Spend_at_Case_w_out_Gift_Cards__c
                           From Case c
                          Where c.CC_Assignment_Group_1__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_1__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_1__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_2__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_3__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_4__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE 'RX____' Limit 1];
    	List<Provider_Group_Member__c> pgMembers	=[Select User__c,Contact__c,User_Email__c,Provider_Group__c,Provider_Group__r.Name, 
            												First_Name__c,Last_Name__c,Send_Email__c,Primary_Assignee__c, Name From 
	           												Provider_Group_Member__c Where (User__c!=null or Contact__c!=null) Limit 1000];
	           												
    	Test.startTest();
    		ServiceCloudToBIFF scToBiff				= new ServiceCloudToBIFF(testCase);
    		List<String> emails						= scToBiff.getStringOfEmails(pgMembers);
    		ServiceCloudToBIFFCalloutRetry.retryBIFFCall(testCase.Id, 1, 3, 1, emails);
    		ServiceCloudToBIFFCalloutRetry.retryBIFFCall(testCase.Id, 0, 0, 1, emails);		//Force the else condition by sending 0s
    		ServiceCloudToBIFFCalloutRetry.retryBIFFCall('abcdefghijklmnop', 1, 3, 1, emails); //force a null on the query by sending a bad Case Id
    	Test.stopTest();
    }
    
    private static testMethod void testInitiateAndScheduleRetry() {
    	Case testCase = [Select c.OwnerId,
                				c.Id,							
                                c.Call_Tone__c,
                                c.CaseNumber,
                                c.Case_Call_Back__c,
								c.Product_Description__c,	
                                c.Case_Call_Back_Ext__c,
                                c.CC_Additional_Detail__c,
                                c.CC_Assignment_Group_1__c,
                                c.CC_Assignment_Group_2__c,
                                c.CC_Assignment_Group_3__c,
                                c.CC_Assignment_Group_4__c,
                                c.CC_Assignment_Group_1__r.Name,
                                c.CC_Assignment_Group_2__r.Name,
                                c.CC_Assignment_Group_3__r.Name,
                                c.CC_Assignment_Group_4__r.Name,
                                c.CC_Case_Creation_Notes__c,
                                c.CC_Case_Site__c,
                                c.CC_Case_Site_Name__c,
                                c.CC_Case_Site_Phone__c,
                                c.CC_Case_Site__r.Name,
                                c.CC_Case_Site__r.Store_number__c,
                                c.CC_Product_Dept_SubGroup__c,
                                c.CC_SubCategory1__c,
                                c.CC_SubCategory2__c,
                                c.CC_TM_Recognition_Name__c,
                                c.Consumer_Address__c,
                                c.Consumer_Name__c,
                                c.Consumer_Name__r.FirstName,
                                c.Consumer_Name__r.LastName,
                                c.Consumer_Phone__c,
                                c.Consumer_Email__c,
                                c.CreatedDate,
                                c.ContactId,
								c.Department__c,
                                c.Description,
                                c.Discontinued_Product__c,
                                c.Employee_Name__c,
                                c.Expiration_Date__c,
                                c.GEAC__c,
                                c.GEAC__r.Name,
                                c.Key_Word__c,
                                c.Lot_Number__c,
                                c.Name_of_Recall__c,
                                c.Name_of_Recall__r.Name,
                                c.Origin,
                                c.Other_Coding__c,
                                c.Owner.Name,
                                c.Owner.LastName,
                                c.Owner.FirstName,
                                c.Problem_Type__c,						
                                c.Primary_Assignee__c,
                                c.Product__c,
                                c.Product__r.Name,
                                c.Product__r.UPC_Code__c,
                                c.Product__r.CC_Product_Dept_SubGroup__c,
                                c.Product__r.Key_Word__c,
                                c.Product_Name__c,
                                c.Product_Size__c,
                                c.Product_Origin__c,
                                c.Ready_To_Email_Customer__c,
                                c.RecordTypeId,
                                c.Subject,
                                c.Status,
                                c.Type,
                                c.UPC_Available__c,
                                c.UPC_Code__c,
                                c.ParentId, c.Parent.casenumber,
                                c.Letter_Type__c, 
                                c.GC_Fulfillment_Status__c,
                                c.Gave_Gift_Card_Value__c,
                                c.Gave_Refund_DMB_Value__c,
                                c.X6_Month_Spend_at_Case_Total__c, 
                                c.Self_Recognition_EXTRA_MILE_Ticket__c,
                                c.X6_Month_Spend_at_Case_w_out_Gift_Cards__c
                           From Case c
                          Where c.CC_Assignment_Group_1__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_1__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_1__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_2__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_3__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_4__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE 'RX____' Limit 1];
       	Test.startTest();
    		ServiceCloudToBIFF scToBiff					= new ServiceCloudToBIFF(testCase);
    		ServiceCloudToBIFFCalloutRetry callout		= new ServiceCloudToBIFFCalloutRetry();
    		callout.retryAttempts						= 1;
    		List<Provider_Group_Member__c> pgMembers	=[Select User__c,Contact__c,User_Email__c,Provider_Group__c,Provider_Group__r.Name, 
            												First_Name__c,Last_Name__c,Send_Email__c,Primary_Assignee__c, Name From 
	           												Provider_Group_Member__c Where (User__c!=null or Contact__c!=null) Limit 1000];
			Map<String, String[]> sortedEmails	= scToBiff.getSortedProviderGroupMembers(scToBiff.getStringOfEmails(pgMembers));
			callout.initiateAndScheduleRetry(testCase.Id, sortedEmails.get('NonBIFFList'));
		Test.stopTest();
    }
    
    private static testMethod void testRetryScheduler() {
    	List<Provider_Group_Member__c> pgMembers	=[Select User__c,Contact__c,User_Email__c,Provider_Group__c,Provider_Group__r.Name, 
            												First_Name__c,Last_Name__c,Send_Email__c,Primary_Assignee__c, Name From 
	           												Provider_Group_Member__c Where (User__c!=null or Contact__c!=null) Limit 1000];
	   	Test.startTest();
	   		ServiceCloudToBIFF scToBiff				= new ServiceCloudToBIFF();
    		List<String> emails						= scToBiff.getStringOfEmails(pgMembers);
    		ServiceCloudToBIFFCalloutRetry.retryScheduler(1, 3, 'abcdefghijklmnop', 1, emails);
    		ServiceCloudToBIFFCalloutRetry.retryScheduler(0, 0, 'abcdefghijklmnop', 1, emails);
	   	Test.stopTest();
    }
    
    private static testMethod void testCallBIFF() {
    	Case testCase = [Select c.OwnerId,
                				c.Id,							
                                c.Call_Tone__c,
                                c.CaseNumber,
                                c.Case_Call_Back__c,
								c.Product_Description__c,	
                                c.Case_Call_Back_Ext__c,
                                c.CC_Additional_Detail__c,
                                c.CC_Assignment_Group_1__c,
                                c.CC_Assignment_Group_2__c,
                                c.CC_Assignment_Group_3__c,
                                c.CC_Assignment_Group_4__c,
                                c.CC_Assignment_Group_1__r.Name,
                                c.CC_Assignment_Group_2__r.Name,
                                c.CC_Assignment_Group_3__r.Name,
                                c.CC_Assignment_Group_4__r.Name,
                                c.CC_Case_Creation_Notes__c,
                                c.CC_Case_Site__c,
                                c.CC_Case_Site_Name__c,
                                c.CC_Case_Site_Phone__c,
                                c.CC_Case_Site__r.Name,
                                c.CC_Case_Site__r.Store_number__c,
                                c.CC_Product_Dept_SubGroup__c,
                                c.CC_SubCategory1__c,
                                c.CC_SubCategory2__c,
                                c.CC_TM_Recognition_Name__c,
                                c.Consumer_Address__c,
                                c.Consumer_Name__c,
                                c.Consumer_Name__r.FirstName,
                                c.Consumer_Name__r.LastName,
                                c.Consumer_Phone__c,
                                c.Consumer_Email__c,
                                c.CreatedDate,
                                c.ContactId,
								c.Department__c,
                                c.Description,
                                c.Discontinued_Product__c,
                                c.Employee_Name__c,
                                c.Expiration_Date__c,
                                c.GEAC__c,
                                c.GEAC__r.Name,
                                c.Key_Word__c,
                                c.Lot_Number__c,
                                c.Name_of_Recall__c,
                                c.Name_of_Recall__r.Name,
                                c.Origin,
                                c.Other_Coding__c,
                                c.Owner.Name,
                                c.Owner.LastName,
                                c.Owner.FirstName,
                                c.Problem_Type__c,						
                                c.Primary_Assignee__c,
                                c.Product__c,
                                c.Product__r.Name,
                                c.Product__r.UPC_Code__c,
                                c.Product__r.CC_Product_Dept_SubGroup__c,
                                c.Product__r.Key_Word__c,
                                c.Product_Name__c,
                                c.Product_Size__c,
                                c.Product_Origin__c,
                                c.Ready_To_Email_Customer__c,
                                c.RecordTypeId,
                                c.Subject,
                                c.Status,
                                c.Type,
                                c.UPC_Available__c,
                                c.UPC_Code__c,
                                c.ParentId, c.Parent.casenumber,
                                c.Letter_Type__c, 
                                c.GC_Fulfillment_Status__c,
                                c.Gave_Gift_Card_Value__c,
                                c.Gave_Refund_DMB_Value__c,
                                c.X6_Month_Spend_at_Case_Total__c, 
                                c.Self_Recognition_EXTRA_MILE_Ticket__c,
                                c.X6_Month_Spend_at_Case_w_out_Gift_Cards__c
                           From Case c
                          Where c.CC_Assignment_Group_1__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_1__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_1__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_2__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_2__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_3__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_3__r.Name LIKE 'RX____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE'S____SMG' OR
                          		c.CC_Assignment_Group_4__r.Name LIKE 'G____' OR 
                          		c.CC_Assignment_Group_4__r.Name LIKE 'RX____' Limit 1];
    	Test.startTest();
    		ServiceCloudToBIFF scToBiff			= new ServiceCloudToBIFF(testCase);
    		if(scToBiff.isBIFFProviderGroup()) {
    			List<Provider_Group_Member__c> pgMembers=[Select User__c,Contact__c,User_Email__c,Provider_Group__c,Provider_Group__r.Name, 
            											First_Name__c,Last_Name__c,Send_Email__c,Primary_Assignee__c, Name From 
	           											Provider_Group_Member__c Where (User__c!=null or Contact__c!=null) Limit 1000];
	        	Map<String, String[]> sortedEmails	= scToBiff.getSortedProviderGroupMembers(scToBiff.getStringOfEmails(pgMembers));
	        	if(!scToBiff.callBiff(sortedEmails.get('NonBIFFList'))) {
	        		System.debug('BIFF call was NOT successful.  Retrying ');
	        		scToBiff.callBIFFRetry(testCase.Id, 1, sortedEmails.get('NonBIFFList'));
	        	} else {
	        		System.debug('BIFF call made successfully');
	        	}
	       		//
    		}
    	Test.stopTest();
    }
}