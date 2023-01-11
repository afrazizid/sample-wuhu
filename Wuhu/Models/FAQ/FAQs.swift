//
//  FAQs.swift
//  Wuhu
//
//  Created by Awais on 12/06/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON

class FAQs {
    var data : [FAQsDatum]!
      var message : String!
      var status : Bool!

      /**
       * Instantiate the instance using the passed json values to set the properties values
       */
      init(fromJson json: JSON!){
          if json.isEmpty{
              return
          }
          data = [FAQsDatum]()
          let dataArray = json["data"].arrayValue
          for dataJson in dataArray{
              let value = FAQsDatum(fromJson: dataJson)
              data.append(value)
          }
          message = json["message"].stringValue
          status = json["status"].boolValue
      }
}
class FAQsDatum {

var dateCreated : String!
var dateUpdated : String!
var descriptionField : String!
var faqCategoryId : Int!
var id : Int!
var link : String!
var orderId : Int!
var tags : AnyObject!
var title : String!
var type : String!
    var like : Bool!
    var dislike : Bool!

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
    faqCategoryId = json["faq_category_id"].intValue
    id = json["id"].intValue
    link = json["link"].stringValue
    orderId = json["order_id"].intValue
    tags = json["tags"] as AnyObject
    title = json["title"].stringValue
    type = json["type"].stringValue
    like = json["like"].boolValue
    dislike = json["dislike"].boolValue
}
}
