//
//  ActivityModel.swift
//  Wuhu
//
//  Created by Awais on 24/08/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON

class ActivityModel {
    var data : [ActivityData]!
    var status : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [ActivityData]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = ActivityData(fromJson: dataJson)
            data.append(value)
        }
        status = json["status"].boolValue
    }
}
class ActivityData {
    
    var amount : Int!
    var assignThrough : String!
    var createdAt : String!
    var descriptionField : String!
    var discountType : String!
    var displayType : String!
    var image : String!
    var missionId : Int!
    var name : String!
    var pointType : String!
    var points : Int!
    var userId : Int!
    var voucherId : Int!
    var receiptId : Int!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        amount = json["amount"].intValue
        assignThrough = json["assign_through"].stringValue
        createdAt = json["created_at"].stringValue
        descriptionField = json["description"].stringValue
        discountType = json["discount_type"].stringValue
        displayType = json["display_type"].stringValue
        image = json["image"].stringValue
        missionId = json["mission_id"].intValue
        name = json["name"].stringValue
        pointType = json["point_type"].stringValue
        points = json["points"].intValue
        receiptId = json["receipt_id"].intValue
        userId = json["user_id"].intValue
        voucherId = json["voucher_id"].intValue
    }
}
