//
//  FaqCatModel.swift
//  Wuhu
//
//  Created by Awais on 12/06/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON

class FaqCatModel {
    var data : [FaqCatDatum]!
    var message : String!
    var status : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [FaqCatDatum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = FaqCatDatum(fromJson: dataJson)
            data.append(value)
        }
        message = json["message"].stringValue
        status = json["status"].boolValue
    }
}
class FaqCatDatum {
    
    var id : Int!
    var name : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}
