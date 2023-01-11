//
//  ContactUs.swift
//  Wuhu
//
//  Created by Awais on 30/04/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import DropDown
import SwiftyJSON

class ContactUs: BaseVC {
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var textDrop: UITextField!
    @IBOutlet weak var imgDrop: UIImageView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var cell: UITextField!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var question: UITextView!
    
    let provincesDD = DropDown()
     var countryList = CountryList()
    var countryCode = ""
    var countriesList = [CountryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        btnSubmit.setBtnUI()
        countryList.delegate = self
        setProvinceDD()
        getCountries()
        Applicationevents.postInfo(string: "contact_us")
        
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
                                self.lblCountry.text = (i.flag!) + " +" + i.phoneExtension
                                
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
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
    }
    // MARK: -  IBActions
    @IBAction func actiondrop(_ sender: UIButton) {
        
        
        if sender.isSelected{
            
            imgDrop.image = UIImage(imageLiteralResourceName: "down_arrow")
        }else{
            imgDrop.image = UIImage(imageLiteralResourceName: "contact_arrow")
        }
        self.provincesDD.show()
    }
    @IBAction func actionSubmit(_ sender: UIButton) {
        if isCheck() {
            postInfo()
        }
        
    }
    @IBAction func actionCountry(_ sender: UIButton) {
        CountryList.endpoint = "get-countries"
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    // MARK: -  functions
    func postInfo(){
        
        var parameters : [String: Any]
        parameters = [
            "first_name"              : fname.text!,
            "last_name"               : lname.text!,
            "contact_no"              : cell.text!,
            "enquiry_about"           : textDrop.text!,
            "email"                   : email.text!,
            "question"                : question.text!,
            
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.contactUs(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let resp = JSON(successResponse)
            if resp["status"] == true {
             self.showSwiftMessage(title: "", message: resp["message"].stringValue, type: "success")
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: resp["message"].stringValue, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    func isCheck() ->Bool  {
        if fname.text! == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.fNameRequire, type: "error")
            return false
        }
        
        if lname.text == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.lNameRequire, type: "error")
            return false
        }
        if cell.text!.count<10 {
            self.showSwiftMessage(title: "", message: AlertMsg.invalidPhone, type: "error")
            return false
        }
        if !email.text!.isEmpty && !email.text!.isValidEmail {
            self.showSwiftMessage(title: "", message: AlertMsg.emailValid, type: "error")
            return false
        }
        if textDrop.text! == "" {
            self.showSwiftMessage(title: "", message: " Please do select an Enquiry topic.", type: "error")
            return false
        }
        if question.text! == "" {
            self.showSwiftMessage(title: "", message: "Questions field can't be empty", type: "error")
            return false
        }
        return true
    }
    func setProvinceDD() {
        
        self.provincesDD.anchorView = btnDrop
        self.provincesDD.bottomOffset = CGPoint(x: 10, y: self.btnDrop.bounds.height)
        self.provincesDD.dataSource = General.EnquireArray
        self.provincesDD.textColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5568627451, alpha: 1)
        self.provincesDD.selectionBackgroundColor = #colorLiteral(red: 0.2760836482, green: 0.09022749215, blue: 0.4942057133, alpha: 1)
        self.provincesDD.selectedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.provincesDD.direction = .any
        //        self.provincesDD.
        
        self.provincesDD.selectionAction = { [weak self] (index, value) in
            self?.textDrop.text = value
            self?.imgDrop.image = UIImage(imageLiteralResourceName: "down_arrow")
        }
        provincesDD
        provincesDD.cancelAction = { [unowned self]
            in
            
        }
    }
}
extension ContactUs:CountryListDelegate,UITextFieldDelegate,UITextViewDelegate{
    func selectedCountry(country: CountryModel) {
        lblCountry.text = country.flag! + " +" + country.phoneExtension
        countryCode = ("+\(country.phoneExtension ?? "")")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cell{
            let maxLength = 15
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            return true
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if question.text.count == 0{
            
        }else{
            question.text = ""
        }
    }
    
}
