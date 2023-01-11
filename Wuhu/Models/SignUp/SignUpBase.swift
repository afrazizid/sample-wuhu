

import Foundation
 

public class SignUpBase {
	
    public var card_status : Bool?
	public var status : Bool?
	public var message : String?
	public var user_id : Int?
	public var data : SignUpData?
	public var referal_message : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SignUpBase]
    {
        var models:[SignUpBase] = []
        for item in array
        {
            models.append(SignUpBase(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		card_status = dictionary["card_status"] as? Bool
		status = dictionary["status"] as? Bool
		message = dictionary["message"] as? String
		user_id = dictionary["user_id"] as? Int
		if (dictionary["data"] != nil) { data = SignUpData(dictionary: dictionary["data"] as! NSDictionary) }
		referal_message = dictionary["referal_message"] as? String
	}


	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.card_status, forKey: "card_status")
		dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.message, forKey: "message")
		dictionary.setValue(self.user_id, forKey: "user_id")
		dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
		dictionary.setValue(self.referal_message, forKey: "referal_message")

		return dictionary
	}

}
