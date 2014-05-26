/*
* 	@Class used to remove the reserved keywords (curreny, time..) from the json string
*/
public with sharing class ParserHelper {
	

	/*
	*	@Description : Method used to remove the time word from the json string
	*	@Return String formatted jsonString 
	*/
	public static String replaceTimeKeyWord(String jsonToFormat){
		return jsonToFormat.replaceAll('\"time\":','\"preferredtime\":'); 
	}
}