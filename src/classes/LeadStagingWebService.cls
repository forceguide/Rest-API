@RestResource(urlMapping='/leadstaging/*')
global with sharing class LeadStagingWebService {

	/*
	*	@Description : Method used to create Lead staging record 
	*	@Return String successMessage if record created successfully
	*/
	@HttpPost
    global static String createLeadStaging(){
       	RestRequest request = RestContext.request;
       	LeadStagingHelper leadstagingHelper; 
       	String contentType = '';
       	Boolean recordCreated = false;

       	if (checkAccessKey(request)){
	       	// Check the content type 
	       	if (request.headers != null){
	       		for (String headerKey : request.headers.keySet()){
	       			if (headerKey.toLowerCase() == 'content-type'){
	       				contentType = request.headers.get(headerKey).toLowerCase();
	       			}
	       		}	
	       	}

	       	// paese the data based on its content type 
	       	if (contentType == 'application/json'){
	       		recordCreated = JSONParser.parseJSON(request.requestBody.toString());
	       	}else if(contentType == 'application/xml'){
	       		recordCreated = XMLParser.parseXML(request.requestBody.toString());
	       	}
       	}
       	return (recordCreated ? Label.Success_Message : Label.Error_Message);
    }

    /*
	*	@Description : Method used to check the accessKey matches with the access key in the system
	*	@Return Boolean true if access key matches else vice-versa
	*/
    global static Boolean checkAccessKey(RestRequest request){
    	Boolean isAccessKeyMatches = false;
    	Webservice_Settings__c webServiceSettings = Webservice_Settings__c.getOrgDefaults();

    	// Check webservice settings are not null
    	if (webServiceSettings != null && webServiceSettings.Access_Key__c != null && request.params.get('access_key') != null){
    		if (request.params.get('access_key') == webServiceSettings.Access_Key__c) isAccessKeyMatches = true;
    	}
    	return isAccessKeyMatches;
    }
}