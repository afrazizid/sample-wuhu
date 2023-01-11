
import Foundation
 

public class Generic_Base {
	public var message : String?
    public var status : Bool?
    public var password : String?
    public var access_token_info : Access_token_info?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Generic_Base]
    {
        var models:[Generic_Base] = []
        for item in array
        {
            models.append(Generic_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		status = dictionary["status"] as? Bool
		message = dictionary["message"] as? String
        password = dictionary["password"] as? String
        if (dictionary["access_token"] != nil) { access_token_info = Access_token_info(dictionary: dictionary["access_token"] as! NSDictionary) }
       // token = dictionary["access_token"] as? String


	}

		
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.password, forKey: "password")
        dictionary.setValue(self.access_token_info?.dictionaryRepresentation(), forKey: "access_token")
       // dictionary.setValue(self.token, forKey: "access_token")
		return dictionary
	}
}

//
//public class Generic_Base2 {
//    public var message : String?
//    public var status : Int?
//    public var task_status : String?
//    public var token : String?
//
//
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [Generic_Base]
//    {
//        var models:[Generic_Base] = []
//        for item in array
//        {
//            models.append(Generic_Base(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//
//    required public init?(dictionary: NSDictionary) {
//
//        status = dictionary["status"] as? Int
//        message = dictionary["message"] as? String
//        task_status = dictionary["task_status"] as? String
//      //  token = dictionary["access_token"] as? String
//
//    }
//
//
//    public func dictionaryRepresentation() -> NSDictionary {
//
//        let dictionary = NSMutableDictionary()
//
//        dictionary.setValue(self.status, forKey: "status")
//        dictionary.setValue(self.message, forKey: "message")
//        dictionary.setValue(self.task_status, forKey: "task_status")
//        dictionary.setValue(self.access_token_info?.dictionaryRepresentation(), forKey: "access_token_info")
//      //  dictionary.setValue(self.token, forKey: "access_token")
//        return dictionary
//    }
//
//}
