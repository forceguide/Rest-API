/*
*	@Description: Class holds the structure for Lead stating object
*/
public class LeadStagingHelper  {
	
	public List<sources> sources;
	public String requestdate;
	public vehicle vehicle;
	public customer customer;
	public vendor vendor;
	public provider provider;

	public class sources{
		public String id;
		public String name;
	}

	public class vehicle{
		public String interest;
		public String status;
		public String id;
		public String year;
		public String make;
		public String model;
		public String vin;
		public String stock;
		public String trim;
		public String doors;
		public String bodystyle;
		public String transmission;
		public String odometer;
		public String status_x;
		public String units;
		public String condition;
		public List<colorcombination> colorcombinationList;
		public imageTag imageTag;
		public String type;
		public String price;
		public String currency_x;
		public String delta;
		public String relativeto;
		public String source;
		public List<option> optionList;
		public finance financeInfo;
		public String comments;
	}


	public class colorcombination{
		public String interiorcolor;
		public String exteriorcolor;
		public String preference;
	}

	public class option{
		public String optionname;
		public String manufacturercode;
		public String stock;
		public String weighting;
	}

	public class finance{
		public String method;
		public List<Amount> amountList;
		public Balance balance;
	}

	public class Balance{
		public String balance;
		public String type;
		public String currency_x;
	}

	public class Amount{
		public String amount;
		public String type;
		public String currency_x;
		public String limit_x;
	}

	public class imageTag{
		public String width;
		public String height;
		public String alttext;
		public String imageUrl;
	}

	public class customer{
		public contact contact;
		public timeframe timeframe;
		public String comments;
	}	

	public class contact{
		public String primarycontact;
		public String firstName;
		public String lastName;
		public String part;
		public String type;
		public String email;
		public List<phones> phones;
		public address address;
		public String timeframe;
		public String comments;
	}

	public class timeframe{
		public String timeframe;
		public String description;
	}

	public class phones{
		public String type;
		public String phone;
		public String preferredtime;
		public String preferredcontact;
	}

	public class address{
		public String street;
		public String type;
		public String apartment;
		public String city;
		public String regioncode;
		public String postalcode;
		public String country;
		public String url;
	}

	public class vendor{
		public String vendorid;
		public String vendorsource;
		public String vendorname;
		public contact contact;
	}

	public class provider{
		public String id;
		public String name;
		public String service;
		public String url;
		public String email;
		public String phone;
		public contact contact;
	}
}