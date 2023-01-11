
import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class ReferFriendList_Base {
    public var status : Bool?
	public var data : [PastReferFriendData]?
	public var message : String?


    public class func modelsFromDictionaryArray(array:NSArray) -> [ReferFriendList_Base]
    {
        var models:[ReferFriendList_Base] = []
        for item in array
        {
            models.append(ReferFriendList_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }


	required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
        if (dictionary["data"] != nil) { data = PastReferFriendData.modelsFromDictionaryArray(array: dictionary["data"] as! NSArray) }
		message = dictionary["message"] as? String
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.message, forKey: "message")

		return dictionary
	}

}


public class PastReferFriendData {
    public var user_name : String?
    public var email : String?
    public var phone : String?
    public var user_avatar : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [PastReferFriendData]
    {
        var models:[PastReferFriendData] = []
        for item in array
        {
            models.append(PastReferFriendData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        user_name = dictionary["user_name"] as? String
        email = dictionary["email"] as? String
        phone = dictionary["phone"] as? String
        user_avatar = dictionary["user_avatar"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.user_name, forKey: "user_name")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.phone, forKey: "phone")
        dictionary.setValue(self.user_avatar, forKey: "user_avatar")

        return dictionary
    }

}
