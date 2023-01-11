//
//  PromoModel.swift
//  Wuhu
//
//  Created by Awais on 20/11/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


class PromoModel {

    var data : [PromoDatum]!
    var message : String!
    var status : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [PromoDatum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = PromoDatum(fromJson: dataJson)
            data.append(value)
        }
        message = json["message"].stringValue
        status = json["status"].boolValue
    }
}
class PromoDatum {

    var createdAt : String!
    var deletedAt : AnyObject!
    var descriptionField : String!
    var displayType : String!
    var id : Int!
    var image : String!
    var location : String!
    var priority : Int!
    var recipeId : AnyObject!
    var title : String!
    var type : String!
    var updatedAt : String!
    var url : String!
    var videoLink : AnyObject!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        deletedAt = json["deleted_at"] as AnyObject
        descriptionField = json["description"].stringValue
        displayType = json["display_type"].stringValue
        id = json["id"].intValue
        image = json["image"].stringValue
        location = json["location"].stringValue
        priority = json["priority"].intValue
        recipeId = json["recipe_id"] as AnyObject
        title = json["title"].stringValue
        type = json["type"].stringValue
        updatedAt = json["updated_at"].stringValue
        url = json["url"].stringValue
        videoLink = json["video_link"] as AnyObject
    }
}
