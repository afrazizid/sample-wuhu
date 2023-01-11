//
//  HelpModel.swift
//  Wuhu
//
//  Created by Awais on 27/06/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


class HelpModel {

    var data : [HelpDatum]!
    var status : Bool!
    var type : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [HelpDatum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = HelpDatum(fromJson: dataJson)
            data.append(value)
        }
        status = json["status"].boolValue
        type = json["type"].stringValue
    }
}
class HelpDatum {

var dateCreated : String!
var dateUpdated : String!
var descriptionField : String!
var faqCategoryId : AnyObject!
var id : Int!
var link : String!
var orderId : Int!
var tags : String!
var title : String!
var type : String!

/**
 * Instantiate the instance using the passed json values to set the properties values
 */
init(fromJson json: JSON!){
    if json.isEmpty{
        return
    }
    dateCreated = json["date_created"].stringValue
    dateUpdated = json["date_updated"].stringValue
    descriptionField = json["description"].stringValue
    faqCategoryId = json["faq_category_id"] as AnyObject
    id = json["id"].intValue
    link = json["link"].stringValue
    orderId = json["order_id"].intValue
    tags = json["tags"].stringValue
    title = json["title"].stringValue
    type = json["type"].stringValue
}
}
