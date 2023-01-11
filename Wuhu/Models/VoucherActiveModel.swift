//
//  VoucherActiveModel.swift
//  Wuhu
//
//  Created by Awais on 21/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON
class VoucherActiveModel{
    
    var data : [VoucherData]!
    var status : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [VoucherData]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = VoucherData(fromJson: dataJson)
            data.append(value)
        }
        status = json["status"].boolValue
    }
}
class VoucherData{
    
    var attachmentUrl : String!
    var basketLevel : Bool!
    var campaignId : String!
    var companyId : String!
    var customDocType : String!
    var date : Int!
    var dateadded : Int!
    var fromPunchCard : String!
    var id : String!
    var noOfUses : String!
    var personaId : Int!
    var posIbs : String!
    var promotionText : String!
    var redemptionRule : String!
    var type : String!
    var userId : Int!
    var usesRemaining : Int!
    var venueId : String!
    var voucherAmount : String!
    var voucherCode : String!
    var voucherEndDate : String!
    var voucherName : String!
    var voucherStartDate : String!
    var voucherStatus : Int!
    var voucherType : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        attachmentUrl = json["attachment_url"].stringValue
        basketLevel = json["basket_level"].boolValue
        
        campaignId = json["campaign_id"].stringValue
        companyId = json["company_id"].stringValue
        customDocType = json["custom_doc_type"].stringValue
        date = json["date"].intValue
        dateadded = json["dateadded"].intValue
        fromPunchCard = json["from_punch_card"].stringValue
        id = json["id"].stringValue
        noOfUses = json["no_of_uses"].stringValue
        personaId = json["persona_id"].intValue
        posIbs = json["pos_ibs"].stringValue
        promotionText = json["promotion_text"].stringValue
        redemptionRule = json["redemption_rule"].stringValue
        type = json["type"].stringValue
        userId = json["user_id"].intValue
        usesRemaining = json["uses_remaining"].intValue
        venueId = json["venue_id"].stringValue
        voucherAmount = json["voucher_amount"].stringValue
        voucherCode = json["voucher_code"].stringValue
        voucherEndDate = json["voucher_end_date"].stringValue
        voucherName = json["voucher_name"].stringValue
        voucherStartDate = json["voucher_start_date"].stringValue
        voucherStatus = json["voucher_status"].intValue
        voucherType = json["voucher_type"].stringValue
    }
}
