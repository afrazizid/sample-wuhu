//
//  MicroBlink.swift
//  Wuhu
//
//  Created by Awais on 14/08/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation

public class MicroBlink{
    public var name : String?
    public var value : String?
    
       public class func modelsFromDictionaryArray(array:NSArray) -> [MicroBlink]
    {
        var models:[MicroBlink] = []
        for item in array
        {
            models.append(MicroBlink(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {

            name = dictionary["name"] as? String
            value = dictionary["value"] as? String
        }
}
