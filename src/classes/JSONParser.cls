public with sharing class JSONParser {
	

	/*
	*	@Description : Method used to parse the JSON
	*	@Return Boolean returns true if parsed successfully or else vice-versa
	*/
	public static Boolean parseJSON(String jsonString){
		Boolean isRecordCreatedSuccessfully = false;

		// Parse the json string
		List<LeadStagingHelper> leadStagingList = (List<LeadStagingHelper>)JSON.deserialize(jsonString, List<LeadStagingHelper>.class);

		// Check if leadStaging is not null 
		if (leadStagingList != null && leadStagingList.size() > 0) isRecordCreatedSuccessfully = LeadStagingCreator.createLeadStatingRecord(leadStagingList,jsonString);
		
		return isRecordCreatedSuccessfully; 
	}
}