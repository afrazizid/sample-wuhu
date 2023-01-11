//
//  ActiveUser.swift
//  Wuhu
//
//  Created by Awais on 19/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import KWVerificationCodeView
import KKPinCodeTextField

class ActiveUser: BaseVC {
    
    @IBOutlet weak var codeField: KKPinCodeTextField!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblPhoneDLG: UILabel!
    @IBOutlet weak var dialouge: UIView!
    @IBOutlet weak var resend: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    var phone:String!
    var counter = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMobileNumber(suffixValue: 4)
        self.codeField.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
      Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        let newString = phone.replacingOccurrences(of: "+", with: "00")
      //  UserDefaults.standard.set(newString, forKey: KeyChainKeys.userPhone)
        // Do any additional setup after loading the view.
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
        @objc func textFieldEditingDidChange(){

            if codeField.text?.count == 4 {
                 activateUser()
            }
        }
    
    func setMobileNumber(suffixValue: Int) {
        
        let number = "*** ***"
        let mobileNo = phone
        let lastDigits = mobileNo!.suffix(suffixValue)
        
        
//        for i in 0...mobileNo!.count - 4 {
//            if i == 3{
//                number += " "
//            }else{
//                number += "*"
//            }
//        }
        self.lblPhone.text = number + " " + lastDigits
        self.lblPhoneDLG.text = number + " " + lastDigits
    }
    func activateUser(){
        
        var parameters : [String: Any]
        parameters = [
            "code"              : self.codeField.text!,
            "is_existing_user"    : "1",
            "user_id"        : KC_userID
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.activateUser(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                
                UserDefaults.standard.set(true, forKey: KeyChainKeys.isLogedIn)
                
                UserDefaults.standard.set(successResponse.access_token_info?.access_token, forKey: KeyChainKeys.userAuthToken)
                
                self.dialouge.isHidden = false

                
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    @IBAction func actionComplete(_ sender: Any) {
        activateUser()
        
        
    }
    @IBAction func actionCancel(_ sender: Any) {
//        activateUser()
        dialouge.isHidden = true
        
    }
    @IBAction func actionResend(_ sender: Any) {
        resend.isHidden = true
        countDownLabel.isHidden = false
        counter = 60
         Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    @IBAction func actionContinue(_ sender: Any) {
//        self.clearDefaults()
        let newString = phone.replacingOccurrences(of: "+", with: "00")
      //  UserDefaults.standard.set(newString, forKey: KeyChainKeys.userPhone)
        self.AppDelegate.moveToLogIn(isLogIn: true)
        
    }
    
}
extension ActiveUser:UITextFieldDelegate{
    
    
}
