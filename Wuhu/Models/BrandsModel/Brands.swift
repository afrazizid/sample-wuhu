//
//  Brands.swift
//  Wuhu
//
//  Created by Awais on 06/01/2021.
//  Copyright © 2021 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


class Brands{
    
    var data : BrandDatum!
    var status : Bool!
    var message : String!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let dataJson = json["data"]
        if !dataJson.isEmpty{
            data = BrandDatum(fromJson: dataJson)
        }
        status = json["status"].boolValue
        message = json["message"].stringValue
    }
}
class BrandDatum {
    
    var brands : [Brand]!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        brands = [Brand]()
        let brandsArray = json["brands"].arrayValue
        for brandsJson in brandsArray{
            let value = Brand(fromJson: brandsJson)
            brands.append(value)
        }
    }
}
class Brand {
    
    var descriptionField : String!
    var image : String!
    var name : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        descriptionField = json["description"].stringValue
        image = json["image"].stringValue
        name = json["name"].stringValue
    }
}
