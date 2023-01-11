//
//  StoreModel.swift
//  Wuhu
//
//  Created by Awais on 06/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


class StoreModel : NSObject, NSCoding{

    var data : [Datum]!
    var message : String!
    var status : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [Datum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = Datum(fromJson: dataJson)
            data.append(value)
        }
        message = json["message"].stringValue
        status = json["status"].boolValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
        var dictionaryElements = [[String:Any]]()
        for dataElement in data {
            dictionaryElements.append(dataElement.toDictionary())
        }
        dictionary["data"] = dictionaryElements
        }
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? [Datum]
        message = aDecoder.decodeObject(forKey: "message") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Bool
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
class Datum : NSObject, NSCoding{

    var amount : Int!
    var benefitId : Int!
    var descriptionField : String!
    var discountType : String!
    var image : String!
    var name : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        amount = json["amount"].intValue
        benefitId = json["benefit_id"].intValue
        descriptionField = json["description"].stringValue
        discountType = json["discount_type"].stringValue
        image = json["image"].stringValue
        name = json["name"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if amount != nil{
            dictionary["amount"] = amount
        }
        if benefitId != nil{
            dictionary["benefit_id"] = benefitId
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if discountType != nil{
            dictionary["discount_type"] = discountType
        }
        if image != nil{
            dictionary["image"] = image
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        amount = aDecoder.decodeObject(forKey: "amount") as? Int
        benefitId = aDecoder.decodeObject(forKey: "benefit_id") as? Int
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        discountType = aDecoder.decodeObject(forKey: "discount_type") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if amount != nil{
            aCoder.encode(amount, forKey: "amount")
        }
        if benefitId != nil{
            aCoder.encode(benefitId, forKey: "benefit_id")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if discountType != nil{
            aCoder.encode(discountType, forKey: "discount_type")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }

    }

}
