public with sharing class XMLParser {
	

	/*
	*	@Description : Method used to parse the XML
	*	@Return Boolean returns true if parsed successfully or else vice-versa
	*/
	public static Boolean parseXML(String xmlString){
		Boolean isRecordCreatedSuccessfully = false; 
		
		// Initialize list to create
		List<LeadStagingHelper> leadStagingList = new List<LeadStagingHelper>();

		// Parse the XML
		Dom.Document document = new Dom.Document();
		document.load(xmlString);


		// Get the root element which is adf 
		Dom.XMLNode lead = document.getRootElement();

		// Get the child elements (List of prospect)
		for (Integer i=0;i<lead.getChildElements().size();i++){
			LeadStagingHelper leadStaging = new LeadStagingHelper();
			// Parse the prospect node
			parseProspect(lead.getChildElements()[i], leadStaging);

			// add the lead stating into the list
			leadStagingList.add(leadStaging);
		}

		// Check if leadStaging is not null 
		if (leadStagingList != null && leadStagingList.size() > 0) isRecordCreatedSuccessfully = LeadStagingCreator.createLeadStatingRecord(leadStagingList,xmlString);
		return isRecordCreatedSuccessfully;
	}

	/*
	*	@Description : Method used to parse the prospect node
	*	@Return void 
	*/
	public static void parseProspect(Dom.XMLNode prospect, LeadStagingHelper leadStaging){
		// Get the child elements of prospect

		leadStaging.sources = new List<LeadStagingHelper.sources>();

		for (Integer i=0;i<prospect.getChildElements().size();i++){

			// Check if it is a id element
			if (prospect.getChildElements()[i].getName() == 'id'){
				LeadStagingHelper.sources source = new LeadStagingHelper.sources();
				source.id = prospect.getChildElements()[i].getAttributeValue('sequence',null);
				source.name = prospect.getChildElements()[i].getAttributeValue('source',null);
				leadStaging.sources.add(source);
			}

			// Check if it is a requestdate element
			if (prospect.getChildElements()[i].getName() == 'requestdate'){
				leadStaging.requestdate = prospect.getChildElements()[i].getText();
			}

			// Check if it is a vehicle element
			if (prospect.getChildElements()[i].getName() == 'vehicle'){
				// Parse the vehicle node
				parseVehicle(prospect.getChildElements()[i], leadStaging);
			}

			// Check if it is a customer element
			if (prospect.getChildElements()[i].getName() == 'customer'){
				// Parse the customer node
				parseCustomer(prospect.getChildElements()[i], leadStaging);
			}

			// Check if it is a vendor element
			if (prospect.getChildElements()[i].getName() == 'vendor'){
				// Parse the vendor node
				parseVendor(prospect.getChildElements()[i], leadStaging);
			}

			// Check if it is a provider element
			if (prospect.getChildElements()[i].getName() == 'provider'){
				// Parse the provider node
				parseProvider(prospect.getChildElements()[i], leadStaging);
			}

		}
	}


	/*
	*	@Description : Method used to parse the vehicle node
	*	@Return void 
	*/
	public static void parseVehicle(Dom.XMLNode vehicle, LeadStagingHelper leadStaging){
		leadStaging.vehicle = new LeadStagingHelper.vehicle();
		leadStaging.vehicle.colorcombinationList = new List<LeadStagingHelper.colorcombination>();
		leadStaging.vehicle.imageTag = new LeadStagingHelper.imageTag();
		leadStaging.vehicle.optionList = new List<LeadStagingHelper.option>();

		// Get the vehicle information
		for (Integer i=0;i<vehicle.getChildElements().size();i++){

			// Get the vehicle interest and status
			leadStaging.vehicle.interest = vehicle.getAttributeValue('interest',null);
			leadStaging.vehicle.status = vehicle.getAttributeValue('status',null);

			// Get the vehicle year
			if (vehicle.getChildElements()[i].getName() == 'year'){
				leadStaging.vehicle.year = vehicle.getChildElements()[i].getText();
			}

			// Get the vehicle make
			if (vehicle.getChildElements()[i].getName() == 'make'){
				leadStaging.vehicle.make = vehicle.getChildElements()[i].getText();
			}

			// Get the vehicle model
			if (vehicle.getChildElements()[i].getName() == 'model'){
				leadStaging.vehicle.model = vehicle.getChildElements()[i].getText();
			}

			// Get the vehicle vin
			if (vehicle.getChildElements()[i].getName() == 'vin'){
				leadStaging.vehicle.vin = vehicle.getChildElements()[i].getText();
			}

			// Get the vehicle stock
			if (vehicle.getChildElements()[i].getName() == 'stock'){
				leadStaging.vehicle.stock = vehicle.getChildElements()[i].getText();
			}

			// Get the vehicle trim
			if (vehicle.getChildElements()[i].getName() == 'trim'){
				leadStaging.vehicle.trim = vehicle.getChildElements()[i].getText();
			}

			// Get the vehicle doors
			if (vehicle.getChildElements()[i].getName() == 'doors'){
				leadStaging.vehicle.doors = vehicle.getChildElements()[i].getText(); 
			}

			// Get the vehicle bodystyle
			if (vehicle.getChildElements()[i].getName() == 'bodystyle'){
				leadStaging.vehicle.bodystyle = vehicle.getChildElements()[i].getText();
			}

			// Get the vehicle transmission
			if (vehicle.getChildElements()[i].getName() == 'transmission'){
				leadStaging.vehicle.transmission = vehicle.getChildElements()[i].getText();
			}

			// Get the vehicle odometer
			if (vehicle.getChildElements()[i].getName() == 'odometer'){
				leadStaging.vehicle.odometer = vehicle.getChildElements()[i].getText();
				leadStaging.vehicle.status_x = vehicle.getChildElements()[i].getAttributeValue('status',null);
				leadStaging.vehicle.units = vehicle.getChildElements()[i].getAttributeValue('units',null);
			}

			// Get the colorcombination
			if (vehicle.getChildElements()[i].getName() == 'colorcombination'){
				leadStaging.vehicle.colorcombinationList.add(parseColourCombination(vehicle.getChildElements()[i]));
			}

			// Get the price information 
			if (vehicle.getChildElements()[i].getName() == 'price'){
				leadStaging.vehicle.price = vehicle.getChildElements()[i].getText();
				leadStaging.vehicle.type = vehicle.getChildElements()[i].getAttributeValue('type',null);
				leadStaging.vehicle.currency_x = vehicle.getChildElements()[i].getAttributeValue('currency',null);
				leadStaging.vehicle.delta = vehicle.getChildElements()[i].getAttributeValue('delta',null);
				leadStaging.vehicle.relativeto = vehicle.getChildElements()[i].getAttributeValue('relativeto',null);
				leadStaging.vehicle.source = vehicle.getChildElements()[i].getAttributeValue('source',null);
			}

			// Get the image tag 
			if (vehicle.getChildElements()[i].getName() == 'imagetag'){
				leadStaging.vehicle.imageTag.imageUrl = vehicle.getChildElements()[i].getText();
				leadStaging.vehicle.imageTag.width = vehicle.getChildElements()[i].getAttributeValue('width',null);
				leadStaging.vehicle.imageTag.height = vehicle.getChildElements()[i].getAttributeValue('height',null);
				leadStaging.vehicle.imageTag.alttext = vehicle.getChildElements()[i].getAttributeValue('alttext',null);
			}

			// Get the option information 
			if (vehicle.getChildElements()[i].getName() == 'option'){
				leadStaging.vehicle.optionList.add(parseOption(vehicle.getChildElements()[i]));
			}

			// Get the finance information 
			if (vehicle.getChildElements()[i].getName() == 'finance'){
				leadStaging.vehicle.financeInfo = parseFinance(vehicle.getChildElements()[i]);
			}

			// Get the comments  
			if (vehicle.getChildElements()[i].getName() == 'comments'){
				leadStaging.vehicle.comments = vehicle.getChildElements()[i].getText();
			}

		}
	} 


	/*
	*	@Description : Method used to parse the colorcombination node
	*	@Return void 
	*/
	public static LeadStagingHelper.colorcombination parseColourCombination(Dom.XMLNode colorCombination){
		LeadStagingHelper.colorcombination colorCombo = new LeadStagingHelper.colorcombination();
		
		// Get the colorcombination list 
		for (Integer i=0;i<colorCombination.getChildElements().size();i++){

			// Get the vehicle interiorcolor
			if (colorCombination.getChildElements()[i].getName() == 'interiorcolor'){
				colorCombo.interiorcolor = colorCombination.getChildElements()[i].getText();
			}

			// Get the vehicle exteriorcolor
			if (colorCombination.getChildElements()[i].getName() == 'exteriorcolor'){
				colorCombo.exteriorcolor = colorCombination.getChildElements()[i].getText();
			}

			// Get the vehicle preference
			if (colorCombination.getChildElements()[i].getName() == 'preference'){
				colorCombo.preference = colorCombination.getChildElements()[i].getText();
			}
		}
		return colorCombo;
	}

	/*
	*	@Description : Method used to parse the option node
	*	@Return void 
	*/
	public static LeadStagingHelper.option parseOption(Dom.XMLNode option){
		LeadStagingHelper.option optionInfo = new LeadStagingHelper.option();
		// Get the option list 
		for (Integer i=0;i<option.getChildElements().size();i++){
			// Get the option name
			if (option.getChildElements()[i].getName() == 'optionname'){
				optionInfo.optionname = option.getChildElements()[i].getText();
			}

			// Get the manufacturercode
			if (option.getChildElements()[i].getName() == 'manufacturercode'){
				optionInfo.manufacturercode = option.getChildElements()[i].getText();
			}

			// Get the weighting
			if (option.getChildElements()[i].getName() == 'weighting'){
				optionInfo.weighting = option.getChildElements()[i].getText();
			}

			// Get the weighting
			if (option.getChildElements()[i].getName() == 'stock'){
				optionInfo.stock = option.getChildElements()[i].getText();
			}
		}
		return optionInfo;
	}

	/*
	*	@Description : Method used to parse the finance node
	*	@Return void 
	*/
	public static LeadStagingHelper.finance parseFinance(Dom.XMLNode finance){
		LeadStagingHelper.finance financeInfo = new LeadStagingHelper.finance();
		financeInfo.amountList = new List<LeadStagingHelper.Amount>();

		// Get the finance information
		for (Integer i=0;i<finance.getChildElements().size();i++){

			// Get the method name
			if (finance.getChildElements()[i].getName() == 'method'){
				financeInfo.method = finance.getChildElements()[i].getText();
			}

			// Get the amount
			if (finance.getChildElements()[i].getName() == 'amount'){
				LeadStagingHelper.Amount amountInfo = new LeadStagingHelper.Amount();
				amountInfo.amount = finance.getChildElements()[i].getText();
				amountInfo.type = finance.getChildElements()[i].getAttributeValue('type',null);
				amountInfo.limit_x = finance.getChildElements()[i].getAttributeValue('limit',null);
				amountInfo.currency_x = finance.getChildElements()[i].getAttributeValue('currency',null);
				financeInfo.amountList.add(amountInfo);
			}

			// Get the balance
			if (finance.getChildElements()[i].getName() == 'balance'){
				LeadStagingHelper.Balance balance = new LeadStagingHelper.Balance();
				balance.balance = finance.getChildElements()[i].getText();
				balance.type = finance.getChildElements()[i].getText();
				balance.currency_x = finance.getChildElements()[i].getText();
				financeInfo.balance = balance;
			}
		}
		return financeInfo;
	}


	/*
	*	@Description : Method used to parse the customer node
	*	@Return void 
	*/
	public static void parseCustomer(Dom.XMLNode customer, LeadStagingHelper leadStaging){
		leadStaging.customer = new LeadStagingHelper.customer();

		// Get the customer information
		for (Integer i=0;i<customer.getChildElements().size();i++){

			// Get the contact
			if (customer.getChildElements()[i].getName() == 'contact'){
				leadStaging.customer.contact = parseContact(customer.getChildElements()[i]);
			}

			// Get the timeframce
			if (customer.getChildElements()[i].getName() == 'timeframe'){
				leadStaging.customer.timeframe = new LeadStagingHelper.timeframe();
				leadStaging.customer.timeframe.timeframe = customer.getChildElements()[i].getText();
				leadStaging.customer.timeframe.description = (customer.getChildElements()[i].getChildElements().size() > 0 ? customer.getChildElements()[i].getChildElements()[0].getText() : '');
			}

			// Get the comments
			if (customer.getChildElements()[i].getName() == 'comments'){
				leadStaging.customer.comments = customer.getChildElements()[i].getText();
			}

		}
	} 


	/*
	*	@Description : Method used to parse the contact node
	*	@Return void 
	*/
	public static LeadStagingHelper.contact parseContact(Dom.XMLNode contact){
		LeadStagingHelper.contact contactInfo = new LeadStagingHelper.contact();
		contactInfo.phones = new List<LeadStagingHelper.phones>();

		// Get the contact information
		for (Integer i=0;i<contact.getChildElements().size();i++){

			// Get the  name
			if (contact.getChildElements()[i].getName() == 'name'){
				if (contact.getChildElements()[i].getAttributeValue('part',null) == 'first'){
					contactInfo.firstName = contact.getChildElements()[i].getText();
				}else if (contact.getChildElements()[i].getAttributeValue('part',null) == 'last'){
					contactInfo.lastName = contact.getChildElements()[i].getText();
				}
			}

			// Get the email
			if (contact.getChildElements()[i].getName() == 'email'){
				contactInfo.email = contact.getChildElements()[i].getText();
			}

			// Get the phones
			if (contact.getChildElements()[i].getName() == 'phone'){
				LeadStagingHelper.phones phoneInfo = new LeadStagingHelper.phones();
				phoneInfo.type = contact.getChildElements()[i].getAttributeValue('type',null);
				phoneInfo.preferredtime = contact.getChildElements()[i].getAttributeValue('time',null);
				phoneInfo.preferredcontact = contact.getChildElements()[i].getAttributeValue('preferredcontact',null);
				phoneInfo.phone = contact.getChildElements()[i].getText();
				contactInfo.phones.add(phoneInfo);
			}

			// Get the email
			if (contact.getChildElements()[i].getName() == 'address'){
				contactInfo.address = parseAddress(contact.getChildElements()[i]);
			}

		}  
		return contactInfo; 
	}


	/*
	*	@Description : Method used to parse the address node
	*	@Return void 
	*/
	public static LeadStagingHelper.address parseAddress(Dom.XMLNode address){
		LeadStagingHelper.address addressInfo = new LeadStagingHelper.address();

		// Get the address information
		for (Integer i=0;i<address.getChildElements().size();i++){
			// Get the street 
			if (address.getChildElements()[i].getName() == 'street'){
				addressInfo.street = address.getChildElements()[i].getText();
			}

			// Get the type 
			if (address.getChildElements()[i].getName() == 'type'){
				addressInfo.type = address.getChildElements()[i].getText();
			}

			// Get the city 
			if (address.getChildElements()[i].getName() == 'city'){
				addressInfo.city = address.getChildElements()[i].getText();
			}

			// Get the regioncode 
			if (address.getChildElements()[i].getName() == 'regioncode'){
				addressInfo.regioncode = address.getChildElements()[i].getText();
			}

			// Get the postalcode 
			if (address.getChildElements()[i].getName() == 'postalcode'){
				addressInfo.postalcode = address.getChildElements()[i].getText();
			}

			// Get the country 
			if (address.getChildElements()[i].getName() == 'country'){
				addressInfo.country = address.getChildElements()[i].getText();
			}

			// Get the street 
			if (address.getChildElements()[i].getName() == 'street'){
				addressInfo.street = address.getChildElements()[i].getText();
			}

			// Get the url 
			if (address.getChildElements()[i].getName() == 'url'){
				addressInfo.url = address.getChildElements()[i].getText();
			}
		}

		return addressInfo;
	}



	/*
	*	@Description : Method used to parse the vendor node
	*	@Return void 
	*/
	public static void parseVendor(Dom.XMLNode vendor, LeadStagingHelper leadStaging){
		leadStaging.vendor = new LeadStagingHelper.vendor();

		// Get the vendor information
		for (Integer i=0;i<vendor.getChildElements().size();i++){
			// Get the vendor id  
			if (vendor.getChildElements()[i].getName() == 'id'){
				leadStaging.vendor.vendorid = vendor.getChildElements()[i].getText();
				leadStaging.vendor.vendorsource = vendor.getChildElements()[i].getAttributeValue('source',null);
			}

			// Get the vendorname 
			if (vendor.getChildElements()[i].getName() == 'vendorname'){
				leadStaging.vendor.vendorname  = vendor.getChildElements()[i].getText();
			}

			// Get the contact 
			if (vendor.getChildElements()[i].getName() == 'contact'){
				leadStaging.vendor.contact = parseContact(vendor.getChildElements()[i]);
			}
		}
	}


	/*
	*	@Description : Method used to parse the provider node
	*	@Return void 
	*/
	public static void parseProvider(Dom.XMLNode provider, LeadStagingHelper leadStaging){
		leadStaging.provider = new LeadStagingHelper.provider();

		// Get the provider information
		for (Integer i=0;i<provider.getChildElements().size();i++){

			// Get the provider id  
			if (provider.getChildElements()[i].getName() == 'id'){
				leadStaging.provider.id = provider.getChildElements()[i].getText();
			}

			// Get the provider name 
			if (provider.getChildElements()[i].getName() == 'name'){
				leadStaging.provider.name  = provider.getChildElements()[i].getText();
			}

			// Get the service 
			if (provider.getChildElements()[i].getName() == 'service'){
				leadStaging.provider.service = provider.getChildElements()[i].getText();
			}

			// Get the url 
			if (provider.getChildElements()[i].getName() == 'url'){
				leadStaging.provider.url = provider.getChildElements()[i].getText();
			}

			// Get the email 
			if (provider.getChildElements()[i].getName() == 'email'){
				leadStaging.provider.email = provider.getChildElements()[i].getText();
			}

			// Get the phone 
			if (provider.getChildElements()[i].getName() == 'phone'){
				leadStaging.provider.phone = provider.getChildElements()[i].getText();
			}

			// Get the contact 
			if (provider.getChildElements()[i].getName() == 'contact'){
				leadStaging.provider.contact = parseContact(provider.getChildElements()[i]);
			}
		}
	}

}