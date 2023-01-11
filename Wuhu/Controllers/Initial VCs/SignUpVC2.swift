//
//  SignUpVC2.swift
//  Wuhu
//
//  Created by afrazali on 22/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import DropDown

class SignUpVC2: BaseVC,CountryListDelegate {

    
        
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var tickEmail: UIImageView!
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var btnCountryCodeDropDown: UIButton!
    @IBOutlet weak var flageImg: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!
    
    @IBOutlet weak var lblHeyName: UILabel!

    let countryCodeDropDown = DropDown()
    var countryList = CountryList()
    var countryCode = ""
    var codeToSend = ""
    var countriesList = [CountryModel]()
    // MARK: -  Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        countryList.delegate = self
       getCountries()
        
    }
    func getCountries(){
        self.showLoader()
        UserHandler.getCountries(endPoint: "get-countries", success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.countriesList = successResponse.data
                for i in self.countriesList{
                    if i.isDefault{
                        self.lblCountryCode.text = (i.flag!) + " +" + i.phoneExtension
                        
                        self.countryCode =  "+"+"\(i.phoneExtension ?? "")"
                        self.codeToSend = "00"+"\(i.phoneExtension ?? "")"
//                        self.getCountryWithCode(code: "+"+"\(i.phoneExtension ?? "")")
                        break
//                    }else{
//                        self.getCountryWithCode(code: "+27")
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
    
    func pickCountry() {
        CountryList.endpoint = "get-countries"

        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }

    // MARK: - IBActions
    
    
    @IBAction func actionCountryCodeDropDown(_ sender: Any) {
//        self.countryCodeDropDown.show()

        pickCountry()
    }
    
    @IBAction func actionBtnBack(_ sender: Any) {
        self.popVC()
    }
    @IBAction func actionNext(_ sender: Any) {
        
        if isCheck() {
            
//            let vc = UIStoryboard.init(name: "Initial", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC4") as? SignUpVC4
            self.Shared.signUpParam["email"] = self.txt_email.text
            self.Shared.signUpParam["phone"] = self.getPhoneNumber(countryCode: countryCode, actualPhoneNumber: setMobile(number: self.txt_phone.text!))
            self.Shared.signUpParam["country_code"] = codeToSend
            self.Shared.signUpParam["device_id"] = AppDelegate.deviceId
            self.Shared.signUpParam["device_token"] = AppDelegate.deviceToken
            self.regiterAPICall()
//            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    // MARK: - Custom

    func getCountryWithCode(code : String?) {
        
        let countries = Countries()
        let countryList = countries.countries
        
        var singleCountry = [CountryModel2]()
        
        for country in countryList {
            if("+\(country.phoneExtension)" == code){
                singleCountry.append(country)
            }
        }
        
        if(singleCountry.count > 0){
            let single = singleCountry.first
            lblCountryCode.text = (single?.flag!)! + " +" + single!.phoneExtension
            
            countryCode = ("+\(single!.phoneExtension)")
            self.codeToSend = "00"+"\(single!.phoneExtension)"
        }
        
    }
    func setUIElements() {
        
        self.setUpCountryCodeDropDown()
        self.emailView.setNormalTxtView()
        self.phoneView.setNormalTxtView()
         self.tickEmail.image = UIImage(named: "cross")
        self.txt_email.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
        self.tickEmail.isHidden = true
        self.lblHeyName.text = "Hey \(self.Shared.signUpParam["first_name"]!),"
//        self.lblHeyName.text = "Hey" + " " + laself.Shared.signUpParam["first_name"]stDigits

    }
        @objc func textFieldEditingDidChange(){
            //       checkFields()
    //        let str = txt_email.text?.count
            if (txt_email.text!.isValidEmail) {
                self.tickEmail.image = UIImage(named: "tick")
            }else {
                self.tickEmail.image = UIImage(named: "cross")
                
            }
        }
    func isCheck() -> Bool {
        
        let phone            = self.txt_phone.text

        let email            = self.txt_email.text
        
        if phone == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.phoneValid, type: "error")
            return false
        }else if (phone!.count < 6) {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.invalidPhone, type: "error")
            return false
        }
        
        
        if email == ""  {
//            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.emailValid, type: "error")
//            self.tickEmail.isHidden = false
//            self.tickEmail.image = UIImage(named: "cross")
//            return false
        }else if (!email!.isValidEmail) {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.emailValid, type: "error")
            self.tickEmail.isHidden = false
            self.tickEmail.image = UIImage(named: "cross")
            return false
        }
        
       
        
        return true
    }

    func setUpCountryCodeDropDown() {
            
            self.countryCodeDropDown.dataSource = General.countryCodeArray
            self.countryCodeDropDown.anchorView = btnCountryCodeDropDown
            self.countryCodeDropDown.bottomOffset = CGPoint(x: 0, y: btnCountryCodeDropDown.bounds.height)
            self.countryCodeDropDown.direction = .any
            
            /*** IMPORTANT PART FOR CUSTOM CELLS ***/
            self.countryCodeDropDown.cellNib = UINib(nibName: "FlagCell", bundle: nil)
            
            self.countryCodeDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                guard let cell = cell as? FlagCell else { return }
                cell.logoImageView.image = UIImage(named: General.flagImageArray[index])
                cell.optionLabel.text = General.countryCodeArray[index]
            }
            
            // Action triggered on selection
            self.countryCodeDropDown.selectionAction = { [unowned self] (index, item) in
                let index = self.countryCodeDropDown.indexForSelectedRow
                print(index!)
//                self.flageImg.image = UIImage(named: General.flagImageArray[index!])
                self.lblCountryCode.text = item
    //            self.setupTextFieldMasking()
            }
            
            self.countryCodeDropDown.cancelAction = { [unowned self] in
               
            }
        }
     // MARK: - Delegates
    func selectedCountry(country: CountryModel) {
        
//        self.flageImg.image = UIImage(named: country.flag!)
        self.codeToSend = "00"+"\(country.phoneExtension ?? "")"
        countryCode = "+"+"\(country.phoneExtension ?? "")"
        self.lblCountryCode.text = country.flag! + " +" + country.phoneExtension
    }
    //MARK: - API Calls
    
    func regiterAPICall(){
        
        self.showLoader()

        let param = self.Shared.signUpParam
        print(param)
        UserHandler.registerUser(params: param as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {

                UserDefaults.standard.set(successResponse.user_id, forKey: KeyChainKeys.userID)
                UserDefaults.standard.set(self.Shared.signUpParam["email"], forKey: KeyChainKeys.userEmail)
              //  UserDefaults.standard.set(self.Shared.signUpParam["phone"], forKey:  KeyChainKeys.userPhone)

                self.pushController(name: "SignUpVCPassword")
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }

}

extension SignUpVC2 : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_email {
            self.tickEmail.isHidden = false
//            self.tickEmail.image = UIImage(named: "tick")
            self.emailView.setCustomYellowView()
            self.phoneView.setNormalTxtView()
        }else {
            self.phoneView.setCustomYellowView()
            self.emailView.setNormalTxtView()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txt_email {
            self.tickEmail.isHidden = false
//            self.tickEmail.image = UIImage(named: "tick")
            self.emailView.setCustomYellowView()
            self.phoneView.setNormalTxtView()
        }else {
            self.phoneView.setCustomYellowView()
            self.emailView.setNormalTxtView()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txt_phone { // Switch focus to other text field
            txt_email.becomeFirstResponder()
        }
        return true
    }
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if textField == txt_phone{
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
