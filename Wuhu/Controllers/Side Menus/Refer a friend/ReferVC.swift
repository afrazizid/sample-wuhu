//
//  ReferVC.swift
//  Wuhu
//
//  Created by afrazali on 03/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import DropDown
import ContactsUI
import LinearProgressView

class ReferVC: BaseVC {
    
    @IBOutlet var linearProgressView: LinearProgressView!

    @IBOutlet weak var txt_fname: UITextField!
    @IBOutlet weak var txt_lname: UITextField!
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var ctxt_phone: UITextField!
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneView2: UIView!

    @IBOutlet weak var lblCodeDD: UILabel!
    @IBOutlet weak var lblCodeDD2: UILabel!
    @IBOutlet weak var btnCodeDD: UIButton!
    @IBOutlet weak var flageImg: UIImageView!

    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblRand: UILabel!
    
    @IBOutlet weak var btnReferFriend: UIButton!
        
    
    var myData : ReferFriendData? = nil

    let codeDD      = DropDown()
    
    var countryList = CountryList()
    var countryCode = ""
    
    fileprivate var alertStyle: UIAlertController.Style = .actionSheet
    
    
    private let contactPicker = CNContactPickerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        countryList.delegate = self
        self.getCountryWithCode(code: "+27")
        //loadReferFrndData()
    }
    
    
    // MARK: - Custom
    
    
    func setUIElements() {
        
        self.setCodeDD()
        
        self.txt_fname.setBorderWidth(width: 1)
        self.txt_lname.setBorderWidth(width: 1)
        self.txt_email.setBorderWidth(width: 1)
        self.phoneView.setBorderWidth(width: 1)
        self.phoneView2.setBorderWidth(width: 1)

        self.txt_fname.setLeftPaddingPoints()
        self.txt_lname.setLeftPaddingPoints()
        self.txt_email.setLeftPaddingPoints()

        self.btnReferFriend.setBtnUI()
        

        
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
            lblCodeDD.text = (single?.flag!)! + " +" + single!.phoneExtension
            lblCodeDD2.text = (single?.flag!)! + " +" + single!.phoneExtension
            
            countryCode = ("+\(single!.phoneExtension)")
        }
        
    }
    func isCheck() -> Bool {
        
        let fname            = self.txt_fname.text
        let lname            = self.txt_lname.text
        let phone            = self.getPhoneNumber(countryCode: self.lblCodeDD.text!, actualPhoneNumber: self.txt_phone.text!)
        let cphone           = self.getPhoneNumber(countryCode: self.lblCodeDD2.text!, actualPhoneNumber: self.ctxt_phone.text!)
        let email            = self.txt_email.text
        
        if fname == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.frndFNameRequire, type: "error")
            return false
        }
        
        if lname == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.frndLNameRequire, type: "error")
            return false
        }
        
//        if email == ""   {
//            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.frndEmail, type: "error")
//            return false
//        }else
        if (!email!.isValidEmail && email!.count > 0) {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.frndValidEmail, type: "error")
            return false
        }
        
        if phone == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.frndCell, type: "error")
            return false
        }else if (phone.count < 10) {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.frndInvalidCell, type: "error")
            return false
        }
        
        if phone != cphone  {
            self.showSwiftMessage(title: AlertTitle.warning, message: "Typo! The cellphone numbers provided don't match. Please try again.", type: "error")
            return false
        }
        return true
    }
    
    func setCodeDD() {
        
        self.codeDD.dataSource = General.countryCodeArray
        self.codeDD.anchorView = btnCodeDD
        self.codeDD.bottomOffset = CGPoint(x: 0, y: btnCodeDD.bounds.height)
        self.codeDD.direction = .any
        
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        self.codeDD.cellNib = UINib(nibName: "FlagCell", bundle: nil)
        
        self.codeDD.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? FlagCell else { return }
            cell.logoImageView.image = UIImage(named: General.flagImageArray[index])
            cell.optionLabel.text = General.countryCodeArray[index]
        }
        
        // Action triggered on selection
        self.codeDD.selectionAction = { [unowned self] (index, item) in
            let index = self.codeDD.indexForSelectedRow
            print(index!)
            self.flageImg.image = UIImage(named: General.flagImageArray[index!])
            self.lblCodeDD.text = item
            self.lblCodeDD2.text = item
        }
        
        codeDD.cancelAction = { [unowned self] in
        }
    }
    
    // API Call
    
    
    func referFrnd() {
        var parameters : [String: Any]
        parameters = [
            "first_name"         : self.txt_fname.text!,
            "last_name"          : self.txt_lname.text!,
            "email"              : self.txt_email.text!,
            "phone"              : self.getPhoneNumber(countryCode: countryCode, actualPhoneNumber: setMobile(number: self.txt_phone.text!)),
            "code"               : self.Shared.userInfo?.referral_code ?? 0
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.referAfriendCall(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                Applicationevents.postInfo(string: "Send_referral")
                self.showSwiftMessage(title: AlertTitle.success, message: successResponse.message!, type: "success")
//                self.txt_fname.text = ""
//                self.txt_lname.text = ""
//                self.txt_email.text = ""
//                self.txt_phone.text = ""
                self.clearFields()

            }else  {
                
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    // API Call
    
    func loadReferFrndData(){
        
        self.showLoader()
    
        UserHandler.referFrndData(success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                
                if successResponse.data != nil {
                    self.myData = successResponse.data!
                    self.lblPoints.text = "\(self.myData!.points ?? 0)pts"
                    self.lblRand.text = "R\(self.myData!.rand ?? 0)"
                    
//                    self.updateLinearProgressView(value: Float, progressView: self.linearProgressView)
                }
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    // MARK: -  IBActions
    
    @IBAction func actionSearchContact(_ sender: UIButton) {
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
        self.present(contactPicker, animated: true, completion: nil)
    }
    @IBAction func actionReferFriend(_ sender: UIButton) {
        
        if isCheck() {
            self.referFrnd()
        }
    }

    @IBAction func actionCodeDD(_ sender: UIButton) {
        
//        self.codeDD.show()
        CountryList.endpoint = "get-countries"
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
}


extension ReferVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_fname {
            self.txt_fname.becomeFirstResponder()
        }else if textField == txt_lname {
            self.txt_lname.becomeFirstResponder()
        }else if textField == txt_email {
            self.txt_email.becomeFirstResponder()
        }else if textField == txt_phone {
            self.txt_phone.becomeFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txt_email {
            
        }else {
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}

extension ReferVC: CNContactPickerDelegate {

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        self.clearFields()

        if contact.isKeyAvailable(CNContactPhoneNumbersKey)
        {
            let con = contact.mutableCopy() as! CNMutableContact

            // First Name
            guard let firstName = con.value(forKey: "givenName") as? String else {return}
            self.txt_fname.text = firstName
            
            // Last Name
            guard let lastName = con.value(forKey: "familyName") as? String else {return}
            self.txt_lname.text = lastName

            // Mobile Number
            if con.phoneNumbers.count > 0 {
                let mailPair = (con.phoneNumbers[0].value(forKey: "labelValuePair") as AnyObject)
                guard let value = mailPair.value(forKey: "value") as? AnyObject else {return}
                guard var mobileNo = value.value(forKey: "stringValue") as? String else {return}
//
                

                self.txt_phone.text = setMobile(number: mobileNo)
                
                self.ctxt_phone.text = setMobile(number: mobileNo)
            }

            //Mail
            if con.emailAddresses.count > 0 {
                let mailPair = (con.emailAddresses[0].value(forKey: "labelValuePair") as AnyObject)
                guard let email = mailPair.value(forKey: "value") as? String else {return}
                self.txt_email.text = email
            }
        }
        else
        {
            print("No phone numbers are available")
            
            self.showSwiftMessage(title: AlertTitle.warning, message: "Selected contact does not have a valide phone number", type: "error")
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

    }
    
    func clearFields() {
        
        self.txt_fname.text = ""
        self.txt_lname.text = ""
        self.txt_email.text = ""
        self.txt_phone.text = ""
        self.ctxt_phone.text = ""

    }

    /*
    func setNumberFromContact(contactNumber: String) {

        //UPDATE YOUR NUMBER SELECTION LOGIC AND PERFORM ACTION WITH THE SELECTED NUMBER

        var contactNumber = contactNumber.replacingOccurrences(of: "-", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: "(", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: ")", with: "")
        contactNumber = contactNumber.trim()
//        contactNumber = contactNumber.removeWhitespacesInBetween()
        guard contactNumber.count >= 10 else {
            dismiss(animated: true) {
                self.showSwiftMessage(title: AlertTitle.warning, message: "Selected contact does not have a valide phone number", type: "error")

            }
            return
        }
        txt_phone.text = String(contactNumber.suffix(10))

    }
*/
}
extension ReferVC:CountryListDelegate{
    func selectedCountry(country: CountryModel) {
        lblCodeDD.text = country.flag! + " +" + country.phoneExtension
        lblCodeDD2.text = country.flag! + " +" + country.phoneExtension
        countryCode = ("+\(country.phoneExtension ?? "0")")
    }
    
    
}
