


import Foundation
 


public class UserData {
	public var user_id : Int?
	public var amp_user_id : Int?
	public var company_id : String?
	public var soldi_id : Int?
	public var user_first_name : String?
	public var user_family_name : String?
	public var user_mobile : String?
	public var email : String?
	public var gender : String?
	public var dob : String?
	public var postal_code : String?
	public var user_is_active : String?
	public var user_indentity_code : String?
	public var user_avatar : String?
	public var qr_code : String?
	public var user_loyalty_number : String?
	public var is_active : Int?
	public var activation_token : String?
	public var swift_pos_id : String?
	public var created_at : String?
	public var updated_at : String?
	public var expiry_time : String?
	public var user_type : String?
	public var knox_user_id : String?
	public var company_name : String?
	public var address : String?
	public var street_number : String?
	public var street_name : String?
	public var default_venue : Int?
	public var city : String?
	public var referral_code : String?
	public var referal_by : String?
	public var state : String?
	public var debug_mod : String?
	public var device_token : String?
	public var device_type : String?
	public var is_loggedin : String?
	public var subscribed_venues : String?
	public var country : String?
	public var is_merchant : Int?
	public var subrub : String?
	public var is_completed : Int?
    public var user_favourites : [String]?
	public var waitron_id : String?
	public var referred_waitron : String?
	public var is_waitron : Int?
	public var is_email : Int?
	public var store_data : Int?
	public var food_preference : String?
	public var currency : String?
	public var deleted_at : String?
	public var region_type : String?
	public var company_info : String?
	public var user_lat : Int?
	public var user_long : Int?
	public var basket_value : Int?
	public var basket_size : Int?
	public var avg_basket_size : Int?
	public var avg_basket_value : Int?
	public var number_of_transactions : Int?
	public var kill_bill_id : String?
	public var client_customer_id : String?
	public var old_user : Int?
	public var kilbill_ire_id : String?
	public var groups : String?
	public var stand_number : String?
	public var dependents : String?
	public var is_address_default : String?
	public var device_id : String?
	public var app_mod : Int?
	public var venue_name : String?
	public var card_data : String?
	public var completed_profile : Int?
	public var food : [String]?
	public var allergy : [String]?
    public var pool_ip_url : String?
    public var countryCode : String?
    public var totalPoint : Int?
    var space:String!
    public var rs : Int?
    public var blinkData : [MicroBlink]?

    

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Data Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [UserData]
    {
        var models:[UserData] = []
        for item in array
        {
            models.append(UserData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let data = Data(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Data Instance.
*/
	required public init?(dictionary: NSDictionary) {

		user_id = dictionary["user_id"] as? Int
		amp_user_id = dictionary["amp_user_id"] as? Int
		company_id = dictionary["company_id"] as? String
		soldi_id = dictionary["soldi_id"] as? Int
		user_first_name = dictionary["user_first_name"] as? String
		user_family_name = dictionary["user_family_name"] as? String
		user_mobile = dictionary["user_mobile"] as? String
		email = dictionary["email"] as? String
		gender = dictionary["gender"] as? String
		dob = dictionary["dob"] as? String
		postal_code = dictionary["postal_code"] as? String
		user_is_active = dictionary["user_is_active"] as? String
		user_indentity_code = dictionary["user_indentity_code"] as? String
		user_avatar = dictionary["user_avatar"] as? String
		qr_code = dictionary["qr_code"] as? String
		user_loyalty_number = dictionary["user_loyalty_number"] as? String
		is_active = dictionary["is_active"] as? Int
		activation_token = dictionary["activation_token"] as? String
		swift_pos_id = dictionary["swift_pos_id"] as? String
		created_at = dictionary["created_at"] as? String
		updated_at = dictionary["updated_at"] as? String
		expiry_time = dictionary["expiry_time"] as? String
		user_type = dictionary["user_type"] as? String
		knox_user_id = dictionary["knox_user_id"] as? String
		company_name = dictionary["company_name"] as? String
		address = dictionary["address"] as? String
		street_number = dictionary["street_number"] as? String
		street_name = dictionary["street_name"] as? String
		default_venue = dictionary["default_venue"] as? Int
		city = dictionary["city"] as? String
		referral_code = dictionary["referral_code"] as? String
		referal_by = dictionary["referal_by"] as? String
		state = dictionary["state"] as? String
		debug_mod = dictionary["debug_mod"] as? String
		device_token = dictionary["device_token"] as? String
		device_type = dictionary["device_type"] as? String
		is_loggedin = dictionary["is_loggedin"] as? String
		subscribed_venues = dictionary["subscribed_venues"] as? String
		country = dictionary["country"] as? String
		is_merchant = dictionary["is_merchant"] as? Int
		subrub = dictionary["subrub"] as? String
		is_completed = dictionary["is_completed"] as? Int

        user_favourites = dictionary["user_favourites"] as? Array

//		if (dictionary["user_favourites"] != nil) { user_favourites = User_favourites.modelsFromDictionaryArray(dictionary["user_favourites"] as! NSArray) }
		waitron_id = dictionary["waitron_id"] as? String
		referred_waitron = dictionary["referred_waitron"] as? String
		is_waitron = dictionary["is_waitron"] as? Int
		is_email = dictionary["is_email"] as? Int
		store_data = dictionary["store_data"] as? Int
		food_preference = dictionary["food_preference"] as? String
		currency = dictionary["currency"] as? String
		deleted_at = dictionary["deleted_at"] as? String
		region_type = dictionary["region_type"] as? String
		company_info = dictionary["company_info"] as? String
		user_lat = dictionary["user_lat"] as? Int
		user_long = dictionary["user_long"] as? Int
		basket_value = dictionary["basket_value"] as? Int
		basket_size = dictionary["basket_size"] as? Int
		avg_basket_size = dictionary["avg_basket_size"] as? Int
		avg_basket_value = dictionary["avg_basket_value"] as? Int
		number_of_transactions = dictionary["number_of_transactions"] as? Int
		kill_bill_id = dictionary["kill_bill_id"] as? String
		client_customer_id = dictionary["client_customer_id"] as? String
		old_user = dictionary["old_user"] as? Int
		kilbill_ire_id = dictionary["kilbill_ire_id"] as? String
		groups = dictionary["groups"] as? String
		stand_number = dictionary["stand_number"] as? String
		dependents = dictionary["dependents"] as? String
		is_address_default = dictionary["is_address_default"] as? String
		device_id = dictionary["device_id"] as? String
		app_mod = dictionary["app_mod"] as? Int
		venue_name = dictionary["venue_name"] as? String
		card_data = dictionary["card_data"] as? String
		completed_profile = dictionary["profile_percentage"] as? Int
        pool_ip_url = dictionary["pool_ip_url"] as? String
        countryCode = dictionary["country_code"] as? String
        let new = dictionary["total_points"] as? Int
        space = "  "+"\(new ?? 0)"
        totalPoint = dictionary["total_points"] as? Int
        
        rs = getPoints.rs(point: totalPoint ?? 0)
        food = dictionary["food"] as? Array
        allergy = dictionary["allergy"] as? Array

        if (dictionary["custom_configuration"] != nil) { blinkData = MicroBlink.modelsFromDictionaryArray(array: dictionary["custom_configuration"] as! NSArray) }
//		if (dictionary["custom_configuration"] != nil) { blinkData = MicroBlink(dictionary["custom_configuration"] as! NSArray) }
//		if (dictionary["allergy"] != nil) { allergy = Allergy.modelsFromDictionaryArray(dictionary["allergy"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.user_id, forKey: "user_id")
		dictionary.setValue(self.amp_user_id, forKey: "amp_user_id")
		dictionary.setValue(self.company_id, forKey: "company_id")
		dictionary.setValue(self.soldi_id, forKey: "soldi_id")
		dictionary.setValue(self.user_first_name, forKey: "user_first_name")
		dictionary.setValue(self.user_family_name, forKey: "user_family_name")
		dictionary.setValue(self.user_mobile, forKey: "user_mobile")
		dictionary.setValue(self.email, forKey: "email")
		dictionary.setValue(self.gender, forKey: "gender")
		dictionary.setValue(self.dob, forKey: "dob")
		dictionary.setValue(self.postal_code, forKey: "postal_code")
		dictionary.setValue(self.user_is_active, forKey: "user_is_active")
		dictionary.setValue(self.user_indentity_code, forKey: "user_indentity_code")
		dictionary.setValue(self.user_avatar, forKey: "user_avatar")
		dictionary.setValue(self.qr_code, forKey: "qr_code")
		dictionary.setValue(self.user_loyalty_number, forKey: "user_loyalty_number")
		dictionary.setValue(self.is_active, forKey: "is_active")
		dictionary.setValue(self.activation_token, forKey: "activation_token")
		dictionary.setValue(self.swift_pos_id, forKey: "swift_pos_id")
		dictionary.setValue(self.created_at, forKey: "created_at")
		dictionary.setValue(self.updated_at, forKey: "updated_at")
		dictionary.setValue(self.expiry_time, forKey: "expiry_time")
		dictionary.setValue(self.user_type, forKey: "user_type")
		dictionary.setValue(self.knox_user_id, forKey: "knox_user_id")
		dictionary.setValue(self.company_name, forKey: "company_name")
		dictionary.setValue(self.address, forKey: "address")
		dictionary.setValue(self.street_number, forKey: "street_number")
		dictionary.setValue(self.street_name, forKey: "street_name")
		dictionary.setValue(self.default_venue, forKey: "default_venue")
		dictionary.setValue(self.city, forKey: "city")
		dictionary.setValue(self.referral_code, forKey: "referral_code")
		dictionary.setValue(self.referal_by, forKey: "referal_by")
		dictionary.setValue(self.state, forKey: "state")
		dictionary.setValue(self.debug_mod, forKey: "debug_mod")
		dictionary.setValue(self.device_token, forKey: "device_token")
		dictionary.setValue(self.device_type, forKey: "device_type")
		dictionary.setValue(self.is_loggedin, forKey: "is_loggedin")
		dictionary.setValue(self.subscribed_venues, forKey: "subscribed_venues")
		dictionary.setValue(self.country, forKey: "country")
		dictionary.setValue(self.is_merchant, forKey: "is_merchant")
		dictionary.setValue(self.subrub, forKey: "subrub")
		dictionary.setValue(self.is_completed, forKey: "is_completed")
		dictionary.setValue(self.waitron_id, forKey: "waitron_id")
		dictionary.setValue(self.referred_waitron, forKey: "referred_waitron")
		dictionary.setValue(self.is_waitron, forKey: "is_waitron")
		dictionary.setValue(self.is_email, forKey: "is_email")
		dictionary.setValue(self.store_data, forKey: "store_data")
		dictionary.setValue(self.food_preference, forKey: "food_preference")
		dictionary.setValue(self.currency, forKey: "currency")
		dictionary.setValue(self.deleted_at, forKey: "deleted_at")
		dictionary.setValue(self.region_type, forKey: "region_type")
		dictionary.setValue(self.company_info, forKey: "company_info")
		dictionary.setValue(self.user_lat, forKey: "user_lat")
		dictionary.setValue(self.user_long, forKey: "user_long")
		dictionary.setValue(self.basket_value, forKey: "basket_value")
		dictionary.setValue(self.basket_size, forKey: "basket_size")
		dictionary.setValue(self.avg_basket_size, forKey: "avg_basket_size")
		dictionary.setValue(self.avg_basket_value, forKey: "avg_basket_value")
		dictionary.setValue(self.number_of_transactions, forKey: "number_of_transactions")
		dictionary.setValue(self.kill_bill_id, forKey: "kill_bill_id")
		dictionary.setValue(self.client_customer_id, forKey: "client_customer_id")
		dictionary.setValue(self.old_user, forKey: "old_user")
		dictionary.setValue(self.kilbill_ire_id, forKey: "kilbill_ire_id")
		dictionary.setValue(self.groups, forKey: "groups")
		dictionary.setValue(self.stand_number, forKey: "stand_number")
		dictionary.setValue(self.dependents, forKey: "dependents")
		dictionary.setValue(self.is_address_default, forKey: "is_address_default")
		dictionary.setValue(self.device_id, forKey: "device_id")
		dictionary.setValue(self.app_mod, forKey: "app_mod")
		dictionary.setValue(self.venue_name, forKey: "venue_name")
		dictionary.setValue(self.card_data, forKey: "card_data")
		dictionary.setValue(self.completed_profile, forKey: "completed_profile")
        dictionary.setValue(self.pool_ip_url, forKey: "pool_ip_url")
        
		return dictionary
	}
}
