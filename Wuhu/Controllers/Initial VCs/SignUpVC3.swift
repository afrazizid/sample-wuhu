//
//  SignUpVC3.swift
//  Wuhu
//
//  Created by afrazali on 22/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit


class SignUpVC3: BaseVC {
    
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var btnPrivacy: UIButton!
    @IBOutlet weak var btnCookie: UIButton!
    @IBOutlet weak var btnComplete: UIButton!
    
    @IBOutlet weak var chk1: CustomCheckBox!
    @IBOutlet weak var chk2: CustomCheckBox!
    @IBOutlet weak var chk3: CustomCheckBox!
    @IBOutlet weak var chk4: CustomCheckBox!
    
    
    var isBool1 = false
    var isBool2 = false
    var isBool3 = false
    var isBool4 = false
    
    
    // MARK: -  Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        self.btnComplete.setBtnUI()
        btnComplete.backgroundColor = #colorLiteral(red: 0.6872321367, green: 0.6242147684, blue: 0.7730837464, alpha: 1)
        btnComplete.borderWidth = 0
    }
    
    
    // MARK: - IBActions
    
    @IBAction func actionTerms(_ sender: Any) {
//        self.showSwiftMessage(title: AlertTitle.info, message: "Functionality not defined yet.", type: "info")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
        vc.html = "terms_of_use"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func actionPrivacy(_ sender: Any) {
//        self.showSwiftMessage(title: AlertTitle.info, message: "Functionality not defined yet.", type: "info")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
        vc.html = "privacy_policy"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func actionCookie(_ sender: Any) {
//        self.showSwiftMessage(title: AlertTitle.info, message: "Functionality not defined yet.", type: "info")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
        vc.html = "cookie"
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    @IBAction func actionBtnBack(_ sender: Any) {
        self.popVC()
    }
    
    @IBAction func actionNext(_ sender: Any) {
        
        if isCheck() {
            
            // SignUp call
            self.activateUser()

        }
    }
    
    
    @IBAction func actionChck(_ sender: AnyObject) {
        
        if sender.tag == 1 {
           
            if self.chk1.isChecked {
                self.isBool1 = false
                
            }else {
                self.isBool1 = true
            }
        }else if sender.tag == 2 {
           
            if self.chk2.isChecked {
                self.isBool2 = false
            }else {
                self.isBool2 = true
            }
        }else if sender.tag == 3 {
           
            if self.chk3.isChecked {
                self.isBool3 = false
            }else {
                self.isBool3 = true
            }
        }else if sender.tag == 4 {
           
            if self.chk4.isChecked {
                self.isBool4 = false
            }else {
                self.isBool4 = true
            }
        }
        if isBool1 && isBool2{
            btnComplete.backgroundColor = #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1)
        }else{
            btnComplete.backgroundColor = #colorLiteral(red: 0.6872321367, green: 0.6242147684, blue: 0.7730837464, alpha: 1)
        }
          self.Shared.activateParam["system"] = isBool3
          self.Shared.activateParam["marketing"] = isBool4
        
    }
    
    @IBAction func actionChk2(_ sender: Any) {
        
    }
    
    @IBAction func actionChk3(_ sender: Any) {
        
    }
    
    
    @IBAction func actionChk4(_ sender: Any) {
    }
    @IBAction func actionBack(_ sender: Any) {
        self.moveBack()
    }
    // MARK: - Custom
    
    
    func setUIElements() {
        
        self.btnTerms.underline()
        self.btnCookie.underline()
        self.btnPrivacy.underline()
        
        if self.chk1.isChecked {
            self.chk1.isChecked = true
            self.isBool1 = true
        }else {
            self.chk1.isChecked = false
            self.isBool1 = false
        }
        
        
        if self.chk2.isChecked {
            self.chk2.isChecked = true
            self.isBool2 = true
        }else {
            self.chk2.isChecked = false
            self.isBool2 = false
        }
        
        if self.chk3.isChecked {
            self.chk3.isChecked = true
            self.isBool3 = true
        }else {
            self.chk3.isChecked = false
            self.isBool3 = false
        }
        
        if self.chk4.isChecked {
            self.chk4.isChecked = true
            self.isBool4 = true
        }else {
            self.chk4.isChecked = false
            self.isBool4 = false
        }

    }
    
    func isCheck() -> Bool {
        
        if isBool1 == false  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.termsConfirm, type: "error")
            return false
        }
        
        if isBool2 == false  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.ageConfirm, type: "error")
            return false
        }
        return true
    }
    
    
    //MARK: - API Calls
    
     func activateUser(){
            
//            var parameters : [String: Any]
            let parameters = self.Shared.activateParam
            print(parameters)
                
            print(parameters)
            self.showLoader()
            UserHandler.activateUser(params: parameters as NSDictionary, success: { (successResponse) in
                self.stopAnimating()
                if successResponse.status == true {
                    UserDefaults.standard.set(true, forKey: KeyChainKeys.isLogedIn)
                    print("successResponse.access_token_info?.access_token")
                    print(successResponse.access_token_info?.access_token)
                    UserDefaults.standard.set(successResponse.access_token_info?.access_token, forKey: KeyChainKeys.userAuthToken)
                    self.AppDelegate.moveToLogIn(isLogIn: true)

                }else  {
                    self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
                }
            }) { (error) in
                self.stopAnimating()
                self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
            }
        }
}

