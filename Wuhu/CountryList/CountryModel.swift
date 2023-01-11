//
//  Country.swift
//  CountryListExample
//
//  Created by Juan Pablo on 9/8/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import SwiftyJSON

class CountryMain : NSObject{
    
    var data : [CountryModel]!
    var message : String!
    var status : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [CountryModel]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = CountryModel(fromJson: dataJson)
            data.append(value)
        }
        message = json["message"].stringValue
        status = json["status"].boolValue
    }
}

public class CountryModel2: NSObject {

    public var countryCode: String
    public var phoneExtension: String
    var id : Int!

    public var name: String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode) ?? nil
    }

    public var flag: String? {
        return flag(country: countryCode)
    }

    init(countryCode: String, phoneExtension: String) {
        self.countryCode = countryCode
        self.phoneExtension = phoneExtension
    }

    private func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
public class CountryModel : NSObject{
    
    var id : Int!
    var name : String!
    //    var phonecode : Int!
    var isDefault: Bool!
    var sortname : String!
   public var countryCode: String!
   public var phoneExtension: String!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
        countryCode = json["phonecode"].stringValue
        phoneExtension = json["phonecode"].stringValue
        sortname = json["sortname"].stringValue
        isDefault = json["is_default"].boolValue
    }
    
    public var flag: String? {
        if sortname == "XU" {
            sortname = "GB"
        }
        return flag(country: sortname)
    }
    private func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
}
