@isTest
public with sharing class XMLParserTest {
		
	public static String xmlString = 	'<adf>'+
										'<prospect>'+
										'<id sequence=\"1\" source=\"Autobytel\">61578882</id>'+
										'<id sequence=\"2\" source=\"Autobytel\">1848</id>'+
										'<requestdate>2014-05-10T06:47:23-07:00</requestdate>'+
										'<vehicle interest=\"buy\" status=\"used\">'+
										'<year>2013</year>'+
										'<make>Ford</make>'+
										'<model>E-250</model>'+
										'<vin>1FTNE2EW9DDA31598</vin>'+
										'<stock>XV1R73</stock>'+
										'<trim>Van 3D</trim>'+
										'<doors>3</doors>'+
										'<bodystyle>Cargo Van</bodystyle>'+
										'<transmission>Automatic</transmission>'+
										'<odometer units=\"mi\">4473</odometer>'+
										'<colorcombination>'+
										'<interiorcolor>Gray</interiorcolor>'+
										'<exteriorcolor>White</exteriorcolor>'+
										'<preference>1</preference>'+
										'</colorcombination>'+
										'<option>'+
										'<optionname>Keyless Entry</optionname>'+
										'<manufacturercode>p395</manufacturercode>'+
										'<weighting>100</weighting>'+
										'</option>'+
										'<imagetag width=\"100\" height=\"120\" alttext=\"1997 HondaAccord\">http://www.something.org/accord.jpg</imagetag>'+
										'<price type=\"offer\">22999.00</price>'+
										'<finance>'+
										'<method>cash</method>'+
										'<amount type=\"downpayment\">0.00</amount>'+
										'<balance type=\"residual\" currency=\"USD\">2000</balance>'+
										'</finance>'+
										'</vehicle>'+
										'<customer>'+
										'<contact>'+
										'<name part=\"first\">anis</name>'+
										'<name part=\"last\">rabhi</name>'+
										'<email>mahdinoure45@gmail.com</email>'+
										'<phone type=\"voice\" time=\"nopreference\" preferredcontact=\"1\">347-323-9376</phone>'+
										'<phone type=\"voice\">347-323-9376</phone>'+
										'<address>'+
										'<street line=\"1\">7801 ALGON AVE</street>'+
										'<city>Philadelphia</city>'+
										'<regioncode>PA</regioncode>'+
										'<postalcode>19111</postalcode>'+
										'<country>USA</country>'+
										'</address>'+
										'</contact>'+
										'<timeframe>48 hours</timeframe>'+
										'<comments>'+
										'Note that this lead contains telephone numbers provided by the consumer. Before contacting the consumer by phone using automatic telephone dialing systems, SMS texts or artificial/prerecorded voice messages, we recommend you first consider your need to obtain the consumer\'s valid express prior written consent before using any of these methods of contact as required by the rules under the Telephone Consumer Protection Act.'+
										'</comments>'+
										'</customer>'+
										'<vendor>'+
										'<id sequence=\"1\" source=\"enterprise\">17R1</id>'+
										'<vendorname>Enterprise Car Sales - Philly - Airport</vendorname>'+
										'<contact>'+
										'<name part=\"firstname\">Internet Sales Representative</name>'+
										'<phone type=\"voice\">610-521-3501</phone>'+
										'<address>'+
										'<street line=\"1\">501 S Governor Printz BLVD</street>'+
										'<city>Essington</city>'+
										'<regioncode>PA</regioncode>'+
										'<postalcode>19029</postalcode>'+
										'<country>USA</country>'+
										'</address>'+
										'</contact>'+
										'</vendor>'+
										'<provider>'+
										'<id>gfs42</id>'+
										'<name part=\"first\"></name>'+
										'<service></service>'+
										'<url>www.test.com</url>'+
										'<email>test.support@demo.com</email>'+
										'<phone>4879637</phone>'+
										'<contact primarycontact=\"1\">'+
										'<name part=\"first\">Fred Jones</name>'+
										'<email>support@carpoint.com</email>'+
										'<phone type=\"voice\" time=\"day\">425-253-2222</phone>'+
										'<phone type=\"fax\" time=\"day\">393-991-2999</phone>'+
										'<address>'+
										'<street line=\"1\">One Microsoft Way</street>'+
										'<street line=\"2\">Building 8</street>'+
										'<city>Redmond</city>'+
										'<regioncode>WA</regioncode>'+
										'<postalcode>98052</postalcode>'+
										'<country>US</country>'+
										'</address>'+
										'</contact>'+
										'</provider>'+
										'</prospect>'+
										'</adf>';

	
	/*
	*	@Description : Method used to test the xml parser
	*/
	static testMethod void test_parseXML(){
		Test.startTest();
		System.assert(XMLParser.parseXML(xmlString));

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