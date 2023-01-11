//
//  RedeemIncentive.swift
//  Wuhu
//
//  Created by Awais on 07/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//


import Foundation
import SwiftyJSON


class RedeemIncentive : NSObject, NSCoding{

    var body : Body!
    var message : String!
    var status : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let bodyJson = json["body"]
        if !bodyJson.isEmpty{
            body = Body(fromJson: bodyJson)
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
        if body != nil{
            dictionary["body"] = body.toDictionary()
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
        body = aDecoder.decodeObject(forKey: "body") as? Body
        message = aDecoder.decodeObject(forKey: "message") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Bool
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if body != nil{
            aCoder.encode(body, forKey: "body")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
class Body : NSObject, NSCoding{

    var benefitName : String!
    var incentivRef : String!
    var voucher : [Voucher]!
    var voucherExpiry : String!
    var voucherId : Int!
    var voucherIssuedDate : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        benefitName = json["benefit_name"].stringValue
        incentivRef = json["incentiv_ref"].stringValue
        voucher = [Voucher]()
        let voucherArray = json["voucher"].arrayValue
        for voucherJson in voucherArray{
            let value = Voucher(fromJson: voucherJson)
            voucher.append(value)
        }
        voucherExpiry = json["voucher_expiry"].stringValue
        voucherId = json["voucher_id"].intValue
        voucherIssuedDate = json["voucher_issued_date"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if benefitName != nil{
            dictionary["benefit_name"] = benefitName
        }
        if incentivRef != nil{
            dictionary["incentiv_ref"] = incentivRef
        }
        if voucher != nil{
        var dictionaryElements = [[String:Any]]()
        for voucherElement in voucher {
            dictionaryElements.append(voucherElement.toDictionary())
        }
        dictionary["voucher"] = dictionaryElements
        }
        if voucherExpiry != nil{
            dictionary["voucher_expiry"] = voucherExpiry
        }
        if voucherId != nil{
            dictionary["voucher_id"] = voucherId
        }
        if voucherIssuedDate != nil{
            dictionary["voucher_issued_date"] = voucherIssuedDate
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        benefitName = aDecoder.decodeObject(forKey: "benefit_name") as? String
        incentivRef = aDecoder.decodeObject(forKey: "incentiv_ref") as? String
        voucher = aDecoder.decodeObject(forKey: "voucher") as? [Voucher]
        voucherExpiry = aDecoder.decodeObject(forKey: "voucher_expiry") as? String
        voucherId = aDecoder.decodeObject(forKey: "voucher_id") as? Int
        voucherIssuedDate = aDecoder.decodeObject(forKey: "voucher_issued_date") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if benefitName != nil{
            aCoder.encode(benefitName, forKey: "benefit_name")
        }
        if incentivRef != nil{
            aCoder.encode(incentivRef, forKey: "incentiv_ref")
        }
        if voucher != nil{
            aCoder.encode(voucher, forKey: "voucher")
        }
        if voucherExpiry != nil{
            aCoder.encode(voucherExpiry, forKey: "voucher_expiry")
        }
        if voucherId != nil{
            aCoder.encode(voucherId, forKey: "voucher_id")
        }
        if voucherIssuedDate != nil{
            aCoder.encode(voucherIssuedDate, forKey: "voucher_issued_date")
        }

    }

}
class Voucher : NSObject, NSCoding{

    var label : String!
    var name : String!
    var output : String!
    var raw : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        label = json["label"].stringValue
        name = json["name"].stringValue
        output = json["output"].stringValue
        raw = json["raw"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if label != nil{
            dictionary["label"] = label
        }
        if name != nil{
            dictionary["name"] = name
        }
        if output != nil{
            dictionary["output"] = output
        }
        if raw != nil{
            dictionary["raw"] = raw
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        label = aDecoder.decodeObject(forKey: "label") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        output = aDecoder.decodeObject(forKey: "output") as? String
        raw = aDecoder.decodeObject(forKey: "raw") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if label != nil{
            aCoder.encode(label, forKey: "label")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if output != nil{
            aCoder.encode(output, forKey: "output")
        }
        if raw != nil{
            aCoder.encode(raw, forKey: "raw")
        }

    }

}
class ClaimIncentive {
    var status : Bool!
    var message : String!
    var description : String!
    var totalPoints : Int!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        status = json["status"].boolValue
        message = json["message"].stringValue
        description = json["description"].stringValue
        totalPoints = json["total_points"].intValue
    }
}
