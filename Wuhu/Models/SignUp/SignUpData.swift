

import Foundation
 


public class SignUpData {
	
    public var user_first_name : String?
	public var user_family_name : String?
	public var email : String?
	public var user_mobile : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Data Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [SignUpData]
    {
        var models:[SignUpData] = []
        for item in array
        {
            models.append(SignUpData(dictionary: item as! NSDictionary)!)
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

		user_first_name = dictionary["user_first_name"] as? String
		user_family_name = dictionary["user_family_name"] as? String
		email = dictionary["email"] as? String
		user_mobile = dictionary["user_mobile"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.user_first_name, forKey: "user_first_name")
		dictionary.setValue(self.user_family_name, forKey: "user_family_name")
		dictionary.setValue(self.email, forKey: "email")
		dictionary.setValue(self.user_mobile, forKey: "user_mobile")

		return dictionary
	}

}
