//
//  ReceiptDataModel.swift
//  Wuhu
//
//  Created by Awais on 14/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON

class ReceiptDataModel {
    
    var aps : Ap!
    var attachmentUrl : String!
    var notificationContent : NotificationContent!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let apsJson = json["aps"]
        if !apsJson.isEmpty{
            aps = Ap(fromJson: apsJson)
        }
        attachmentUrl = json["attachment_url"].stringValue
        let notificationContentJson = json["notification_content"]
        if !notificationContentJson.isEmpty{
            notificationContent = NotificationContent(fromJson: notificationContentJson)
        }
    }
    
}
class NotificationContent {
    
    var content : Content!
    var notificationType : String!
    var tokenCompanyId : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let contentJson = json["content"]
        if !contentJson.isEmpty{
            content = Content(fromJson: contentJson)
        }
        notificationType = json["notification_type"].stringValue
        tokenCompanyId = json["tokenCompanyId"].stringValue
    }
}
class Content{
    
    var data : DatumMain!
    var points : Int!
    var resolve : Int!
    var stamp : Int!
    var receiptId : Int!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let dataJson = json["data"]
        if !dataJson.isEmpty{
            data = DatumMain(fromJson: dataJson)
        }
        points = json["points"].intValue
        resolve = json["resolve"].intValue
        stamp = json["stamps"].intValue
        receiptId = json["receiptId"].intValue
    }
}
class DatumMain{
    
    var callbackType : String!
    var organizationId : String!
    var reference : String!
    var respondStatus : String!
    var respondStatusId : Int!
    var rows : [Row]!
    var top : Top!
    var updatedAt : Int!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        callbackType = json["callback_type"].stringValue
        organizationId = json["organization_id"].stringValue
        reference = json["reference"].stringValue
        respondStatus = json["respond_status"].stringValue
        respondStatusId = json["respond_status_id"].intValue
        rows = [Row]()
        let rowsArray = json["rows"].arrayValue
        for rowsJson in rowsArray{
            let value = Row(fromJson: rowsJson)
            rows.append(value)
        }
        let topJson = json["top"]
        if !topJson.isEmpty{
            top = Top(fromJson: topJson)
        }
        updatedAt = json["updated_at"].intValue
    }
}
class Top{
    
    var date : String!
    var retailerName : String!
    var storeName : String!
    var total : Float!
    var uniqueId : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        date = json["date"].stringValue
        retailerName = json["retailer_name"].stringValue
        storeName = json["store_name"].stringValue
        total = json["total"].floatValue
        uniqueId = json["unique_id"].stringValue
    }
}
class Row {
    
    var aliasId : Int!
    var amount : Float!
    var barcode : AnyObject!
    var brand : String!
    var descriptionField : String!
    var isUnilever : Int!
    var observationPriority : AnyObject!
    var promoOff : Int!
    var quantity : Int!
    var requiresObservation : Bool!
    var unitPrice : Float!
    var wuhuLevel1 : AnyObject!
    var wuhuLevel2 : AnyObject!
    var wuhuLevel3 : AnyObject!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        aliasId = json["alias_id"].intValue
        amount = json["amount"].floatValue
        barcode = json["barcode"] as AnyObject
        brand = json["brand"].stringValue
        descriptionField = json["description"].stringValue
        isUnilever = json["is_unilever"].intValue
        observationPriority = json["observation_priority"] as AnyObject
        promoOff = json["promo_off"].intValue
        quantity = json["quantity"].intValue
        requiresObservation = json["requires_observation"].boolValue
        unitPrice = json["unit_price"].floatValue
        wuhuLevel1 = json["wuhu_level_1"] as AnyObject
        wuhuLevel2 = json["wuhu_level_2"] as AnyObject
        wuhuLevel3 = json["wuhu_level_3"] as AnyObject
    }
}
class Ap {
    
    var alert : Alert!
    var mutableContent : Int!
    var sound : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let alertJson = json["alert"]
        if !alertJson.isEmpty{
            alert = Alert(fromJson: alertJson)
        }
        mutableContent = json["mutable-content"].intValue
        sound = json["sound"].stringValue
    }
}
class Alert {
    
    var body : String!
    var title : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        body = json["body"].stringValue
        title = json["title"].stringValue
    }
}

class getReciptModel {

var receiptData : receiptDatum!
var status : Bool!

/**
 * Instantiate the instance using the passed json values to set the properties values
 */
init(fromJson json: JSON!){
    if json.isEmpty{
        return
    }
    let dataJson = json["data"]
    if !dataJson.isEmpty{
        receiptData = receiptDatum(fromJson: dataJson)
    }
    status = json["status"].boolValue
}
}
class receiptDatum {

var discount : String!
var paymentType : String!
var products : [Product]!
var receiptloyal : Loyalty!
var receiptDate : String!
var receiptId : String!
var retailer : String!
var retailerAddress : String!
var retailerLogo : String!
var scanDate : String!
var subTotal : Int!
var total : Float!
var vat : String!
var time : String!
    var number : String!
    var logo : String!

/**
 * Instantiate the instance using the passed json values to set the properties values
 */
init(fromJson json: JSON!){
    if json.isEmpty{
        return
    }
    let dataJson = json["loyalty"]
       if !dataJson.isEmpty{
           receiptloyal = Loyalty(fromJson: dataJson)
       }
    discount = json["discount"].stringValue
    paymentType = json["payment_type"].stringValue
    products = [Product]()
    let productsArray = json["products"].arrayValue
    for productsJson in productsArray{
        let value = Product(fromJson: productsJson)
        products.append(value)
    }
    receiptDate = json["receipt_date"].stringValue
    receiptId = json["receipt_id"].stringValue
    retailer = json["retailer"].stringValue
    retailerAddress = json["retailer_address"].stringValue
    retailerLogo = json["retailer_logo"].stringValue
    scanDate = json["scan_date"].stringValue
    subTotal = json["sub_total"].intValue
    total = json["total"].floatValue
    vat = json["vat"].stringValue
    time = json["receipt_time"].stringValue
    number = json["store_number"].stringValue
    logo = json["retailer_logo"].stringValue
    
}
}
class Product {

var amount : Float!
var barcode : AnyObject!
var brand : String!
var category : String!
var descriptionField : String!
var discountPrice : Int!
var isUnilever : Bool!
var loyalty : Loyalty!
var name : String!
var quantity : Int!
var requiresObservation : Bool!
var sku : String!
var totalPrice : Float!
var unitPrice : Float!

/**
 * Instantiate the instance using the passed json values to set the properties values
 */
init(fromJson json: JSON!){
    if json.isEmpty{
        return
    }
    amount = json["amount"].floatValue
    barcode = json["barcode"] as AnyObject
    brand = json["brand"].stringValue
    category = json["category"].stringValue
    descriptionField = json["description"].stringValue
    discountPrice = json["discount_price"].intValue
    isUnilever = json["is_unilever"].boolValue
    let loyaltyJson = json["loyalty"]
    if !loyaltyJson.isEmpty{
        loyalty = Loyalty(fromJson: loyaltyJson)
    }
    name = json["name"].stringValue
    quantity = json["quantity"].intValue
    requiresObservation = json["requires_observation"].boolValue
    sku = json["sku"].stringValue
    totalPrice = json["total_price"].floatValue
    unitPrice = json["unit_price"].floatValue
}
}
class Loyalty{

var points : Int!
var stamps : Int!

/**
 * Instantiate the instance using the passed json values to set the properties values
 */
init(fromJson json: JSON!){
    if json.isEmpty{
        return
    }
    points = json["points"].intValue
    stamps = json["stamps"].intValue
}
}
