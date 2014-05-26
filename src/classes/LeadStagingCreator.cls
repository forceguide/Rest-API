/*
*	Class used to create Lead statging record
*/
public with sharing class LeadStagingCreator {


	/*
	*	@Description : Method used to create a new lead stating creator
	*	@Return Boolean returns true if lead staging record created successfully 
	*/
	public static Boolean createLeadStatingRecord(List<LeadStagingHelper> leadStagingList, String rawData){
		Boolean isRecordCreatedSuccessfully = false;
		List<Lead_Staging__c> leadStatgingRecordList = new List<Lead_Staging__c>();

		try{
			for (LeadStagingHelper leadStaging : leadStagingList){
				Lead_Staging__c leadStatgingRecord = new Lead_Staging__c();
				// Set prospect Information 
				setProspectInformation(leadStaging,leadStatgingRecord);
				leadStatgingRecord.is_Normalized__c = true;
				leadStatgingRecord.Raw_Data__c = rawData;
				leadStatgingRecordList.add(leadStatgingRecord);
			}
		}catch(Exception ex){
			Lead_Staging__c leadStatgingRecord = new Lead_Staging__c();
			leadStatgingRecord.Error_Message__c = ex.getMessage();
			leadStatgingRecord.hasError__c = true;
			leadStatgingRecordList.add(leadStatgingRecord);
		}
		
		
		// Create prospect Info
		insert leadStatgingRecordList;

		if (leadStatgingRecordList.size() > 0 && leadStatgingRecordList[0].Id != null) isRecordCreatedSuccessfully = true;

		// Return the message
		return isRecordCreatedSuccessfully; 
	}


	/*
	*	@Description : Method used to set the prospect information from the LeadstagingHelper derserialized object to lead staging object
	*	@Return void 
	*/
	private static void setProspectInformation(LeadStagingHelper leadStaging, Lead_Staging__c leadStatgingRecord){
		// Set the values 
		leadStatgingRecord.Source_Id__c = (leadStaging.sources.size() > 0 ? leadStaging.sources[0].id : '');
		leadStatgingRecord.Source_Name__c = (leadStaging.sources.size() > 0 ? leadStaging.sources[0].name : '');

		// requested Date
		leadStatgingRecord.Request_Date__c = leadStaging.requestdate;

		// Set the vehicle information
		setVehicleInformation(leadStaging.vehicle,leadStatgingRecord);

		// Set the customer information 
		setCustomerInformation(leadStaging.customer,leadStatgingRecord);

		// Set the vendor information 
		setVendorInformation(leadStaging.vendor,leadStatgingRecord);

		// Set the provider information 
		setProviderInformation(leadStaging.provider,leadStatgingRecord);
	}


	/*
	*	@Description : Method used to set the vehicle information from the LeadstagingHelper derserialized object to lead staging object
	*	@Return void 
	*/
	private static void setVehicleInformation(LeadStagingHelper.vehicle vehicle, Lead_Staging__c leadStatgingRecord){

		// Set the values 
		leadStatgingRecord.Vehicle_Interest__c = vehicle.interest;
		leadStatgingRecord.Vehicle_Status__c = vehicle.status;
		leadStatgingRecord.Vehicle_Id__c = vehicle.id;
		leadStatgingRecord.Vehicle_Year__c = vehicle.year;
		leadStatgingRecord.Vehicle_Make__c = vehicle.make;
		leadStatgingRecord.Vehicle_Model__c = vehicle.model;
		leadStatgingRecord.Vehicle_VIN__c = vehicle.vin;
		leadStatgingRecord.Vehicle_Stock__c = vehicle.stock;
		leadStatgingRecord.Vehicle_Trim__c = vehicle.trim;
		leadStatgingRecord.Vehicle_Doors__c = vehicle.doors;
		leadStatgingRecord.Vehicle_BodyStyle__c = vehicle.bodystyle;
		leadStatgingRecord.Vehicle_Transmission__c = vehicle.transmission;
		leadStatgingRecord.Vehicle_Condition__c = vehicle.condition;

		// Color Combination 
		if (vehicle.colorcombinationList != null && vehicle.colorcombinationList.size() > 0){
			leadStatgingRecord.Vehicle_Exterior_Color__c = vehicle.colorcombinationList[0].interiorcolor;
			leadStatgingRecord.Vehicle_Interior_Color__c = vehicle.colorcombinationList[0].exteriorcolor;
			leadStatgingRecord.Vehicle_Preference__c = vehicle.colorcombinationList[0].preference;
		}

		// Image tag
		if (vehicle.imageTag != null){
			leadStatgingRecord.Vehicle_Image_Width__c = vehicle.imageTag.width;
			leadStatgingRecord.Vehicle_Image_Height__c = vehicle.imageTag.height;
			leadStatgingRecord.Vehicle_Image_Alttext__c = vehicle.imageTag.alttext;
			leadStatgingRecord.Vehicle_Image_Url__c = vehicle.imageTag.imageUrl;
		}

		leadStatgingRecord.Vehicle_Type__c = vehicle.type;
		leadStatgingRecord.Vehicle_Price__c = Decimal.valueOf(vehicle.price);
		leadStatgingRecord.Vehicle_Currency__c = vehicle.currency_x;
		leadStatgingRecord.Vehicle_Delta__c = vehicle.delta;
		leadStatgingRecord.Vehicle_Relative_To__c = vehicle.relativeto;
		leadStatgingRecord.Vehicle_Source__c = vehicle.source;

		// option List
		if (vehicle.optionList != null && vehicle.optionList.size() > 0){
			leadStatgingRecord.Vehicle_Option_Name__c = vehicle.optionList[0].optionname;
			leadStatgingRecord.Vehicle_Manufacturer_Code__c = vehicle.optionList[0].manufacturercode;
			leadStatgingRecord.Vehicle_Stock__c = vehicle.optionList[0].stock;
			leadStatgingRecord.Vehicle_Weighting__c = vehicle.optionList[0].weighting;
		}

		// finanace Information
		if (vehicle.financeInfo != null){
			leadStatgingRecord.Vehicle_FInance_Method__c = vehicle.financeInfo.method;

			// Amount Information
			if (vehicle.financeInfo.amountList != null && vehicle.financeInfo.amountList.size() > 0){
				leadStatgingRecord.Vehicle_Amount__c = vehicle.financeInfo.amountList[0].amount;
				leadStatgingRecord.Vehicle_Amount_Type__c = vehicle.financeInfo.amountList[0].type;
				leadStatgingRecord.Vehicle_Amount_Currency__c = vehicle.financeInfo.amountList[0].currency_x;
				leadStatgingRecord.Vehicle_Amount_Limit__c = vehicle.financeInfo.amountList[0].limit_x;
			}

			// Balance Information 
			if (vehicle.financeInfo.balance != null){
				leadStatgingRecord.Vehicle_Balance__c = vehicle.financeInfo.balance.balance;
				leadStatgingRecord.Vehicle_Balance_Type__c = vehicle.financeInfo.balance.type;
				leadStatgingRecord.Vehicle_Balance_Currency__c = vehicle.financeInfo.balance.currency_x;
			}
		}

		leadStatgingRecord.Vehicle_Interest__c = vehicle.comments;
	}


	/*
	*	@Description : Method used to set the customer information from the LeadstagingHelper derserialized object to lead staging object
	*	@Return void 
	*/
	private static void setCustomerInformation(LeadStagingHelper.customer customer, Lead_Staging__c leadStatgingRecord){

		// Get the contact information 
		if (customer.contact != null){
			leadStatgingRecord.Customer_Primary_Contact__c = customer.contact.primarycontact;
			leadStatgingRecord.Customer_First_Name__c = customer.contact.firstName;
			leadStatgingRecord.Customer_Last_Name__c = customer.contact.lastName;
			leadStatgingRecord.Customer_part__c = customer.contact.part;
			leadStatgingRecord.Customer_Type__c = customer.contact.type;
			leadStatgingRecord.Customer_Email__c = customer.contact.email;
			
			// Get the phones list 
			if (customer.contact.phones != null){

				// Get the contact's first phone detail 
				if (customer.contact.phones != null && customer.contact.phones.size() > 0){
					leadStatgingRecord.Customer_Phone1_type__c = customer.contact.phones[0].type;
					leadStatgingRecord.Customer_Phone1_phone__c = customer.contact.phones[0].phone;
					leadStatgingRecord.Customer_Phone1_preferredtime__c = customer.contact.phones[0].preferredtime;
					leadStatgingRecord.Customer_Phone1_preferredcontact__c = customer.contact.phones[0].preferredcontact;
				}

				// Get the contact's first phone detail 
				if (customer.contact.phones != null && customer.contact.phones.size() > 1){
					leadStatgingRecord.Customer_Phone2_type__c = customer.contact.phones[1].type;
					leadStatgingRecord.Customer_Phone2_phone__c = customer.contact.phones[1].phone;
					leadStatgingRecord.Customer_Phone_2_preferredtime__c = customer.contact.phones[1].preferredtime;
					leadStatgingRecord.Customer_Phone_2_preferredcontact__c = customer.contact.phones[1].preferredcontact;
				}
			}

			// Get the address information 
			if (customer.contact.address != null){
				leadStatgingRecord.Customer_Address_Street__c = customer.contact.address.street;
				leadStatgingRecord.Customer_Address_Type__c = customer.contact.address.type;
				leadStatgingRecord.Customer_Address_apartment__c = customer.contact.address.apartment;
				leadStatgingRecord.Customer_Address_City__c = customer.contact.address.city;
				leadStatgingRecord.Customer_Address_Region_Code__c = customer.contact.address.regioncode;
				leadStatgingRecord.Customer_Address_Postal_Code__c = customer.contact.address.postalcode;
				leadStatgingRecord.Customer_Address_Country__c = customer.contact.address.country;
				leadStatgingRecord.Customer_Address_Url__c = customer.contact.address.url;
			}
		}

		// Get the timeframe information 
		if (customer.timeframe != null){
			leadStatgingRecord.Customer_Timeframe__c = customer.timeframe.timeframe;
			leadStatgingRecord.Customer_Timeframe_Description__c = customer.timeframe.description;
		}

		leadStatgingRecord.Customer_Comments__c = customer.comments;
	}

	/*
	*	@Description : Method used to set the vendor information from the LeadstagingHelper derserialized object to lead staging object
	*	@Return void 
	*/
	private static void setVendorInformation(LeadStagingHelper.vendor vendor, Lead_Staging__c leadStatgingRecord){

		leadStatgingRecord.Vendor_Id__c = vendor.vendorid;
		leadStatgingRecord.Vendor_Source__c = vendor.vendorsource;
		leadStatgingRecord.Vendor_Name__c = vendor.vendorname;

		// Get the contact information 
		if (vendor.contact != null){
			leadStatgingRecord.Vendor_Primary_Contact__c = vendor.contact.primarycontact;
			leadStatgingRecord.Vendor_First_Name__c = vendor.contact.firstName;
			leadStatgingRecord.Vendor_Last_Name__c = vendor.contact.lastName;
			leadStatgingRecord.Vendor_part__c = vendor.contact.part;
			leadStatgingRecord.Vendor_Type__c = vendor.contact.type;
			leadStatgingRecord.Vendor_Email__c = vendor.contact.email;
			
			// Get the phones list 
			if (vendor.contact.phones != null){

				// Get the contact's first phone detail 
				if (vendor.contact.phones != null && vendor.contact.phones.size() > 0){
					leadStatgingRecord.Vendor_Phone1_type__c = vendor.contact.phones[0].type;
					leadStatgingRecord.Vendor_Phone1_phone__c = vendor.contact.phones[0].phone;
					leadStatgingRecord.Vendor_Phone1_preferredtime__c = vendor.contact.phones[0].preferredtime;
					leadStatgingRecord.Vendor_Phone1_preferredcontact__c = vendor.contact.phones[0].preferredcontact;
				}

				// Get the contact's first phone detail 
				if (vendor.contact.phones != null && vendor.contact.phones.size() > 1){
					leadStatgingRecord.Vendor_Phone2_type__c = vendor.contact.phones[1].type;
					leadStatgingRecord.Vendor_Phone2_phone__c = vendor.contact.phones[1].phone;
					leadStatgingRecord.Vendor_Phone_2_preferredtime__c = vendor.contact.phones[1].preferredtime;
					leadStatgingRecord.Vendor_Phone_2_preferredcontact__c = vendor.contact.phones[1].preferredcontact;
				}
			}

			// Get the address information 
			if (vendor.contact.address != null){
				leadStatgingRecord.Vendor_Address_Street__c = vendor.contact.address.street;
				leadStatgingRecord.Vendor_Address_Type__c = vendor.contact.address.type;
				leadStatgingRecord.Vendor_Address_apartment__c = vendor.contact.address.apartment;
				leadStatgingRecord.Vendor_Address_City__c = vendor.contact.address.city;
				leadStatgingRecord.Vendor_Address_Region_Code__c = vendor.contact.address.regioncode;
				leadStatgingRecord.Vendor_Address_Postal_Code__c = vendor.contact.address.postalcode;
				leadStatgingRecord.Vendor_Address_Country__c = vendor.contact.address.country;
				leadStatgingRecord.Vendor_Address_Url__c = vendor.contact.address.url;
			}

			leadStatgingRecord.Vendor_Comments__c = vendor.contact.comments;
		}
	}

	/*
	*	@Description : Method used to set the provider information from the LeadstagingHelper derserialized object to lead staging object
	*	@Return void 
	*/
	private static void setProviderInformation(LeadStagingHelper.provider provider, Lead_Staging__c leadStatgingRecord){

		leadStatgingRecord.Provider_Id__c = provider.id;
		leadStatgingRecord.Provider_Name__c = provider.name;
		leadStatgingRecord.Provider_Service__c = provider.service;
		leadStatgingRecord.Provider_URL__c = provider.url;
		leadStatgingRecord.Provider_Email__c = provider.email;
		leadStatgingRecord.Provider_Phone__c = provider.phone;

		// Get the contact information 
		if (provider.contact != null){
			leadStatgingRecord.Provider_Primary_Contact__c = provider.contact.primarycontact;
			leadStatgingRecord.Provider_First_Name__c = provider.contact.firstName;
			leadStatgingRecord.Provider_Last_Name__c = provider.contact.lastName;
			leadStatgingRecord.Provider_part__c = provider.contact.part;
			leadStatgingRecord.Provider_Type__c = provider.contact.type;
			leadStatgingRecord.Provider_Email__c = provider.contact.email;
			
			// Get the phones list 
			if (provider.contact.phones != null){

				// Get the contact's first phone detail 
				if (provider.contact.phones != null && provider.contact.phones.size() > 0){
					leadStatgingRecord.Provider_Phone1_type__c = provider.contact.phones[0].type;
					leadStatgingRecord.Provider_Phone1_phone__c = provider.contact.phones[0].phone;
					leadStatgingRecord.Provider_Phone1_preferredtime__c = provider.contact.phones[0].preferredtime;
					leadStatgingRecord.Provider_Phone1_preferredcontact__c = provider.contact.phones[0].preferredcontact;
				}

				// Get the contact's first phone detail 
				if (provider.contact.phones != null && provider.contact.phones.size() > 1){
					leadStatgingRecord.Provider_Phone2_type__c = provider.contact.phones[1].type;
					leadStatgingRecord.Provider_Phone2_phone__c = provider.contact.phones[1].phone;
					leadStatgingRecord.Provider_Phone_2_preferredtime__c = provider.contact.phones[1].preferredtime;
					leadStatgingRecord.Provider_Phone_2_preferredcontact__c = provider.contact.phones[1].preferredcontact;
				}
			}

			// Get the address information 
			if (provider.contact.address != null){
				leadStatgingRecord.Provider_Address_Street__c = provider.contact.address.street;
				leadStatgingRecord.Provider_Address_Type__c = provider.contact.address.type;
				leadStatgingRecord.Provider_Address_apartment__c = provider.contact.address.apartment;
				leadStatgingRecord.Provider_Address_City__c = provider.contact.address.city;
				leadStatgingRecord.Provider_Address_Region_Code__c = provider.contact.address.regioncode;
				leadStatgingRecord.Provider_Address_Postal_Code__c = provider.contact.address.postalcode;
				leadStatgingRecord.Provider_Address_Country__c = provider.contact.address.country;
				leadStatgingRecord.Provider_Address_Url__c = provider.contact.address.url; 
			}

			leadStatgingRecord.Provider_Comments__c = provider.contact.comments;
		}
	}
}