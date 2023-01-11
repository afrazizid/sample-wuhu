//
//  RetailerModel.swift
//  Wuhu
//
//  Created by Awais on 11/01/2021.
//  Copyright © 2021 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


class RetailerModel{

    var data : [retailerDatum]!
    var status : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [retailerDatum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = retailerDatum(fromJson: dataJson)
            data.append(value)
        }
        status = json["status"].boolValue
    }
}
class retailerDatum {

    var address : String!
    var classId : Int!
    var className : String!
    var createdAt : String!
    var descriptionField : String!
    var email : String!
    var externalId : Int!
    var id : Int!
    var image : String!
    var name : String!
    var phoneNumber : String!
    var updatedAt : String!
    var website : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = json["address"].stringValue
        classId = json["class_id"].intValue
        className = json["class_name"].stringValue
        createdAt = json["created_at"].stringValue
        descriptionField = json["description"].stringValue
        email = json["email"].stringValue
        externalId = json["external_id"].intValue
        id = json["id"].intValue
        image = json["image"].stringValue
        name = json["name"].stringValue
        phoneNumber = json["phone_number"].stringValue
        updatedAt = json["updated_at"].stringValue
        website = json["website"].stringValue
    }
}
