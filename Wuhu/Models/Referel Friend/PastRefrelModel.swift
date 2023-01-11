//
//  PastRefrelModel.swift
//  Wuhu
//
//  Created by Awais on 07/01/2021.
//  Copyright © 2021 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


class PastRefrelModel {

    var data : [PastDatum]!
    var status : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [PastDatum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = PastDatum(fromJson: dataJson)
            data.append(value)
        }
        status = json["status"].boolValue
    }
}
class PastDatum {

    var createdAt : String!
    var email : String!
    var id : Int!
    var isSignup : Int!
    var name : String!
    var phone : String!
    var points : AnyObject!
    var updatedAt : AnyObject!
    var userId : Int!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        email = json["email"].stringValue
        id = json["id"].intValue
        isSignup = json["is_signup"].intValue
        name = json["name"].stringValue
        phone = json["phone"].stringValue
        points = json["points"] as AnyObject
        updatedAt = json["updated_at"] as AnyObject
        userId = json["user_id"].intValue
    }
}
