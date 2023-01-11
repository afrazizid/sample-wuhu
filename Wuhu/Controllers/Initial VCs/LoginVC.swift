//
//  LoginVC.swift
//  WATERCO
//
//  Created by afrazali on 11/10/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import UIKit
import ACPCore
import SwiftyJSON
class LoginVC: BaseVC,CountryListDelegate {
    
    
    
    // MARK: -  IBOutlets
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var tickEmail: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var passView: UIView!
    
    @IBOutlet weak var tempPhoneBtn: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var txt_pass: UITextField!
    
    @IBOutlet weak var btnLogIn: UIButton!
    var countryList = CountryList()
    var countryCode = ""
    var countriesList = [CountryModel]()
    // MARK: -  Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        countryList.delegate = self
        getCountries()
        // Do any additional setup after loading the view.
    }
    func getCountries(){
        self.showLoader()
        UserHandler.getCountries(endPoint: "get-countries", success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.countriesList = successResponse.data
                for i in self.countriesList{
                    if i.isDefault{
                        self.countryLbl.text = (i.flag!) + " +" + i.phoneExtension
                        
                        self.countryCode =  "+"+"\(i.phoneExtension ?? "")"
                        
                        //                        self.getCountryWithCode(code: "+"+"\(i.phoneExtension ?? "")")
                        break
                        //                        }else{
                        //                            self.tempPhoneBtn.isHidden = false
                    }
                }
                
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.hideNavigationBar()
        
        //        self.txt_email.text = "engr.aqadar@gmail.com"
        //        self.txt_pass.text = "Apple123"
        
        //        if self.KC_isLogedIn != nil {
        //            print(self.KC_isLogedIn)
        //            if self.KC_isLogedIn == true {
        //                self.autoLogIn()
        //            }
        //        }
    }
    
    
    // MARK: -  IBActions
    @IBAction func actionEye(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            
            self.txt_pass.isSecureTextEntry = false
            
        }else {
            
            self.txt_pass.isSecureTextEntry = true
            
        }
    }
    
    @IBAction func actionForgotPassword(_ sender: UIButton) {
        
        self.pushController(name: StoryBoardIdentifier.PasswordRecoveryVC)
        
    }
    
    
    @IBAction func actionLogIn(_ sender: Any) {
        
        if isCheck() {
            
            self.logInAPICall()
        }
    }
    
    @IBAction func btnCountry(_ sender: Any) {
        self.emailView.setCustomView()
        self.passView.setNormalTxtView()
        CountryList.endpoint = "get-countries"
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    
    @IBAction func actionBtnBack(_ sender: Any) {
        self.popVC()
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        self.pushController(name: "SignUpVC1")
    }
    
    // MARK: - Custom Function
    
    func setUIElements() {
        
        self.btnLogIn.setBtnUI()
        self.emailView.setNormalTxtView()
        self.passView.setNormalTxtView()
        self.tickEmail.image = UIImage(named: "cross")
        self.txt_email.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
        //        self.txt_email.text =  "damian@plutuscommerce.com"//"Engr.aqadar@gmail.com"
        //        self.txt_pass.text = "PlutusP@$$123"//"Apple123"
        
    }
    @objc func textFieldEditingDidChange(){
        //       checkFields()
        //        let str = txt_email.text?.count
        if (txt_email.text!.count >= 6) {
            self.tickEmail.image = UIImage(named: "tick")
        }else {
            self.tickEmail.image = UIImage(named: "cross")
            
        }
    }
    func isCheck() -> Bool {
        
        let email               = self.txt_email.text
        let password            = self.txt_pass.text
        
        if email == ""{
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.nullPhone, type: "error")
            self.tickEmail.image = UIImage(named: "cross")
            self.emailView.setCustomView()
            return false
        }
        if  email!.count < 6  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.invalidPhone, type: "error")
            self.tickEmail.image = UIImage(named: "cross")
            self.emailView.setCustomView()
            return false
        }
        
        if password == "" {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.passwordRequire, type: "error")
            self.passView.setCustomView()
            return false
        }
        let decimalRange = password!.rangeOfCharacter(from: CharacterSet.decimalDigits)
        let letterRange = password!.rangeOfCharacter(from: CharacterSet.letters)
        if password!.count < 8 || decimalRange == nil || letterRange == nil || !password!.containsSpecialCharacter{
            
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.alphanumericpassRequire, type: "error")
            self.passView.setCustomView()
            return false
            
        }
        
        
        
        return true
    }
    
    public func autoLogIn() {
        let KC_isLogedIn    = UserDefaults.standard.bool(forKey: KeyChainKeys.isLogedIn)
        
        if KC_isLogedIn == true {
            
            if let userToken = UserDefaults.standard.value(forKey: KeyChainKeys.userAuthToken) as? String {
                print(userToken)
                if userToken != ""{
                    self.logedInUserData()
                }
                
            }else{
               // self.showSwiftMessage(title: AlertTitle.warning, message:"Please login again", type: "error")
            }
            
            
            
        }else{
            
            self.logInAPICall()
        }
    }
    
    
    
    //MARK: - API Calls
    func resendOtp(){
        
        var parameters : [String: Any]
        parameters = [
            "phone"           :self.txt_email.text ?? "",
            "user_id"            : KC_userID,
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.resendCode(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let resp = JSON(successResponse)
            print(resp)
            if resp["status"] == true {
                self.Shared.activateParam["is_existing_user"] = "1"
                let viewPush = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC4") as? SignUpVC4
                let Ph_number  = self.getPhoneNumber(countryCode: self.countryCode, actualPhoneNumber: self.setMobile(number: self.txt_email.text ?? ""))
                viewPush?.PhoneNumber = Ph_number
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.pushViewController(viewPush!, animated: true)
                // self.pushController(name: "SignUpVC4")
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: resp["message"].stringValue, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func logedInUserData(){
        
        self.showLoader()
        UserHandler.getLogedInData(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                Applicationevents.postInfo(string: "login")
                
                AdobeTag.event(key: "mData.event.loggedinStatus", value: "true")
                self.matomoTracker.track(view: ["mData.event.loggedinStatus","true"])
                print(successResponse.data?.blinkData?[1].name ?? "Aws")
                self.Shared.userInfo = successResponse.data
                //                UserDefaults.standard.set(myEmail, forKey: KeyChainKeys.userPhone)
                //                UserDefaults.standard.set(myPass, forKey: KeyChainKeys.userPassword)
                UserDefaults.standard.set(true, forKey: KeyChainKeys.isLogedIn)
                UserDefaults.standard.set(successResponse.access_token_info?.access_token, forKey: KeyChainKeys.userAuthToken)
                
                if let userid = successResponse.data?.user_id {
                    UserDefaults.standard.set(userid, forKey: KeyChainKeys.userID)
                    print(self.KC_userID)
                }
                
                print(successResponse.data?.is_active)
                if successResponse.data?.is_active == 1 {
                    self.AppDelegate.moveToHome()
                }else {
                    self.resendOtp()
                }
            }else  {
                
                AdobeTag.event(key: "mData.event.loggedinStatus", value: "false")
                self.matomoTracker.track(view: ["mData.event.loggedinStatus","false"])
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
                
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    
    func logInAPICall(){
        print(KC_Walk)
        
        #if DEBUG
        let YourAppIsDebug = "0"
        #else
        let YourAppIsDebug = "1"
        
        #endif
        
        var myEmail = ""
        var myPass  = ""
        myEmail = self.getPhoneNumber(countryCode: countryCode, actualPhoneNumber: setMobile(number: self.txt_email.text!))
        myPass  = self.txt_pass.text!
        // }
        var parameters : [String: Any]
        parameters = [
            "user_mobile"        : myEmail,
            "password"           : myPass,
            "device_id"          : AppDelegate.deviceId,
            "device_token"       : AppDelegate.deviceToken,
            "debug_mod"          : YourAppIsDebug,
            "region_type"        : "sa",
            "device_type"        : "ios",
            "walkthrough_completed" : KC_Walk
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.logInUser(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                Applicationevents.postInfo(string: "login")
                
                //                var contextData : [String: String]
                //                contextData = [
                //                    "mData.event.loggedinStatus"              : "true"
                //                ]
                //                ACPCore.start {
                //                           ACPCore.lifecycleStart(contextData)
                //                       }
                
                AdobeTag.event(key: "mData.event.loggedinStatus", value: "true")
                //                ADBMobile.collectLifecycleData(withAdditionalData: contextData)
                
                self.matomoTracker.track(view: ["mData.event.loggedinStatus","true"])
                print(successResponse.data?.blinkData?[1].name ?? "Aws")
                self.Shared.userInfo = successResponse.data
                //   UserDefaults.standard.set(myEmail, forKey: KeyChainKeys.userPhone)
                //   UserDefaults.standard.set(myPass, forKey: KeyChainKeys.userPassword)
                UserDefaults.standard.set(true, forKey: KeyChainKeys.isLogedIn)
                UserDefaults.standard.set(successResponse.access_token_info?.access_token, forKey: KeyChainKeys.userAuthToken)
                
                if let userid = successResponse.data?.user_id {
                    UserDefaults.standard.set(userid, forKey: KeyChainKeys.userID)
                    print(self.KC_userID)
                }
                
                print(successResponse.data?.is_active)
                if successResponse.data?.is_active == 1 {
                    self.AppDelegate.moveToHome()
                }else {
                    self.resendOtp()
                }
            }else  {
                
                AdobeTag.event(key: "mData.event.loggedinStatus", value: "false")
                self.matomoTracker.track(view: ["mData.event.loggedinStatus","false"])
                //                var contextData : [String: String]
                //                contextData = [
                //                    "mData.event.mData.event.loggedinStatus"              : "false"
                //                ]
                //                ACPCore.start {
                //                           ACPCore.lifecycleStart(contextData)
                //                       }
                //                ADBMobile.collectLifecycleData(withAdditionalData: contextData)
                
                
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
                
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    // MARK: - Delegates
    
    func selectedCountry(country: CountryModel) {
        tempPhoneBtn.isHidden = true
        countryLbl.text = country.flag! + " +" + country.phoneExtension
        countryCode = ("+\(country.phoneExtension ?? "0")")
    }
}

extension LoginVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_email {
            //            self.tickEmail.image = UIImage(named: "tick")
            self.emailView.setCustomView()
        }else {
            self.passView.setCustomView()
            self.emailView.setNormalTxtView()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txt_email {
            //            self.tickEmail.image = UIImage(named: "tick")
            self.emailView.setNormalTxtView()
        }else {
            self.passView.setNormalTxtView()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt_email{
            let maxLength = 15
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            return true
        }
    }
}



