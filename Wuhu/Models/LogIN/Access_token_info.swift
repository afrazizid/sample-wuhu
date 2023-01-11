

import Foundation
 


public class Access_token_info {
	public var access_token : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let access_token_info_list = Access_token_info.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Access_token_info Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Access_token_info]
    {
        var models:[Access_token_info] = []
        for item in array
        {
            models.append(Access_token_info(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let access_token_info = Access_token_info(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Access_token_info Instance.
*/
	required public init?(dictionary: NSDictionary) {

		access_token = dictionary["access_token"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.access_token, forKey: "access_token")

		return dictionary
	}

}
