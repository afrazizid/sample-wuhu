//
//  VideoPoints.swift
//  Wuhu
//
//  Created by Awais on 28/07/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON

class VideoPoints {
    
    
    var message : String!
    var points : Int!
    var status : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        message = json["message"].stringValue
        points = json["points"].intValue
        status = json["status"].boolValue
    }
}
