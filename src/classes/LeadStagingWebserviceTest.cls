@isTest
public with sharing class LeadStagingWebserviceTest {
	

	/*
	*  @Description : Method used to test the json webservice
	*/
	static testMethod void test_JSONWebservice(){
		Test.startTest();

		// Create accessKey
		Webservice_Settings__c webserviceSettings = new Webservice_Settings__c(Access_Key__c='abc123');
		insert webserviceSettings;

		// Set the values in the Rest context
		RestRequest req = new RestRequest();
		req.requestURI = '/services/apexrest/leadstaging';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(JSONParserTest.jsonString);
		req.addHeader('Content-Type','application/json');
		req.addParameter('access_key','abc123');
		RestContext.request = req;

		// Call the method
		LeadStagingWebService.createLeadStaging();

		// Check if lead statging record created successfully
		Lead_Staging__c leadStaging = [SELECT hasError__c, is_Normalized__c, Error_Message__c, Raw_Data__c FROM Lead_Staging__c LIMIT 1];

		System.assertNotEquals(null,leadStaging);
		System.assertEquals(false,leadStaging.hasError__c); 
		System.assertNotEquals(false,leadStaging.is_Normalized__c);
		System.assertEquals(null,leadStaging.Error_Message__c);
		System.assert(leadStaging.Raw_Data__c != '');
		Test.stopTest();
	}


	/*
	*  @Description : Method used to test the xml webservice
	*/
	static testMethod void test_XMLWebservice(){
		Test.startTest();

		// Create accessKey
		Webservice_Settings__c webserviceSettings = new Webservice_Settings__c(Access_Key__c='abc123');
		insert webserviceSettings;

		// Set the values in the Rest context
		RestRequest req = new RestRequest();
		req.requestURI = '/services/apexrest/leadstaging';
		req.httpMethod = 'POST';
		req.requestBody = Blob.valueof(XMLParserTest.xmlString);
		req.addHeader('Content-Type','application/xml');
		req.addParameter('access_key','abc123');
		RestContext.request = req;

		// Call the method
		LeadStagingWebService.createLeadStaging();

		// Check if lead statging record created successfully
		Lead_Staging__c leadStaging = [SELECT hasError__c, is_Normalized__c, Error_Message__c, Raw_Data__c FROM Lead_Staging__c LIMIT 1];

		System.assertNotEquals(null,leadStaging);
		System.assertEquals(false,leadStaging.hasError__c); 
		System.assertNotEquals(false,leadStaging.is_Normalized__c);
		System.assertEquals(null,leadStaging.Error_Message__c);
		System.assert(leadStaging.Raw_Data__c != '');
		Test.stopTest();
	}
}