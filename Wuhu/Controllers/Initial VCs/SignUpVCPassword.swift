//
//  SignUpVCPassword.swift
//  Wuhu
//
//  Created by Awais on 08/09/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class SignUpVCPassword: BaseVC {
    
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var cpassView: UIView!
    @IBOutlet weak var lblHeyName: UILabel!
    @IBOutlet weak var txt_pass: UITextField!
    @IBOutlet weak var txt_cpass: UITextField!
    
    @IBOutlet weak var passEye: UIButton!
    @IBOutlet weak var cpassEye: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblHeyName.text = "\(self.Shared.signUpParam["first_name"]!),"
        self.passView.setNormalTxtView()
        self.cpassView.setNormalTxtView()
        // Do any additional setup after loading the view.
    }
        func isCheck() -> Bool {
            
//            let code                = self.codeField.text//self.verificationCodeView.getVerificationCode()
            let password            = self.txt_pass.text
            let confrimPass         = self.txt_cpass.text
            
//            if code == "" {
//                self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.pinNumberRequire, type: "error")
//                return false
//            }
            
            if password == "" {
                self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.passwordRequire, type: "error")
                self.passView.setCustomYellowView()
                return false
            }
            let decimalRange = password!.rangeOfCharacter(from: CharacterSet.decimalDigits)
            let letterRange = password!.rangeOfCharacter(from: CharacterSet.letters)
            if password!.count < 8 || decimalRange == nil || letterRange == nil || !password!.containsSpecialCharacter{
                
                self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.alphanumericpassRequire, type: "error")
                self.passView.setCustomYellowView()
                return false
                
            }
            
            
            if confrimPass == "" {
                self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.confirmPasswordRequire, type: "error")
                self.cpassView.setCustomYellowView()
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
//                self.passView.setCustomYellowView()
                self.cpassView.setCustomYellowView()
                return false
            }
            
            return true
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
                self.txt_cpass.isSecureTextEntry = false
            }else {
                self.txt_cpass.isSecureTextEntry = true
            }
        }
    }
    
    @IBAction func actionNext(_ sender: UIButton) {
        if isCheck() {
            
            //            self.activateUser()
          //  UserDefaults.standard.set(self.txt_pass.text!, forKey: KeyChainKeys.userPassword)
            
            self.Shared.activateParam["password"] = self.txt_pass.text
            self.Shared.activateParam["user_id"] = KC_userID
//            self.Shared.activateParam["code"] = self.codeField.text!
            self.Shared.activateParam["is_existing_user"] = "0"
            self.Shared.activateParam["device_token"] = AppDelegate.deviceToken
            
            self.pushController(name: "SignUpVC4")
        }
        
        
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.moveBack()
    }
}
extension SignUpVCPassword : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_pass {
            self.passView.setCustomYellowView()
            self.cpassView.setNormalTxtView()
        }else {
            self.cpassView.setCustomYellowView()
            self.passView.setNormalTxtView()
        }
    }
}
