//
//  UserHandler.swift
//  GoRich
//
//  Created by Apple PC on 30/08/2017.
//  Copyright © 2017 My Technology. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserHandler:BaseVC {
    
    static let sharedInstance = UserHandler()
    //    static let myShared       = SharedData.SharedUserInfo
     
    var isFromMenu = false
    var tabbarItem = 0
    
    // MARK: - Login user
    
    class func logInUser(params: NSDictionary, success: @escaping (UserModel_Base)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.logInUser
        
        print(url)
        
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            let resp = JSON(dictionary)
            if resp["status"] == true{
            let objUserr = UserModel_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            }else{
                sharedInstance.showSwiftMessage(title: "", message: resp["message"].stringValue, type: "error")
                sharedInstance.stopAnimating()
                sharedInstance.clearDefaults()
            }
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // MARK: - SignUp user
    
    class func registerUser(params: NSDictionary, success: @escaping (SignUpBase)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.registerUser
        print(url)
        
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            
            let objUserr = SignUpBase(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // MARK: - Activate user
    class func activateUser(params: NSDictionary, success: @escaping (Generic_Base)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.activateUser
        print(url)
        
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            
            let objUserr = Generic_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // MARK: - LogOut user
    class func logOutUserCall(params: NSDictionary,success: @escaping (Generic_Base)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.logOutUser
        print(url)
        
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            
            let objUserr = Generic_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // MARK: - ForgotPassword Enter your email
    class func forgotPasswordCall(params: NSDictionary, success: @escaping (Generic_Base)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.forgotPassword
        print(url)
        
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            
            let objUserr = Generic_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // MARK: - Reset Password
    class func resetPasswordCall(params: NSDictionary, success: @escaping (Generic_Base)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.resetPassword
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            let objUserr = Generic_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // update profile with param and picture
    class func updateProfileWithParam(params: NSDictionary , imageData: Data?, success: @escaping (
        UserModel_Base)-> Void, failure: @escaping (NetworkError?)->Void) {
        
        let url = GlobalURL.baseUrl+URLExtension.updateProfile
        print(url)
        
        NetworkHandler.postRequestWithMultiFormData(url: url, imgData: imageData, fileName: "", params: params as? Parameters,  success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            let responseModel = UserModel_Base(dictionary: dictionary as NSDictionary)
            success(responseModel!)
            
        }) { (error) in
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // Refer a friend
    class func referAfriendCall(params: NSDictionary, success: @escaping (Generic_Base)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.referAFriend
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            let objUserr = Generic_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    class func referFrndData(success: @escaping (ReferFriend_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
        
        let url = GlobalURL.baseUrl+URLExtension.referFrndData
        print(url)
        
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            let responseModel = ReferFriend_Base(dictionary: dictionary as NSDictionary)
            success(responseModel!)
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: NetworkIndicators.poolConnectionError))
        }
    }
    
    
    class func pastFriend(success: @escaping (ReferFriendList_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
        
        let url = GlobalURL.baseUrl+URLExtension.pastFriend
        print(url)
        
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            let responseModel = ReferFriendList_Base(dictionary: dictionary as NSDictionary)
            success(responseModel!)
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: NetworkIndicators.poolConnectionError))
        }
    }
    
    // MARK: - Listing all Stores
    
    class func getStampData(userID: Int, success: @escaping (StampCards_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
        
        let url =  GlobalURL.baseUrl+URLExtension.getstamps + "user_id=\(userID)"
        print(url)
        
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            let responseModel = StampCards_Base(dictionary: dictionary as NSDictionary)
            success(responseModel!)
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    class func sendScanImages(params: NSDictionary, success: @escaping (Generic_Base)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.sendScanImgs
        print(url)
        
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            
            let objUserr = Generic_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
  
    // MARK: - store
    class func storeCat(params: NSDictionary, success: @escaping (StoreModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.incentive
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            
            let dataval = StoreModel(fromJson: JSON(dictionary as Any))
            
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - redeem incentive
    class func redeemIncentive(params: NSDictionary, success: @escaping (RedeemIncentive)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.redeemIncentive
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            
            let dataval = RedeemIncentive(fromJson: JSON(dictionary as Any))
            
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - claim incentive
    class func claimIncentive(params: NSDictionary, success: @escaping (ClaimIncentive)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.claimIncentive
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
    
            let dataval = ClaimIncentive(fromJson: JSON(dictionary as Any))
            
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - send observation
    class func sendObservation(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.sendObservation
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
let dictionary = successResponse as! [String: AnyObject]
print(dictionary)
            success(dictionary as NSDictionary)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - Resend code
    class func resendCode(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.resendotp
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            success(dictionary as NSDictionary)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // MARK: - get prefrences
    class func getprefrences(success: @escaping (PrefrencesModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getprefrences
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
    
            let dataval = PrefrencesModel(fromJson: JSON(dictionary as Any))
            
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - get promo
    class func getpromo(success: @escaping (PromoModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getPromo
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            
    
             let dataval = PromoModel(fromJson: JSON(dictionary as Any))
//            let resp = JSON(dictionary)
//            print(resp)
             success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - get brands
    class func getbrands(success: @escaping (Brands)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getbrand
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            
    
             let dataval = Brands(fromJson: JSON(dictionary as Any))
//            let resp = JSON(dictionary)
//            print(resp)
             success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - get past refrel
    class func getRefrel(success: @escaping (PastRefrelModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getRefrel
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            
    
             let dataval = PastRefrelModel(fromJson: JSON(dictionary as Any))
//            let resp = JSON(dictionary)
//            print(resp)
             success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - save prefrences
    class func savePrefrences(params: NSDictionary, success: @escaping (PrefrencesModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.savePrefrences
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
           let dataval = PrefrencesModel(fromJson: JSON(dictionary as Any))
                       
           success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - voucher active/expired
    class func voucherActive(params: NSDictionary, success: @escaping (VoucherActiveModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.voucherStatus
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
           let dataval = VoucherActiveModel(fromJson: JSON(dictionary as Any))
                       
           success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - donation
    class func donation(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.donation
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
//            print(dictionary)
//
//            let dataval = ClaimIncentive(fromJson: JSON(dictionary as Any))
            
            success(dictionary as NSDictionary)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - contact us
    class func contactUs(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.contactUs
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            success(dictionary as NSDictionary)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // MARK: - get Missions
    class func getMissions(success: @escaping (MissionsModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getMissions
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            
    
            let dataval = MissionsModel(fromJson: JSON(dictionary as Any))
            print(dataval)
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - get FAQ CAt
    class func getFaqCat(success: @escaping (FaqCatModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getFaqCat
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            
    
            let dataval = FaqCatModel(fromJson: JSON(dictionary as Any))
            print(dataval)
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - get FAQs
    class func getFAQs(params: NSDictionary, success: @escaping (FAQs)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getFAQs
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
           let dataval = FAQs(fromJson: JSON(dictionary as Any))
                       
           success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - getCountries
    class func getCountries(endPoint: String, success: @escaping (CountryMain)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+endPoint
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            
    
            let dataval = CountryMain(fromJson: JSON(dictionary as Any))
            print(dataval)
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - get HELP
    class func getHelp(params: NSDictionary, success: @escaping (HelpModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getHELP
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
           let dataval = HelpModel(fromJson: JSON(dictionary as Any))
                       
           success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - application Event
    class func ApplicationEvent(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.event
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
//           let dataval = HelpModel(fromJson: JSON(dictionary as Any))
                       
            success(dictionary as NSDictionary)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - video completed
    
    class func VideoEvent(params: NSDictionary, success: @escaping (VideoPoints)-> Void, failure: @escaping (NetworkError?)->Void){
        
        
        let url = GlobalURL.baseUrl+URLExtension.videoComplete
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            //           let dataval = HelpModel(fromJson: JSON(dictionary as Any))
            let dataval = VideoPoints(fromJson: JSON(dictionary as Any))
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - Activity
    class func getActivity(params: NSDictionary, success: @escaping (ActivityModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getActivity
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            
            let dataval = ActivityModel(fromJson: JSON(dictionary as Any))
            
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - receipt data
    class func receiptData(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.receiptData
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            success(dictionary as NSDictionary)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    
    // MARK: - get receipt
    class func getReceipt(params: NSDictionary, success: @escaping (getReciptModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getRec
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
           let dataval = getReciptModel(fromJson: JSON(dictionary as Any))
                       
           success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - getRetailer
    class func getRetailer(success: @escaping (RetailerModel)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getRetailer
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            
    
            let dataval = RetailerModel(fromJson: JSON(dictionary as Any))
            print(dataval)
            success(dataval)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - application Event
    class func deleteAccount(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.deleteAcc
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
//           let dataval = HelpModel(fromJson: JSON(dictionary as Any))
                       
            success(dictionary as NSDictionary)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - post FAQ
    class func postFaq(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.postFaq
        print(url)
        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            success(dictionary as NSDictionary)
            
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    // MARK: - getLogedInData
    class func getLogedInData(success: @escaping (UserModel_Base)-> Void, failure: @escaping (NetworkError?)->Void){
        
        let url = GlobalURL.baseUrl+URLExtension.getUserDataWithToken
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: AnyObject]
            print(dictionary)
            let resp = JSON(dictionary)
            if resp["status"] == true{
            let objUserr = UserModel_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
            success(objUserr!)
            }else{
               // sharedInstance.showSwiftMessage(title: "", message: resp["message"].stringValue, type: "error")
                sharedInstance.stopAnimating()
               // sharedInstance.clearDefaults()
            }
            
        }) { (error) in
            print(error)
            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
        }
    }
    /*
     // MARK: -  Current Day weather forecast
     class func currentWeather(lat: Double, long: Double, success: @escaping (CurrentWeather_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&units=metric&appid=d0b6835c77ae0405826135e2653cc941"
     print(url)
     
     NetworkHandler.getRequestWithOutHeader(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = CurrentWeather_Base(dictionary: dictionary as NSDictionary)
     print(responseModel)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     }
     }
     // MARK: -  5 days weather forecast
     class func weatherForcastForFiveDays(lat: Double, long: Double, success: @escaping (Weather_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&units=metric&appid=d0b6835c77ae0405826135e2653cc941"
     
     print(url)
     
     NetworkHandler.getRequestWithOutHeader(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = Weather_Base(dictionary: dictionary as NSDictionary)
     print(responseModel)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     }
     }
     
     
     
     
     
     
     
     // MARK: - Resend Code
     class func resendCode(params: NSDictionary, success: @escaping (Generic_Base)-> Void, failure: @escaping (NetworkError?)->Void){
     
     let url = GlobalURL.baseUrl+URLExtension.resendCode
     print(url)
     
     NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     
     let objUserr = Generic_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
     success(objUserr!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     }
     }
     
     
     
     
     
     // MARK: - HomeScreen Stores Info
     
     class func dashBoardStores(lat: Double, long: Double, success: @escaping (DashBoardStoresModel_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  "https://dev.mysoldi.co/api/v1/app/restaurants/list?type=waterco&coordinates=\(lat),\(long)"
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = DashBoardStoresModel_Base(dictionary: dictionary as NSDictionary)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     }
     }
     
     // MARK: - Listing all Stores
     
     class func giftCardListing(userID: Int, success: @escaping (GiftCards_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  "https://dev.mysoldi.co/api/v1/app/giftcard/listing?customer_id=\(userID)"
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = GiftCards_Base(dictionary: dictionary as NSDictionary)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     }
     }
     
     // MARK: - Pool Connection Check
     
     class func checkPoolConnection(success: @escaping (PoolConnectionModel_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  self.myShared.poolURL+URLExtension.poolConnection
     print(url)
     
     NetworkHandler.getRequestWithOutHeader(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = PoolConnectionModel_Base(dictionary: dictionary as NSDictionary)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: NetworkIndicators.poolConnectionError))
     }
     }
     
     // MARK: - Load pool information
     
     class func poolInfo(success: @escaping (PoolInfoModel_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  self.myShared.poolURL+URLExtension.poolInfo
     print(url)
     
     NetworkHandler.getRequestWithOutHeader(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = PoolInfoModel_Base(dictionary: dictionary as NSDictionary)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: NetworkIndicators.poolConnectionError))
     }
     }
     
     
     // MARK: - pumpOnOff
     class func pumpOnOffAPICall(params: NSDictionary, success: @escaping (PoolInfoModel_Base)-> Void, failure: @escaping (NetworkError?)->Void){
     
     let url = self.myShared.poolURL+URLExtension.electrochlorPump
     print(url)
     NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let objUserr = PoolInfoModel_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
     success(objUserr!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     }
     }
     
     // MARK: - lightOnOff
     class func lightOnOffAPICall(params: NSDictionary, success: @escaping (PoolInfoModel_Base)-> Void, failure: @escaping (NetworkError?)->Void){
     
     let url = self.myShared.poolURL+URLExtension.electrochlorLight
     print(url)
     NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let objUserr = PoolInfoModel_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
     success(objUserr!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     }
     }
     
     class func electrochlorLight(value: String, completion: @escaping (Int) -> Swift.Void)
     {
     let url =  self.myShared.poolURL+URLExtension.electrochlorLight
     
     Alamofire.upload(multipartFormData: { multipartFormData in
     multipartFormData.append((value.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "value")
     }, to: url, method: .post, headers: nil, encodingCompletion: { encodingResult in
     switch encodingResult {
     case .success(let upload, _, _):
     upload
     .validate()
     .responseJSON { response in
     
     switch response.result {
     case .success(let json):
     if let error = (json as! [String : AnyObject])["error"] as? Int
     {
     if error == 0
     {
     do{
     try electrochlorLightResponse.getSuccessResponse(Json: json as! NSDictionary)
     }catch{
     print("Failed")
     }
     completion(1)
     }else{
     electrochlorLightResponse.getFailedResponse(Json: json as! NSDictionary)
     completion(0)
     }
     }
     break
     
     case .failure(let error):
     if let err = error as? URLError, err.code == .notConnectedToInternet
     {
     completion(2)
     } else
     {
     completion(0)
     }
     break
     }
     }
     case .failure(let encodingError):
     print("encodingError: \(encodingError)")
     completion(0)
     }
     })
     }
     
     class func electrochlorPump(value: String, completion: @escaping (Int) -> Swift.Void)
     {
     let url =  self.myShared.poolURL+URLExtension.electrochlorPump
     
     Alamofire.upload(multipartFormData: { multipartFormData in
     multipartFormData.append((value.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "value")
     }, to: url, method: .post, headers: nil, encodingCompletion: { encodingResult in
     switch encodingResult {
     case .success(let upload, _, _):
     upload
     .validate()
     .responseJSON { response in
     
     switch response.result {
     case .success(let json):
     if let error = (json as! [String : AnyObject])["error"] as? Int
     {
     if error == 0
     {
     do{
     try electrochlorPumpResponse.getSuccessResponse(Json: json as! NSDictionary)
     }catch{
     print("Failed")
     }
     completion(1)
     }else{
     electrochlorPumpResponse.getFailedResponse(Json: json as! NSDictionary)
     completion(0)
     }
     }
     break
     
     case .failure(let error):
     if let err = error as? URLError, err.code == .notConnectedToInternet
     {
     completion(2)
     } else
     {
     completion(0)
     }
     break
     }
     }
     case .failure(let encodingError):
     print("encodingError: \(encodingError)")
     completion(0)
     }
     })
     }
     
     
     //    // MARK: - Update Profile
     //    class func updateProfile(params: NSDictionary, success: @escaping (Generic_Base)-> Void, failure: @escaping (NetworkError?)->Void){
     //
     //        let url = GlobalURL.baseUrl+URLExtension.forgotPass
     //        print(url)
     //        NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
     //
     //            let dictionary = successResponse as! [String: AnyObject]
     //            print(dictionary)
     //            let objUserr = Generic_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
     //            success(objUserr!)
     //
     //        }) { (error) in
     //            print(error)
     //            failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     //        }
     //    }
     
     
     
     // MARK: - Upload Profile Picture
     
     
     
     //    class func uploadMediaFileWithToken(input: [String:Any],urlString: String,fileKey:String,fileFormate:String,mimeType:String,fileData : Data?, completion: @escaping (NSDictionary?, NSError?) -> Void) {
     //
     //    //        let url = URL(string: urlString as String)!
     //    //        let userToken = KUSERDEFAULTS.value(forKey: LOGIN_USER_TOKEN) as! String
     //    //
     //    //        let authorizationKey = "Bearer " + userToken
     //    //
     //    //        let authHeader : HTTPHeaders = ["Authorization": authorizationKey, "Content-Type":"application/json"]
     //            let url = URL(string: urlString as String)
     //
     //            var userToken = String()
     //            var authorizationKey = String()
     //            var authorizationValue = String()
     //
     //            var header : HTTPHeaders = [:]
     //
     //            if ((AppUtility.getCustomObjectOfKey(key: LOGIN_USER_DATA) != nil) && ((KUSERDEFAULTS.value(forKey: LOGIN_USER_TOKEN) != nil)) ) {
     //
     //                userToken = KUSERDEFAULTS.value(forKey: LOGIN_USER_TOKEN) as! String
     //                authorizationKey = "Bearer " + userToken
     //                authorizationValue = "Authorization"
     //
     //                header = [authorizationValue: authorizationKey, "Accept":"application/json","Content-Type":"application/json"]
     //            } else {
     //                header = ["Accept":"application/json","Content-Type":"application/json", "localization":L102Language.currentAppleLanguage()]
     //            }
     //
     //            Alamofire.upload(multipartFormData: { (MultipartFormData) in
     //
     //                for (key, value) in input {
     //                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
     //
     //                }
     //                if (fileData != nil){
     //                    let fileName = "\(fileKey).\(fileFormate)"
     //                    MultipartFormData.append(fileData!, withName: fileKey, fileName: fileName, mimeType: mimeType)
     //                }
     //
     //            }, to: urlString, method : .post, headers : header) { (result) in
     //
     //                switch result {
     //                    case .success(let upload, , ):
     //
     //                        upload.responseJSON { response in
     //                            let result = response.result.value
     //
     //                            if let responseData = response.data {
     //                                let htmlString = String(data: responseData, encoding: .utf8)
     //                                print(htmlString!)
     //                            }
     //
     //                            if result == nil{
     //                                completion(nil ,NSError(domain: "Server error", code: 0, userInfo: [:]))
     //                            }
     //                            else{
     //                                let JSON = result as! NSDictionary
     //                                completion(JSON,nil);
     //                            }
     //                    }
     //
     //                    case .failure(let encodingError):
     //                        completion(nil ,encodingError as NSError?)
     //                }
     //            }
     //        }
     //
     
     
     
     
     
     class func updateProfileWithParam(params: NSDictionary , imageData: Data, success: @escaping (
     UpdateProfile_Base)-> Void, failure: @escaping (NetworkError?)->Void) {
     
     let url = GlobalURL.baseUrl+URLExtension.updateProfile
     print(url)
     
     NetworkHandler.postRequestWithMultiFormData(url: url, imgData: imageData, fileName: "", params: params as! Parameters,  success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = UpdateProfile_Base(dictionary: dictionary as NSDictionary)
     success(responseModel!)
     
     }) { (error) in
     failure(NetworkError(status: NetworkIndicators.generic, message: error.message))
     }
     }
     
     /*
     //MARK:- Change Password
     class func changePassword(params: NSDictionary, success: @escaping(UpdateProfile_Base)-> Void, failure: @escaping(NetworkError)-> Void) {
     let url = Constants.baseUrl+Constants.URL.change_Password
     print(url)
     
     NetworkHandler.postRequest(url: url, parameters: params as! Parameters, success: { (successResponse) in
     let dictionary = successResponse as! [String: Any]
     print(dictionary)
     let obj = UpdateProfile_Base(dictionary: dictionary as NSDictionary)
     success(obj!)
     }) { (error) in
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: -  Testimonials
     class func testomonialDataCall(success: @escaping (Testimonials_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.testimonials
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = Testimonials_Base(dictionary: dictionary as NSDictionary)
     print(responseModel)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     
     
     
     // MARK: -  Settings
     class func getCompanyCarList(success: @escaping (MDCompanyCars) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.company_Cars
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDCompanyCars(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     //    class func getPendingBooking(success: @escaping (MDBookingPending) -> Void, failure: @escaping (NetworkError?)-> Void) {
     //
     //        let url =  Constants.baseUrl+Constants.URL.pending_booking
     //        print(url)
     //
     //        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     //            let dictionary = successResponse as! [String: AnyObject]
     //            print(dictionary)
     //            let responseModel = MDBookingPending(dictionary: dictionary as NSDictionary)
     //            print(responseModel!)
     //            success(responseModel!)
     //        }) { (error) in
     //            print(error)
     //            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     //        }
     //    }
     
     // MARK: -  Notification
     
     class func getNotification(success: @escaping (MDNotification) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.notifications
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDNotification(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: -  Company Booking Detail
     class func getBookingDetailById(bookingId : Int, success: @escaping (MDBookingDetail) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.booking_detail_by_id + String(bookingId)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDBookingDetail(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     // MARK: - Contact
     
     class func contactCall(params: NSDictionary, success: @escaping (Contact_Base)-> Void, failure: @escaping (NetworkError?)->Void){
     
     let url = Constants.baseUrl+Constants.URL.contact_Us
     print(url)
     
     NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     
     let objUserr = Contact_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
     success(objUserr!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     
     }
     }
     
     
     // MARK: -  UserCarListingAPICall
     class func userCarListing(success: @escaping (UserCarListing_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.cars_Listing //+ String(brand) + String(min_price) + String(max_price) + String(sort_by)
     
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = UserCarListing_Base(dictionary: dictionary as NSDictionary)
     print(responseModel)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     // MARK: -  UserCarDetailAPICall
     class func userCarDetail(selectedObject: Int, success: @escaping (UserCarDetail_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     var url =  Constants.baseUrl+Constants.URL.cars_Detail
     url.append("\(selectedObject)")
     
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = UserCarDetail_Base(dictionary: dictionary as NSDictionary)
     print(responseModel)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: - Create Companuy
     class func createCompany(fileUrl:URL, params: NSDictionary,success: @escaping (MDMessage)-> Void, failure: @escaping (NetworkError?)->Void){
     let url = Constants.baseUrl+Constants.URL.company_Create
     print(url)
     
     print(url)
     NetworkHandler.upload(url: url, fileUrl: fileUrl, fileName: "image", params: params as? Parameters, uploadProgress: { (progess) in
     print(Progress())
     }, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     let objData = MDMessage(dictionary: dictionary as NSDictionary)
     success(objData!)
     
     }) { (error) in
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: -  Pages
     class func pages(pageName : String, success: @escaping (Pages_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.pages + String(pageName)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = Pages_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: -  Faqs
     class func faqCall(pageName : String, success: @escaping (Faq_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.pages + String(pageName)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = Faq_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: -  Unread Notification
     class func unreadNotific( success: @escaping (Unread_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.Un_Read_Notifications
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = Unread_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: -  Read Notification
     class func readNotific(notificationId : Int, success: @escaping (ReadNotification_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.read_Notificatoins + String(notificationId)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = ReadNotification_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: -  Companies Listing on Map
     class func listCompanies( success: @escaping (CompanyListing_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.companies_Listing
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = CompanyListing_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     
     // MARK: -  Notification
     class func notificationDataCall(success: @escaping (Testimonials_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.notifications
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = Testimonials_Base(dictionary: dictionary as NSDictionary)
     print(responseModel)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     
     class func getPendingBooking(bookingUrl: String, success: @escaping (MDBookingPending) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     //        let url =  Constants.baseUrl
     //        self.url.append("\(bookingUrl)")
     //        print(url)
     
     NetworkHandler.getRequest(url: bookingUrl, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDBookingPending(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     class func rescheduleBooking(bookingId : Int, success: @escaping (MDRescheduleBooking) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.reschedule_booking + String(bookingId)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDRescheduleBooking(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func cancelBooking(bookingId : Int, success: @escaping (MDMessage) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.cancel_Booking + String(bookingId)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary   = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDMessage(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func requestPayment(bookingId : Int, success: @escaping (MDMessage) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.request_payment + String(bookingId)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDMessage(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     class func getCarDetailById(bookingId : Int, success: @escaping (MDCarDetailbyId) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.car_detail_by_id + String(bookingId)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDCarDetailbyId(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func getClientList(success: @escaping (MDClientList) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.client_listing
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDClientList(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func getClientDetail(clientId: Int, date_filter: Int, is_select_date: Bool, success: @escaping (MDClientDetailByid) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     var url =  Constants.baseUrl+Constants.URL.client_detail_by_id + String(clientId)
     
     if(is_select_date == true)
     {
     url =  Constants.baseUrl+Constants.URL.client_detail_by_id + String(clientId) + "&pickup_date=\(date_filter)"
     }
     else
     {
     url =  Constants.baseUrl+Constants.URL.client_detail_by_id + String(clientId)
     }
     
     
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDClientDetailByid(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func getCompanyReviews(success: @escaping (MDCompanyReviews) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.reviews_company
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDCompanyReviews(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func getClientListByCarId(car_id : Int, success: @escaping (MDClientList) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.car_client_list + String(car_id)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDClientList(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func getCarReviewsbyCarId(car_id : Int, success: @escaping (MDCarReviews) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.car_reviews_list + String(car_id)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDCarReviews(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     
     // MARK: -
     class func uploadImageCars(fileUrl:URL, params: NSDictionary,success: @escaping (MDMessage)-> Void, failure: @escaping (NetworkError?)->Void){
     let url =  Constants.baseUrl+Constants.URL.manage_Car_Images
     print(url)
     NetworkHandler.upload(url: url, fileUrl: fileUrl, fileName: "images", params: params as? Parameters, uploadProgress: { (progess) in
     print(Progress())
     }, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     let objData = MDMessage(dictionary: dictionary as NSDictionary)
     success(objData!)
     }) { (error) in
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func setCarDefaultImage(car_id : Int, image_id : Int, success: @escaping (MDMessage) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.car_default_image + "\(car_id)&image_id=\(image_id)"
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDMessage(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func deleteCarImage(car_id : Int, image_id : Int, success: @escaping (MDMessage) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.car_delete_image + "\(car_id)&image_id=\(image_id)"
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDMessage(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func deleteCar(car_id : Int, success: @escaping (MDMessage) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.delete_Car + "\(car_id)"
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDMessage(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func getAttributes(success: @escaping (MDAttributeCompany) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.car_attributes
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = MDAttributeCompany(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     class func createCar(fileUrl:URL, params: NSDictionary,success: @escaping (MDMessage)-> Void, failure: @escaping (NetworkError?)->Void){
     let url = Constants.baseUrl+Constants.URL.add_Car
     print(url)
     
     NetworkHandler.upload(url: url, fileUrl: fileUrl, fileName: "image", params: params as? Parameters, uploadProgress: { (progess) in
     print(Progress())
     }, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     let objData = MDMessage(dictionary: dictionary as NSDictionary)
     success(objData!)
     
     }) { (error) in
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     
     
     
     
     
     
     
     
     //+++++++++++++++++++++++++++++++++++++++++++++Afraz Ali Latest Work +++++++++++++++++++++++++++++++++++++++++++++++++++
     
     // MARK: -  Company Booking Detail
     class func getUserBookingDetailById(bookingId : Int, success: @escaping (UserBookingDetail_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.booking_detail_by_id + String(bookingId)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = UserBookingDetail_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     //MARK: - Geting UserMyBooking Detials
     
     class func getUserPendingBooking(bookingUrl: String, success: @escaping (UserMyBooking_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     //        let url =  Constants.baseUrl
     //        self.url.append("\(bookingUrl)")
     //        print(url)
     
     NetworkHandler.getRequest(url: bookingUrl, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = UserMyBooking_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     // MARK: -  Company Details
     class func getCompanyDetailsById(companyId : Int, success: @escaping (CompanyDetails_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.companies_Detail + String(companyId)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = CompanyDetails_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     // MARK: -  IsFavourit
     
     class func isFavourite(carID : Int, success: @escaping (IsFavourit_Base) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.make_car_favourite + String(carID)
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = IsFavourit_Base(dictionary: dictionary as NSDictionary)
     print(responseModel!)
     success(responseModel!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     // MARK: - CreateCarBooking
     class func createCarBooking(params: NSDictionary, success: @escaping (CreateCarBooking_Base)-> Void, failure: @escaping (NetworkError?)->Void){
     
     let url = Constants.baseUrl+Constants.URL.create_car_booking
     print(url)
     
     NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     
     let objUserr = CreateCarBooking_Base(dictionary: (dictionary as NSDictionary) as! [String : Any] as NSDictionary)
     success(objUserr!)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     
     }
     }
     
     //MARK: - Social LogIn
     
     //MARK: - FacebookLogIn
     class func facebookLogIn(socialID : String, success: @escaping (UserResponse) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.facebook_Log_In + socialID
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = UserResponse(fromDictionary: (dictionary as NSDictionary) as! [String : Any])
     print(responseModel)
     success(responseModel)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     //MARK: - GoogleLogin
     
     class func googleLogIn(socialID : String, success: @escaping (UserResponse) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.google_Log_In + socialID
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = UserResponse(fromDictionary: (dictionary as NSDictionary) as! [String : Any])
     print(responseModel)
     success(responseModel)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     //MARK: - Instagram logIn
     
     class func InstaLogIn(socialID : String, success: @escaping (UserResponse) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     let url =  Constants.baseUrl+Constants.URL.google_Log_In + socialID
     print(url)
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = UserResponse(fromDictionary: (dictionary as NSDictionary) as! [String : Any])
     print(responseModel)
     success(responseModel)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     
     
     /*
     
     class func subCategory(url: String ,success: @escaping (SubCategories) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = SubCategories(fromDictionary: dictionary)
     success(responseModel)
     print(responseModel)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     class func drugSearchCall(url : String , success: @escaping (RootClass) -> Void, failure: @escaping (NetworkError?)-> Void) {
     
     NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     let responseModel = RootClass(fromDictionary: dictionary)
     success(responseModel)
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     }
     }
     class func contactUs(params: NSDictionary, success: @escaping (NSDictionary)-> Void, failure: @escaping (NetworkError?)->Void) {
     
     let url = Constants.baseUrl+Constants.URL.contactUs
     print(url)
     
     NetworkHandler.postRequest(url: url, parameters: params as? Parameters, success: { (successResponse) in
     let dictionary = successResponse as! [String: AnyObject]
     print(dictionary)
     success(dictionary as NSDictionary)
     
     }) { (error) in
     print(error)
     failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
     
     }
     }
     /*
     }
     
     */*/*/*/
    
}
