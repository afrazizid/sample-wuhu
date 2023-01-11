//
//  PrefrencesModel.swift
//  Wuhu
//
//  Created by Awais on 19/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


class PrefrencesModel{
    
    var data : [dataArr]!
    var message : String!
    var status : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [dataArr]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = dataArr(fromJson: dataJson)
            data.append(value)
        }
        message = json["message"].stringValue
        status = json["status"].boolValue
    }
}
class dataArr {
    var name : String!
    var val : [Value]!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        name = json["name"].stringValue
        val = [Value]()
        let channelTypesArray = json["value"].arrayValue
        for channelTypesJson in channelTypesArray{
            let value1 = Value(fromJson: channelTypesJson)
            
            val.append(value1)
        }
        
    }
    
}
class Value{
    
    var fieldLabel : String!
    var value : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        fieldLabel = json["field_label"].stringValue
        value = json["value"].boolValue
    }
}
