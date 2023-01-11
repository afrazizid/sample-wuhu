
import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class ReferFriend_Base {
	public var status : Bool?
	public var data : ReferFriendData?
	public var message : String?


    public class func modelsFromDictionaryArray(array:NSArray) -> [ReferFriend_Base]
    {
        var models:[ReferFriend_Base] = []
        for item in array
        {
            models.append(ReferFriend_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? Bool
		if (dictionary["data"] != nil) { data = ReferFriendData(dictionary: dictionary["data"] as! NSDictionary) }
		message = dictionary["message"] as? String
	}


	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
		dictionary.setValue(self.message, forKey: "message")

		return dictionary
	}

}

public class ReferFriendData {
    public var invite_count : Int?
    public var total_count : Int?
    public var rand : Int?
    public var points : Int?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ReferFriendData]
    {
        var models:[ReferFriendData] = []
        for item in array
        {
            models.append(ReferFriendData(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        invite_count = dictionary["invite_count"] as? Int
        total_count = dictionary["total_count"] as? Int
        rand = dictionary["rand"] as? Int
        points = dictionary["points"] as? Int
    }

    
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.invite_count, forKey: "invite_count")
        dictionary.setValue(self.total_count, forKey: "total_count")
        dictionary.setValue(self.rand, forKey: "rand")
        dictionary.setValue(self.points, forKey: "points")

        return dictionary
    }

}
