//
//  Constants.swift
//  WATERCO
//
//  Created by Apple PC on 21/08/2017.
//  Copyright © 2019 Engr.aqadar@gmail.com. All rights reserved.


import Foundation
import UIKit
import SwiftyJSON
import ACPCore
import BlinkReceipt
import Alamofire
struct GlobalURL {
    
    static var baseUrl: String {
        
        var baseurl = ""
        #if Wuhu
        baseurl = "https://wuhu.engage.dev.ire.darkwing.io/api/" // Dev
        #elseif WuhuQA
        baseurl = "https://wuhu.engage.qa.ire.soldi.io/api/" // QA
        #elseif WuhuPROD
        baseurl = "https://wuhu.engage.prod.ire.soldi.io/api/" // prod
        #endif
        
        return baseurl
    }
    
    static var soldiUrl: String {

        var soldiurl = ""
        #if Wuhu
        soldiurl = "https://wuhu.pos.darkwing.io/api/v1/app/" // Dev
        #elseif WuhuQA
        soldiurl = "https://wuhu.pos.qa.ire.soldi.io/api/v1/app/" // QA
        #elseif WuhuPROD
        soldiurl = "https://wuhu.pos.qa.ire.soldi.io/api/v1/app/" // prod
        #endif
        
        return soldiurl
    }
    static var quizBaseUrl: String {
        
        var quizBase = ""
        #if Wuhu
        // Dev
        quizBase = "https://wuhu.engage.dev.ire.darkwing.io/"
        #elseif WuhuQA
        // QA
        quizBase = "https://wuhu.engage.qa.ire.soldi.io/"
        #elseif WuhuPROD
        // prod
        quizBase = "https://wuhu.engage.prod.ire.soldi.io/"
        #endif
        return quizBase
    }
    static var matomoUrl: String {
        
        var matoURL = ""
        #if Wuhu
        // Dev
        matoURL = "https://analytics.dev.syd.darkwing.io/"
        #elseif WuhuQA
        // QA
        matoURL = "https://analytics.dev.syd.darkwing.io/"
        #endif
        return matoURL
    }
    static var imgPath : String {
        
        var imgpath = ""
        #if Wuhu
        imgpath = "https://wuhu.engage.dev.ire.darkwing.io/users/thumbs/thumb_" // Dev
        #elseif WuhuQA
        imgpath = "https://wuhu.engage.qa.ire.soldi.io/users/thumbs/thumb_" // QA
        #elseif WuhuPROD
        imgpath = "https://wuhu.engage.prod.ire.soldi.io/users/thumbs/thumb_" // pro
        #endif
        
        return imgpath

    }
}

struct URLExtension {
    
    static let logInUser                 = "user-login"
    static let registerUser              = "user/register"
    static let activateUser              = "activate-user"
    static let logOutUser                = "user-logout"
    static let forgotPassword            = "user-forgot-password"
    static let resetPassword             = "user-reset-password"
    static let updateProfile             = "user/profile"
    static let referAFriend              = "send-referral-code"
    static let incentive                 = "get-incentive"
    static let redeemIncentive           = "redeem-incentive"
    static let claimIncentive            = "claim-incentive"
    static let donation                  = "user-donations"
    
    static let getprefrences            = "get-user-preferences"
    static let getPromo                 = "get-offers?zone=dashboard"
    static let getbrand                 = "get-brand-data"
    static let getRefrel                 = "get-past-referral"
    static let getMissions              = "gamification-vp"
    static let getRetailer              = "get-list-store-configuration"
    static let getFaqCat                = "get-faq-categories"
    static let savePrefrences            = "save-user-preference"
    static let voucherStatus            = "voucher-status"
    static let getFAQs                  = "faqs-list"
    static let getRec                  = "get-receipt-data"
    static let getHELP                  = "help"
    static let event                    = "application_event"
    static let deleteAcc                = "delete-member"
    static let videoComplete            = "video-completed"
    static let sendObservation           = "send-observation"
    static let resendotp                 = "resend-code"
    static let contactUs                 = "contact-us"
    static let postFaq                   = "faq-feedback"
    static let receiptData                = "get-scan-receipt"
    static let pastFriend                = "past-referrals"
    static let referFrndData             = "refer-screen-data"
    static let sendScanImgs             = "submit-slip"
    static let getstamps                = "get-stamps?"
    static let getCountries             = "get-countries"
    static let getActivity              = "activity-listing"
    

    static let pages                = "pages?slug="
    static let bearer               = "Bearer"
    static let getUserDataWithToken               = "auth-user"
    
}

struct ActivitySize {
      static let size = CGSize(width: 40, height: 40)
  }
  
struct General {
    
    static var hashIndexArray                 = [3,5,9,10,13,15] 
    static var amplifyAPIKey             = "29a465406db18554bec793237b681572"
    static let fontName                  = "Roboto-Regular"
    static var countryCodeArray                 = ["+92", "+61", "+27"]
    static var provinceArray                    = ["Washington DC", "Sydney"]
    static var EnquireArray                    = ["General enquiries", "Till slip scanning and points","Reward store and vouchers","Mission and stamp cards","Promos and Competitions"]


    static var flagImageArray                   = ["africaFlage","ausFlage", "africaFlage"]
    static var dayArray                         = ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"]
    static let loadingMessage                   = "Loading..."
    
    static var countryNameArray                 = ["Windies","United Kingdom", "Unite State", "Austrailia"]
    static var QuizArray                    = ["Input Item 1", "Input Item 2","Input Item 3","Input Item 4"]
    
    
}
  

struct Api {
    struct status {
        static let ok = 200
        static let error = 400
    }
}
    
struct NetworkIndicators {
    
    static let statusOK = 200
    static let genericSuccess                       = "Server update sucessfully"

    static let timeOutInterval: TimeInterval        = 30

    static let error                                = "Error"
    static let internetNotAvailable                 = "Internet Not Available"
    static let pleaseTryAgain                       = "Please Try Again."
    
    static let generic                              = 4000
    static let genericError                         = "Please Try Again."
    static let poolConnectionError                  = "Your pool isnt connected with Server please check your proper vpn network"
    
    static let validationErrorMessage               = "All missing fields are required."

    static let serverErrorCode                      = 5000
    static let serverNotAvailable                   = "Server Not Available"
    static let serverError                          = "Server Not Availabe, Please Try Later."
    
    static let timout                               = 4001
    static let timoutError                          = "Can't connect to Server."//"Network Time Out, Please Try Again."
    
    static let login                                = 4003
    static let loginMessage                         = "Unable To Login"
    static let loginError                           = "Please Try Again."
    
    static let internet                             = 4004
    static let internetError                        = "Internet Not Available"
    

}

struct AlertTitle {
    static let info                    = "Info!";
    static let done                     = "Done!";
    static let error                    = "Error!";
    static let warning                  = "Warning!";
    static let oops                     = "Oops!";
    static let success                  = "Success!";
    static let logout                   = "Are you sure you want to logout?"
}

struct AlertMsg {
    
    static let somethingWrong              = "Something went wrong"
    static let underDevelopment            = "This feature is coming soon."
    static let missingFields               = "Some fields are missing."
    static let fNameRequire                = "Please provide your first name."
    static let fNameRange                  = "First name needs to be less than 40 characters. Please try again."
    static let lNameRequire                = "Please provide your last name."
    static let lNameRange                  = "Last name needs to be less than 40 characters. Please try again."
    static let standNumberRequired         = "Please provide stand number."
    static let profileImgRequired          = "Please provide profile image."
    
    static let frndFNameRequire                = "Please enter your friend's first name."
    static let frndLNameRequire                = "Please enter your friend's last name."
    static let frndEmail                = "Please enter your friend's email address."
    static let frndValidEmail                = "Please enter a valid email address."
    static let frndCell                = "Please enter your friend's cell phone number"
    static let frndInvalidCell               = "Please enter a valid cellphone number starting with 0"

    static let emailRequire                = "Email address is required."
    static let operationNotAllowed         = "This operation is not allowed."

    static let emailValid                  = "Oops! Email address is invalid. Please try again."
    static let invalidPhone                = "Please enter a valid cellphone number starting with 0"
    static let nullPhone                  = "Oops! Please enter your cellphone number."
    static let phoneValid                  = "Please enter your cellphone number. We need this to verify your account."
    static let emptyPhone               = "Please enter your cell phone number you registered with and we will send you a code to change your password"
    static let enterAny                  = "Please enter your email or phone number we need to send you invite."


    static let oldPasswordRequire          = "Old password is required."
    static let passwordRequire             = "Please provide your password."
    static let minimumPass                 = "Please enter password that is more than 8 characters."
    static let pinRequired                 = "Please enter the pin code we sent to you."


    static let addressRequired                 = "User Address is required."
    static let cityRequired                 = "User city name is required."
    static let provinceRequired                 = "User province name is required."
    static let countryRequired                 = "User country name is required."
    static let zipRequired                 = "User zip code is required."
    static let dobRequired                 = "User date of birth is required."

    static let confirmPasswordRequire      = "Please confirm your password."
    static let pinNumberRequire            = "Please enter the pin code we sent to you."
    static let dayRequire                  = "Day is required."
    static let monthRequire                = "Month is required."
    static let yearRequire                 = "Year is required."
    static let cardHolderNameRequire       = "Cardholder name is required."
    static let cardNoRequire               = "The credit card number is invalid. Please try again."
    static let cardCVVRequire              = "Card CVV2 name is required."
    static let expiryRequire               = "Please enter your card expiry date."
    static let noCards                     = "No cards list found."
    static let ownAmountRequire            = "Own amount is required."
    static let messageRequire              = "Message should not be empty."
    static let cvvRequire                  = "Please enter your card CVV number."
    static let getLocationFailed           = "Failed to get current location."
    static let loadLocationFailed          = "Failed to load location."
    static let passwordMatch               = "Oops, your passwords dont match, please try again."
    static let ageConfirm                  = "Please confirm if you are over 18 years of age."

    static let termsConfirm   = "Please accept the Terms of Use to proceed."
    static let mobileNoIncompleteRequire   = "Mobile Number is incomplete."
    static let internetRequire             = "No internet connection available."
    static let alphanumericpassRequire     = "Please create a password for your account. Your password must be at least 8 characters long, with at least one number, one uppercase letter, one lowercase letter and one special symbol."
    static let cantOpenLibrary             = "Can't open photo library."
    static let cantOpenCamera              = "This device doesn't have a camera."
    static let permissionCamera            = "Alert! Please allow camera and gallery permission to scan your slips to earn points."
    static let noContent                   = "No content found."
    static let noPaymentQuestions          = "No payment questions found."
    static let noOrderQuestions            = "No orders questions found."
    static let noQuestions                 = "No questions found."
    static let noOrderTime                 = "Please select order time."
    static let noItem                      = "Item quantity should not be zero."
    static let addedItem                   = "Item is added successfully."
    static let addedDeal                   = "Deal is added successfully."
    static let updatedItem                 = "Item is updated successfully."
    static let noProducts                  = "Please add products to checkout."
    static let tblNorequire                = "Please choose table number."
    static let voucherSelected             = "There is already a voucher selecetd."
    static let voucherAvail                = "This type of voucher is not valid for any cart product."
    static let toppingSelectionRange       = "Topping selection range is"
    static let wrongDate                   = "Please enter correct date."
    static let noTableNumber               = "Selected table number exceed from it's range in the restaurant."
    static let storingData                 = "Please consent to this app storing your data if you want to continue."
    static let futureExpiry                = "Expiry date should be in future."
    static let noRestaurant                = "Restaurant not found."
    static let ignoreQty                   = "Quantity should less than available quantity."
    static let requireTopping              = "Please select required toppings."
}

struct AlertButton {
    static let ok                          = "Ok"
    static let no                          = "No"
    static let cancel                      = "Cancel"
    static let yes                         = "Yes"
}

struct CellIdentifier {
    static let HomeCell                    = ""
}

struct StoryBoardIdentifier {
    
    static let PasswordRecoveryVC          = "ForgotPasswordVC"
    static let VerificationVC              = "VerificationVC"
    static let EditProfileVC               = "EditProfileVC"
    static let SignUpVC                    = "SignUpVC"
    
    
}

struct KeyChainKeys {
    
    static let userEmail    : String         = "userEmail"
    static let userPhone    : String         = "userPhone"

    static let userPassword : String         = "userPassword"
    static let userID       : String         = "userID"
    static let isLogedIn    : String         = "isLogedIn"
    static let userAuthToken : String        = "userAuthToken"
    

}

struct getPoints {
   static func points(rs:Int) -> Int{
        
        return rs*10
        
    }
    static func rs(point:Int) -> Int{
        return point/10
    }
}
struct AdobeTag {
    
    static func event(key:String,value:String){
        
        var contextData : [String: String]
        contextData = [
            key              : value
        ]
        ACPCore.start {
            ACPCore.lifecycleStart(contextData)
        }
    }
}
struct Applicationevents {
//    import SwiftyJSON
    
    
    static func postInfo(string:String){
        
        var parameters : [String: Any]
        parameters = [
            "event_name"              : string
            
        ]
        
        print(parameters)
        UserHandler.ApplicationEvent(params: parameters as NSDictionary, success: { (successResponse) in
            let resp = JSON(successResponse)
            
            if resp["status"] == true {
//             self.showSwiftMessage(title: "", message: resp["message"].stringValue, type: "success")
            }else  {
//                self.showSwiftMessage(title: AlertTitle.warning, message: resp["message"].stringValue, type: "error")
            }
        }) { (error) in
//            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    static func sendImages(receiptId:String ,imgArr:[UIImage])
    {
        if Network.isAvailable == true {
            
            let url = GlobalURL.baseUrl+URLExtension.sendScanImgs
            let myUrl = URL(string: url)
            let request = NSMutableURLRequest(url:myUrl!);
            request.httpMethod = "POST";
            
            var headers: HTTPHeaders
            guard let userToken = UserDefaults.standard.value(forKey: KeyChainKeys.userAuthToken) as? String else {
                
                headers = [
                    "Accept": "application/json",
                    "Content-Type" : "application/json"
                ]
                return
            }
            
            headers = [
                "Accept": "application/json",
                "Authorization" : "Bearer \(userToken)"
            ]
            
            
//                        self.showLoader()
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    if imgArr.count > 0 {
                        //                        for (index, obj) in (self.imgArr.enumerated()) {
                        //                            multipartFormData.append(self.compressImageWithAspectRatio(image: obj), withName: "slip\(index+1)", fileName: "slip\(index+1).png", mimeType: "slip/png")
                        //                        }
                        multipartFormData.append("\(receiptId)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"receipt_id")
                        for (_, obj) in (imgArr.enumerated()) {
                            multipartFormData.append(compressImageWithAspectRatio(image: obj), withName: "slip[]", fileName: "slip.png", mimeType: "slip/png")
                        }
                        //
                        //                        for (_, value) in self.imgArr.enumerated() {
                        //                            multipartFormData.append(value.jpegData(compressionQuality: 0.5)!, withName: "slip[]", fileName: "slip", mimeType: "slip/jpeg")
                        //                        }
                    }else {
//                        let alertView = AlertView.failed(message: "You must have to select atleast one picture.", okAction: {
//                        })
//                        self.present(alertView, animated: true, completion: nil)
                    }
                    // import parameters
                    //                    for (key, value) in parameters {
                    //                        let val = value as! String
                    //                        multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                    //                    }
                },
                
                usingThreshold:UInt64.init(),
                to:URL(string: GlobalURL.baseUrl+URLExtension.sendScanImgs)!,
                method:.post,
                headers:headers,
                encodingCompletion: { encodingResult in
                    
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if(response.result.value != nil){

                            }else{

                            }
                        }
                    case .failure(let encodingError):
                        print(encodingResult)
                    }
                })
        } else {
            
        }
    }
   static func compressImageWithAspectRatio (image: UIImage) -> Data {

        let data = image.jpegData(compressionQuality: 0.5)
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(data!.count))
        print("Data size is: \(string)")
        print(image.size.height)
        print(image.size.width)

        let separatedString = string.components(separatedBy: " ")
        print(separatedString)
        let dataLenth = separatedString[0]
        //let removedComma = dataLenth.stringByReplacingOccurrencesOfString(",", withString: "")
        let removedComma = dataLenth.replacingOccurrences(of: ",", with: "")
        print(Int(removedComma)!)
        
        if(Int(removedComma)! > 200 ){
            let actualHeight:CGFloat = image.size.height
            let actualWidth:CGFloat = image.size.width
            
            let imgRatio:CGFloat = actualWidth/actualHeight
            let maxWidth:CGFloat = 1440.0
            let resizedHeight:CGFloat = maxWidth/imgRatio
            let compressionQuality:CGFloat = 0.5
            
            let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
            UIGraphicsBeginImageContext(rect.size)
            //image.drawInRect(rect)
            image.draw(in: rect)
            let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            let imageData = image.jpegData(compressionQuality: compressionQuality)!
            
            UIGraphicsEndImageContext()
            print("Data size is: \(imageData.count)")
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
            bcf.countStyle = .file
            let string = bcf.string(fromByteCount: Int64(imageData.count))
            print("Data size is: \(string)")
            return imageData
            
        } else{
            return data!
        }
        //return UIImage(data: imageData)!
    }
}
