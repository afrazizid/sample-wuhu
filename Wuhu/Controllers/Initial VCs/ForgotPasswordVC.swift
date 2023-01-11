//
//  ForgotPasswordVC.swift
//  Wuhu
//
//  Created by afrazali on 23/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseVC,CountryListDelegate {
    
    
    
    // MARK: -  IBOutlets
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_cell: UITextField!
    @IBOutlet weak var tickEmail: UIImageView!
    @IBOutlet weak var tickCell: UIImageView!
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headingText: UILabel!
    @IBOutlet weak var lblSms: UILabel!
    @IBOutlet weak var imgSms: UIImageView!
    
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var changeTextRecovery: UIButton!
    @IBOutlet weak var btnPopContinue: UIButton!
    @IBOutlet weak var countryBtn: UIButton!
    var countryList = CountryList()
    var isCell = false
    var phoneCode = ""
    var codetoSend = ""
    var countriesList = [CountryModel]()
    // MARK: -  Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        txt_email.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
        txt_cell.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
        countryList.delegate = self
        getCountries()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hideNavigationBar()
        
    }
          func getCountries(){
                self.showLoader()
                UserHandler.getCountries(endPoint: "get-countries", success: { (successResponse) in
                    self.stopAnimating()
                    if successResponse.status == true {
                        self.countriesList = successResponse.data
                        for i in self.countriesList{
                            if i.isDefault{
                                self.countryCode.text = (i.flag!) + " +" + i.phoneExtension
                                
                                self.phoneCode =  "+"+"\(i.phoneExtension ?? "")"
                                self.codetoSend =  "00"+"\(i.phoneExtension ?? "")"
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
    
    @IBAction func actionNext(_ sender: Any) {
        if !isCell {
            if isCheckCell() {
                lblSms.text = "Check your SMS."
                imgSms.image = #imageLiteral(resourceName: "phone")
                forgotPaswordCell()
            }
        }else{
            
            if isCheck() {
                lblSms.text = "Check your mail."
                imgSms.image = #imageLiteral(resourceName: "email")
                forgotPasword()
            }
        }
    }
    @IBAction func changeRecovery(_ sender: Any) {
        txt_cell.text = ""
        txt_email.text = ""
        self.tickEmail.image = UIImage(named: "cross")
        self.tickCell.image = UIImage(named: "cross")
        if isCell {
            headingText.text = "CELLPHONE NUMBER"
            changeTextRecovery.setTitle("Reset password using email", for: .normal)
            emailView.isHidden = true
            cellView.isHidden = false

            isCell = false
        }else{
            headingText.text = "EMAIL ADDRESS"
            changeTextRecovery.setTitle("Reset password using number", for: .normal)
            emailView.isHidden = false
            cellView.isHidden = true
            isCell = true
        }
    }
    @IBAction func pickCountry(_ sender: Any) {
        CountryList.endpoint = "get-countries"
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
        
    }
    @IBAction func actionBtnBack(_ sender: Any) {
        
        self.popVC()
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        self.removePopUpView(myView: self.popUpView, myBg: self.bgView)
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        if isCell {
        vc.userEmailToSend = self.txt_email.text!

        }else{
        vc.userEmailToSend = self.getPhoneNumber(countryCode: codetoSend, actualPhoneNumber: setMobile(number: self.txt_cell.text!))
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Custom Function
    @objc func textFieldEditingDidChange(){
        //       checkFields()
        if (txt_email.text!.isValidEmail || txt_cell.text!.count >= 6) {
            self.tickEmail.image = UIImage(named: "tick")
            self.tickCell.image = UIImage(named: "tick")
        }else {
            self.tickEmail.image = UIImage(named: "cross")
            self.tickCell.image = UIImage(named: "cross")
            
        }
    }
    func setUIElements() {
        
        self.emailView.setNormalTxtView()
        self.btnPopContinue.setBtnUI()
        self.tickEmail.isHidden = true
        headingText.text = "CELLPHONE NUMBER"
        self.popUpView.drawBorder(width: 0, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
    }
    
    func isCheck() -> Bool {
        
        let email               = self.txt_email.text
        
        if email == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.emailValid, type: "error")
            self.tickEmail.image = UIImage(named: "cross")
            self.emailView.setCustomView()
            return false
        }else if (!email!.isValidEmail) {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.emailValid, type: "error")
            self.tickEmail.isHidden = false
            self.tickEmail.image = UIImage(named: "cross")
            self.emailView.setCustomView()
            return false
        }
        
        self.tickEmail.isHidden = false
        self.tickEmail.image = UIImage(named: "tick")
        return true
    }
    func isCheckCell() -> Bool {
        let cell  = txt_cell.text
        if cell == ""{
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.emptyPhone, type: "error")
            
            return false
        }else if cell!.count < 6{
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.invalidPhone, type: "error")
            return false
        }
        
        return true
    }
    func forgotPasword(){
        
        var parameters : [String: Any]
        parameters = [
            "email"              : txt_email.text!,
            "amplify_AP1_key"    : General.amplifyAPIKey,
            "region_type"        : "uk"
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.forgotPasswordCall(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.addPopUpView(myView: self.popUpView, myBg: self.bgView)
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func forgotPaswordCell(){
        
        var parameters : [String: Any]
        parameters = [
            "user_mobile"              : self.getPhoneNumber(countryCode: codetoSend, actualPhoneNumber: setMobile(number: self.txt_cell.text!)),
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.forgotPasswordCall(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.addPopUpView(myView: self.popUpView, myBg: self.bgView)
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    // MARK: - Delegates
    func selectedCountry(country: CountryModel) {
        countryBtn.isHidden = true
        countryCode.text = country.flag! + " +" + country.phoneExtension
        phoneCode = ("+\(country.phoneExtension ?? "0")")
        codetoSend = ("00\(country.phoneExtension ?? "0")")
    }
}

extension ForgotPasswordVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.tickEmail.isHidden = false
        //        self.emailView.setCustomView()
        if (!txt_email.text!.isValidEmail) {
//            self.tickEmail.image = UIImage(named: "cross")
        }else {
//            self.tickEmail.image = UIImage(named: "tick")
            
        }
        self.emailView.setCustomView()
        self.cellView.setCustomView()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.emailView.setNormalTxtView()
        
        if (!txt_email.text!.isValidEmail) {
//            self.tickEmail.image = UIImage(named: "cross")
        }else {
//            self.tickEmail.image = UIImage(named: "tick")
            
        }
        self.emailView.setNormalTxtView()
        self.cellView.setNormalTxtView()
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt_cell{
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
