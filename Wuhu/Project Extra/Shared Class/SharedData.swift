//
//  SharedData.swift
//  Rent Cars
//
//  Created by My Technology on 06/06/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import UIKit

class SharedData  {
    static let SharedUserInfo = SharedData()
    
    var userInfo         : UserData?
    
    var currentLat       = Double()
    var currentLong      = Double()
    var userLocation     = String()
    var poolURL          = String()
    
    var selectedTab     = 0
    
 
    var signUpParam : [String: Any] = [
        "first_name"    : "",
        "last_name"     : "",
        "email"         : "",
//        "dob"           : "",
//        "referal_code"  : "",
        "phone"         : "",
//        "amplify_secret": "29a465406db18554bec793237b681572",
//        "default_venue" : "97376",
//        "is_email"      : "",
        "country_code"    : "",
//        "region_type"   : "uk",
//        "company_id"    : "2",
        "device_type"   : "ios",
        "device_id"     : "",
        "device_token"  : ""
    ]
        var activateParam : [String: Any] = [
            "password"    : "",
            "device_type"     : "ios",
            "user_id"         : "",
            "code"         : "",
            "is_existing_user"   : "0",
            "device_token"     : "",
            "system"           : false,
            "marketing"        : false
        ]
}
