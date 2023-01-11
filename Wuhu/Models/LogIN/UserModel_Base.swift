

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class UserModel_Base {
	public var data : UserData?
	public var user_cards : [String]?
	public var access_token_info : Access_token_info?
	public var status : Bool?
	public var message : String?
    public var point : Int?


    public class func modelsFromDictionaryArray(array:NSArray) -> [UserModel_Base]
    {
        var models:[UserModel_Base] = []
        for item in array
        {
            models.append(UserModel_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		if (dictionary["data"] != nil) { data = UserData(dictionary: dictionary["data"] as! NSDictionary) }
        user_cards = dictionary["user_cards"] as? Array

//		if (dictionary["user_cards"] != nil) { user_cards = User_cards.modelsFromDictionaryArray(dictionary["user_cards"] as! NSArray) }
		if (dictionary["access_token_info"] != nil) { access_token_info = Access_token_info(dictionary: dictionary["access_token_info"] as! NSDictionary) }
		status = dictionary["status"] as? Bool
		message = dictionary["message"] as? String
        point = dictionary["points"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
		dictionary.setValue(self.access_token_info?.dictionaryRepresentation(), forKey: "access_token_info")
        dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.point, forKey: "points")

		return dictionary
	}

}
