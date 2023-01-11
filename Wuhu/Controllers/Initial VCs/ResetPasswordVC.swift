//
//  ResetPasswordVC.swift
//  Wuhu
//
//  Created by afrazali on 24/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ResetPasswordVC: BaseVC {
    
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var confirmView: UIView!

    @IBOutlet weak var txt_code: UITextField!
    @IBOutlet weak var txt_pass: UITextField!
    @IBOutlet weak var txt_confirm: UITextField!

    @IBOutlet weak var btnReset: UIButton!
    
    var userEmailToSend = "abc@gmail.com"
    // MARK: -  Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        
    }
    

    // MARK: - IBActions
    

    @IBAction func actionBtnBack(_ sender: Any) {
        self.popVC()
    }
    @IBAction func actionResetPassword(_ sender: Any) {
        
        if isCheck() {
//            self.pushController(name: "loginVC")
            if self.userEmailToSend.isValidEmail {
            self.resetPassword()
            }else{
            self.resetPasswordCell()
            }
        }
    }
    
    // MARK: -  IBActions
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

    
    func setUIElements() {
        
        
        self.codeView.setNormalTxtView()
        self.passView.setNormalTxtView()
        self.confirmView.setNormalTxtView()
        
        self.btnReset.setBtnUI()

    }
    
    func isCheck() -> Bool {
        
        let code            = self.txt_code.text
        let password        = self.txt_pass.text
        let confrimPass     = self.txt_confirm.text

        if code == "" {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.pinRequired, type: "error")
            self.codeView.setCustomView()
            return false
        }else if code!.count < 4 || code!.count > 4 {
            
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.pinRequired, type: "error")
            self.codeView.setCustomView()
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
//        }else if confrimPass!.count > 8 {
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
////                return true
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
        }
        
        return true
    }
    
    func resetPassword(){
        
        var parameters : [String: Any]
        parameters = [
            "email"             : self.userEmailToSend,
            "amplify_AP1_key"   : General.amplifyAPIKey,
            "pin"               : self.txt_code.text!,
            "password"          : self.txt_pass.text!,
            "confirm_password"  : self.txt_confirm.text!
        ]
            
        print(parameters)
        self.showLoader()
        UserHandler.forgotPasswordCall(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.showSwiftMessage(title: AlertTitle.success, message: successResponse.message!, type: "success")
                self.AppDelegate.moveToLogIn(isLogIn: false)
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }

    func resetPasswordCell(){
        
        var parameters : [String: Any]
        parameters = [
            "pin"               : self.txt_code.text!,
            "password"          : self.txt_pass.text!,
            "user_mobile"       : self.userEmailToSend
        ]
            
        print(parameters)
        self.showLoader()
        
        UserHandler.resetPasswordCall(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.showSwiftMessage(title: AlertTitle.success, message: successResponse.message!, type: "success")
                self.AppDelegate.moveToLogIn(isLogIn: false)
            }else if successResponse.password != nil {
                self.showSwiftMessage(title: AlertTitle.warning, message: "The password format is invalid.", type: "error")
            }else{
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message ?? "", type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
}






extension ResetPasswordVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_code {
            self.codeView.setCustomView()
        }else if textField == txt_pass {
            self.passView.setCustomView()
        }else {
            self.confirmView.setCustomView()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txt_code {
            self.codeView.setNormalTxtView()
        }else if textField == txt_pass {
            self.passView.setNormalTxtView()
        }else {
            self.confirmView.setNormalTxtView()
        }
    }
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt_code{
          let maxLength = 4
          let currentString: NSString = textField.text! as NSString
          let newString: NSString =
              currentString.replacingCharacters(in: range, with: string) as NSString
          return newString.length <= maxLength
        }else{
            return true
        }
      }
}
