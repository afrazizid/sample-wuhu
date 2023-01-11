//
//  SignUpVC4.swift
//  Wuhu
//
//  Created by afrazali on 22/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//


import UIKit
import KWVerificationCodeView
import KKPinCodeTextField
import SwiftyJSON

class SignUpVC4: BaseVC {
    
    
    @IBOutlet weak var codeField: KKPinCodeTextField!
    @IBOutlet weak var completeBtn: UIButton!
    
    @IBOutlet weak var resend: UIButton!
    @IBOutlet weak var lblPhone: UILabel!
    
    
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var confirmView: UIView!
    
    @IBOutlet weak var txt_pass: UITextField!
    @IBOutlet weak var txt_confirm: UITextField!
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    var counter = 60
    var PhoneNumber = ""
    // MARK: -  Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
   @objc func updateCounter() {
        //example functionality
        if counter > 0 {
//            print("\(counter) seconds to the end of the world")
            countDownLabel.text = "Resend code in 0 : "+"\(counter)"
            counter -= 1
        }else{
            countDownLabel.isHidden = true
            resend.isHidden = false
            
    }
    }
    
    // MARK: - IBActions
    
    
    @IBAction func actionComplete(_ sender: Any) {
        
        if isCheck() {
            
            //            self.activateUser()
          //  UserDefaults.standard.set(self.txt_pass.text!, forKey: KeyChainKeys.userPassword)
            
            //            self.Shared.activateParam["password"] = self.txt_pass.text
            //            self.Shared.activateParam["user_id"] = KC_userID
            self.Shared.activateParam["code"] = self.codeField.text!
            self.Shared.activateParam["user_id"] = KC_userID
            //            self.Shared.activateParam["is_existing_user"] = "0"
            //            self.Shared.activateParam["device_token"] = AppDelegate.deviceToken
            
            let vc = UIStoryboard.init(name: "Initial", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC3") as? SignUpVC3
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    @IBAction func actionResend(_ sender: Any) {
        resendOtp()
      
    }
    @IBAction func actionBack(_ sender: Any) {
        self.moveBack()
    }
    @IBAction func actionEye(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.tag == 0 {
            if sender.isSelected {
                self.txt_pass.isSecureTextEntry = false
            }else {
                self.txt_pass.isSecureTextEntry = true
            }
        }else {
            if sender.isSelected {
                self.txt_confirm.isSecureTextEntry = false
            }else {
                self.txt_confirm.isSecureTextEntry = true
            }
        }
    }
    
    // MARK: - Custom
    
    func setMobileNumber(suffixValue: Int) {
        
        let number = "*** ***"
        let mobileNo = self.Shared.signUpParam["phone"] as! String
        let lastDigits = mobileNo.suffix(suffixValue)
        
        
        //        for i in 0...mobileNo.count - 4 {
        //            if i == 3{
        //                number += " "
        //            }else{
        //                number += "*"
        //            }
        //        }
        self.lblPhone.text = number + " " + lastDigits
    }
    
    func setUIElements() {
        
        completeBtn.isEnabled = true
        completeBtn.setBtnUI()
        self.passView.setNormalTxtView()
        self.confirmView.setNormalTxtView()
        self.setMobileNumber(suffixValue: 4)
        self.codeField.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldEditingDidChange(){
        
        if codeField.text?.count == 4 {
            if isCheck() {
                self.Shared.activateParam["code"] = self.codeField.text!
                self.Shared.activateParam["user_id"] = KC_userID
                let vc = UIStoryboard.init(name: "Initial", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC3") as? SignUpVC3
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
        }
    }
    func setUpCodeView() {
        
        //        verificationCodeView.delegate = self
        //        verificationCodeView.textFont = "CeraBasic-Bold" //UIFont(name: "CeraBasic-Bold", size: 36)
        //        verificationCodeView.textSize = 36
        //        verificationCodeView.underlineColor = #colorLiteral(red: 0.2745098039, green: 0.1137254902, blue: 0.4862745098, alpha: 1)
        //        verificationCodeView.textColor = #colorLiteral(red: 0.2745098039, green: 0.1137254902, blue: 0.4862745098, alpha: 1)
        //        verificationCodeView.underlineSelectedColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
    }
    
    func isCheck() -> Bool {
        
        let code                = self.codeField.text//self.verificationCodeView.getVerificationCode()
        //        let password            = self.txt_pass.text
        //        let confrimPass         = self.txt_confirm.text
        
        if code == "" {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.pinNumberRequire, type: "error")
            return false
        }
        
        /* if password == "" {
         self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.passwordRequire, type: "error")
         self.passView.setCustomView()
         return false
         }else if password!.count < 8 {
         
         self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.minimumPass, type: "error")
         self.passView.setCustomView()
         return false
         
         //        }else if password!.count > 6 {
         //            var regex:String = ""
         //            let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
         //            if self.txt_pass.text!.rangeOfCharacter(from: characterset.inverted) != nil {
         //                regex = "^(?=.*[a-z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
         //            }else{
         //                regex = "^(?=.*[a-z])(?=.*\\d)[A-Za-z\\d?&]{8,}"
         //            }
         //
         //            let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: self.txt_pass.text!)
         //            if(isMatched  == true) {
         //                return true
         //            }else {
         //                self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.alphanumericpassRequire, type: "error")
         //                self.passView.setCustomView()
         //
         //                return false
         //            }
         }
         
         
         if confrimPass == "" {
         self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.confirmPasswordRequire, type: "error")
         self.confirmView.setCustomView()
         return false
         //        }else if confrimPass!.count < 8 {
         //
         //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.confirmPasswordRequire, type: "error")
         //            self.confirmView.setCustomView()
         //            return false
         //
         //        }else if confrimPass!.count > 6 {
         //            var regex:String = ""
         //            let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
         //            if self.txt_pass.text!.rangeOfCharacter(from: characterset.inverted) != nil {
         //                regex = "^(?=.*[a-z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
         //            }else{
         //                regex = "^(?=.*[a-z])(?=.*\\d)[A-Za-z\\d?&]{8,}"
         //            }
         //
         //            let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: self.txt_pass.text!)
         //            if(isMatched  == true) {
         //                return true
         //            }else {
         //                self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.confirmPasswordRequire, type: "error")
         //                self.confirmView.setCustomView()
         //
         //                return false
         //            }
         }
         
         if password != confrimPass {
         
         self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.passwordMatch, type: "error")
         self.passView.setCustomView()
         self.confirmView.setCustomView()
         return false
         }*/
        
        return true
    }
    
    
    func activateUser(){
        
        var parameters : [String: Any]
        parameters = [
            //            "email"              : KC_userEmail!,
            "password"           : self.txt_pass.text!,
            "device_type"        : "ios",
            "user_id"            : KC_userID,
            "code"               : codeField.text!,//self.verificationCodeView.getVerificationCode(),
            //            "phone"              : KC_userPhone!,
            "is_existing_user"   : "0",
            "device_token"       : AppDelegate.deviceToken,
            "user_id"            : KC_userID
            //            "company_id"         : "2",
            //            "client_id"          : "2",
            //            "default_venue"      : 97376
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.activateUser(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                let vc = UIStoryboard.init(name: "Initial", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC3") as? SignUpVC3
                self.navigationController?.pushViewController(vc!, animated: true)
              //  UserDefaults.standard.set(self.txt_pass.text!, forKey: KeyChainKeys.userPassword)
                               UserDefaults.standard.set(true, forKey: KeyChainKeys.isLogedIn)
                
                UserDefaults.standard.set(successResponse.access_token_info?.access_token, forKey: KeyChainKeys.userAuthToken)
                //                self.AppDelegate.moveToLogIn(isLogIn: true)
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func resendOtp(){
        
        var parameters : [String: Any]
        parameters = [
            "phone"           :PhoneNumber,
            "user_id"            : KC_userID,
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.resendCode(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let resp = JSON(successResponse)
            print(resp)
            if resp["status"] == true {
                self.showSwiftMessage(title: AlertTitle.success, message: resp["message"].stringValue, type: "success")
                self.resend.isHidden = true
                self.countDownLabel.isHidden = false
                self.counter = 60
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: resp["message"].stringValue, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
}


//extension SignUpVC4: KWVerificationCodeViewDelegate {
////    func didChangeVerificationCode() {
////        submitButton.isEnabled = verificationCodeView.hasValidCode()
////    }
//}


extension SignUpVC4 : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_pass {
            self.passView.setCustomView()
        }else {
            self.confirmView.setCustomView()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txt_pass {
            self.passView.setNormalTxtView()
        }else  if textField == txt_confirm{
            self.confirmView.setNormalTxtView()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}
