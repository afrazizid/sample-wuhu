//
//  SignUpVC1.swift
//  Wuhu
//
//  Created by afrazali on 22/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class SignUpVC1: BaseVC {
    

    @IBOutlet weak var fView: UIView!
    @IBOutlet weak var txt_fname: UITextField!
    @IBOutlet weak var txt_lname: UITextField!
    @IBOutlet weak var lView: UIView!
    
    // MARK: -  Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        
    }

    // MARK: - IBActions
    

    @IBAction func actionBtnBack(_ sender: Any) {
        self.popVC()
    }
    
    @IBAction func actionNext(_ sender: Any) {
        if isCheck() {
            let vc = UIStoryboard.init(name: "Initial", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC2") as? SignUpVC2
            self.Shared.signUpParam["first_name"] = self.txt_fname.text
            self.Shared.signUpParam["last_name"] = self.txt_lname.text
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    // MARK: - Custom

    
    func setUIElements() {
        
        self.fView.setNormalTxtView()
        self.lView.setNormalTxtView()

    }
    
    func isCheck() -> Bool {
        
        let fname            = self.txt_fname.text
        let lname            = self.txt_lname.text
        
    
        if fname == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.fNameRequire, type: "error")
            return false
        }
        if fname!.count > 40{
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.fNameRange, type: "error")
            return false
        }
        if lname == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.lNameRequire, type: "error")
            return false
        }
        if lname!.count > 40{
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.lNameRange, type: "error")
            return false
        }
        
        return true
    }
}




extension SignUpVC1 : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_fname {
            self.fView.setCustomYellowView()
            self.lView.setNormalTxtView()
        }else {
            self.lView.setCustomYellowView()
            self.fView.setNormalTxtView()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txt_fname {
            self.fView.setCustomYellowView()
            self.lView.setNormalTxtView()
        }else {
            self.lView.setCustomYellowView()
            self.fView.setNormalTxtView()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txt_fname { // Switch focus to other text field
            txt_lname.becomeFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}
