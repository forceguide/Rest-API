@isTest
public with sharing class JSONParserTest {
	
	public static String jsonString = '[{'+
										'\"sources\": ['+
										'{'+
										'\"id\": \"1\",'+
										'\"name\": \"autobyte1\"'+
										'},'+
										'{'+
										'\"id\": \"1\",'+
										'\"name\": \"autobyte1\"'+
										'}'+
										'],'+
										'\"requestdate\": \"2014-05-10T06:47:23-07:00\",'+
										'\"vehicle\": {'+
										'\"interest\": \"buy\",'+
										'\"status\": \"used\",'+
										'\"year\": 2012,'+
										'\"make\": \"Ford\",'+
										'\"model\": \"E-250\",'+
										'\"vin\": \"1FTNE2EW9DDA31598\",'+
										'\"stock\": \"XV1R73\",'+
										'\"trim\": \"Van 3D\",'+
										'\"doors\": 3,'+
										'\"bodystyle\": \"Cargo\",'+
										'\"transmission\": \"Automatic\",'+
										'\"odometerreading\": 2222,'+
										'\"odometerunits\": \"mi\",'+
										'\"colorcombination\": ['+
										'{'+
										'\"interiorcolor\": \"black\",'+
										'\"exteriorcolor\": \"blue\",'+
										'\"preference\": 1'+
										'}'+
										'],'+
										'\"pricetype\": \"cash\",'+
										'\"price\": 10022,'+
										'\"finance\": ['+
										'{'+
										'\"method\": \"cash\",'+
										'\"type\": \"downpayment\",'+
										'\"amount\": 10200'+
										'}'+
										']'+
										'},'+
										'\"customer\": {'+
										'\"contact\": {'+
										'\"firstname\": \"anis\",'+
										'\"lastname\": \"rabhi\",'+
										'\"email\": \"atest@test.com\",'+
										'\"phones\": ['+
										'{'+
										'\"type\": \"home\",'+
										'\"phone\": \"8881112222\"'+
										'},'+
										'{'+
										'\"type\": \"home\",'+
										'\"phone\": \"8882229999\"'+
										'}'+
										'],'+
										'\"address\": {'+
										'\"street\": \"7801 Algon Ave\",'+
										'\"city\": \"Philadelphia\",'+
										'\"regioncode\": \"PA\",'+
										'\"postalcode\": 19111,'+
										'\"country\": \"US\"'+
										'},'+
										'\"timeframe\": \"48 hrs\",'+
										'\"comments\": \"Note that this lead contains telephone numbers provided by the consumer. Before contacting the consumer by phone using automatic telephone dialing systems, SMS texts or artificial/prerecorded voice messages, we recommend you first consider your need to obtain the consumer\'s valid express prior written consent before using any of these methods of contact as required by the rules under the Telephone Consumer Protection Act.\"'+
										'}'+
										'},'+
										'\"vendor\": {'+
										'\"vendorid\": \"17R1\",'+
										'\"vendorsource\": \"enterprise\",'+
										'\"vendorname\": \"Enterprise Car Sales - Philly - Airport\",'+
										'\"contact\": {'+
										'\"firstname\": \"Internal Sales Rep\",'+
										'\"lastname\": \"Rep\",'+
										'\"email\": \"rep@enterprise.com\",'+
										'\"phones\": ['+
										'{'+
										'\"type\": \"office\",'+
										'\"phone\": \"8881112222\"'+
										'},'+
										'{'+
										'\"type\": \"mobile\",'+
										'\"phone\": \"8882229999\"'+
										'}'+
										'],'+
										'\"address\": {'+
										'\"street\": \"501 S Governor Printz BLVD\",'+
										'\"city\": \"Essington\",'+
										'\"regioncode\": \"PA\",'+
										'\"postalcode\": 19029,'+
										'\"country\": \"USA\"'+
										'}'+
										'}'+
										'},'+
										'\"provider\": {'+
										'\"id\": \"\",'+
										'\"name\": \"\",'+
										'\"service\": \"\",'+
										'\"url\": \"\",'+
										'\"email\": \"\",'+
										'\"phone\": \"\"'+
										'}'+
										'}]';

	
	/*
	*	@Description : Method used to test the json parser
	*/
	static testMethod void test_parseJSON(){
		Test.startTest();
		System.assert(JSONParser.parseJSON(jsonString));

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