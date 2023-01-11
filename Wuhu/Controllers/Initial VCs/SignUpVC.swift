//
//  SignUpVC.swift
//  WATERCO
//
//  Created by afrazali on 14/10/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import UIKit
import DropDown

/*
class SignUpVC: BaseVC {

    @IBOutlet weak var profileImg: UIImageView!{
        didSet {
            self.profileImg.roundSquareImage()
        }
    }
    
    @IBOutlet weak var txt_fname: UITextField!
    @IBOutlet weak var lineFname: UIView!
    @IBOutlet weak var tickFname: UIImageView!
    
    @IBOutlet weak var txt_lname: UITextField!
    @IBOutlet weak var lineLname: UIView!
    @IBOutlet weak var tickLname: UIImageView!

    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var linePhone: UIView!
    @IBOutlet weak var tickPhone: UIImageView!

    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var lineEmail: UIView!
    @IBOutlet weak var tickEmail: UIImageView!

    @IBOutlet weak var txt_standNum: UITextField!
    @IBOutlet weak var lineStandNum: UIView!
    @IBOutlet weak var tickStandNum: UIImageView!

    @IBOutlet weak var txt_pass: UITextField!
    @IBOutlet weak var linePass: UIView!
    @IBOutlet weak var tickPass: UIImageView!

    @IBOutlet weak var txt_confirm: UITextField!
    @IBOutlet weak var lineConfirm: UIView!
    @IBOutlet weak var tickConfirm: UIImageView!
    
    @IBOutlet weak var dependentTable: UITableView!
    @IBOutlet weak var btnJoinNow: UIButton!
    
    @IBOutlet weak var btnCountryCodeDropDown: UIButton!
    
    // Country Code DropDown
    
    @IBOutlet weak var flageImg: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!

    @IBOutlet weak var contentHight: NSLayoutConstraint!
    @IBOutlet weak var tblHight: NSLayoutConstraint!
    
    let countryCodeDropDown = DropDown()

    var dependentCount = 0
        
    var dependentObj : [String: Any] = [
        "first_name" : "",
        "last_name"  : "",
        "dob"        : "",
        "phone"      : "",
        "email"      : ""

    ]
    var dependentArr = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.dependentArr.append(dependentObj)
        self.setUIElements()
    }
    
    func setUIElements() {
        
        tblHight.constant = 0
        self.dependentTable.isHidden = true
        self.btnJoinNow.setBtnUI()
        self.dependentTable.separatorStyle = .none
        self.dependentTable.estimatedRowHeight = 350
        self.contentHight.constant = 100
        self.setUpCountryCodeDropDown()
        
    }
    
    func isCheck() -> Bool {
        
//        guard let fname       = self.txt_fname.text else {return}
//        guard let lname       = self.txt_lname.text else {return}
//        guard let phone       = self.txt_phone.text else {return}
//        guard let email       = self.txt_email.text else {return}
//        guard let standNUmber = self.txt_standNum.text else {return}
//        guard let password    = self.txt_pass.text else {return}
//        guard let confirmPass = self.txt_confirm.text else {return}

        let fname           = self.txt_fname.text
        let lname           = self.txt_lname.text
        let phone           = self.txt_phone.text
        let email           = self.txt_email.text
        let standNUmber     = self.txt_standNum.text
        let password        = self.txt_pass.text
        let confirmPass     = self.txt_confirm.text

        
        if fname == ""  {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.fNameRequire)
            self.lineFname.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
        
        if lname == ""  {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.lNameRequire)
            self.lineLname.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
        
        
        if phone == ""  {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.mobileNoRequire)
            self.linePhone.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }else if (phone!.count < 10) {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.mobileNoRequire)
            self.linePhone.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
//        else if (!phone!.isValidPhone(value: phone!)) {
//            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.mobileNoRequire)
//            self.linePhone.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//            return false
//        }
        
        if email == ""  {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.fNameRequire)
            self.lineEmail.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }else if (!email!.isValidEmail) {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.emailValid)
            self.lineEmail.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
        
        if standNUmber == ""  {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.standNumberRequired)
            self.lineStandNum.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
        
        if password == "" {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.passwordRequire)
            self.linePass.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }else if password!.count < 6 {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.minimumPass)
            self.linePass.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
        
        if confirmPass == "" {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.confirmPasswordRequire)
            self.lineConfirm.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }else if confirmPass!.count < 6 {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.minimumPass)
            self.lineConfirm.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }
        
        if password != confirmPass {
            self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.passwordMatch)
            self.linePass.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.lineConfirm.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return false
        }else if (password == confirmPass) {
            var regex:String = ""
            let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
            if self.txt_pass.text!.rangeOfCharacter(from: characterset.inverted) != nil {
                regex = "^(?=.*[a-z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
            }else{
                regex = "^(?=.*[a-z])(?=.*\\d)[A-Za-z\\d?&]{8,}"
            }
            
            let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: self.txt_pass.text!)
            if(isMatched  == true) {
                return true
            }else {
                self.displayErrorMessage(title: AlertTitle.alert, message: AlertMsg.alphanumericpassRequire)
                return false
            }
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
            self.flageImg.image = UIImage(named: General.flagImageArray[index!])
            self.lblCountryCode.text = item
//            self.setupTextFieldMasking()
        }
        
        self.countryCodeDropDown.cancelAction = { [unowned self] in
           
        }
    }
    
   
    
    
    //MARK:- IBActions
    @IBAction func actionBackBtn(_ sender: Any) {
        self.popVC()
    }
    @IBAction func actionCountryCodeDropDown(_ sender: Any) {
        self.countryCodeDropDown.show()
    }
    
    @IBAction func actionAddDependant(_ sender: Any) {
        
        self.dependentTable.isHidden = false
        self.dependentCount += 1
        print(dependentCount)
        self.dependentTable.reloadData()
        
        let tblhight = self.dependentTable.contentSize.height
        print(tblhight)
        tblHight.constant = CGFloat(self.dependentCount * 350)
        
    }
    
    @IBAction func actionJoinNow(_ sender: Any) {
       
        if isCheck() {
            self.regiterAPICall()
        }
    }
    
    //MARK: - API Calls
    
    func regiterAPICall(){
        
        if dependentCount > 0 {
            
            print(dependentCount)
            for i in 0..<dependentCount {
                
                let indexPath = IndexPath(row: i, section: 0)
                let cell = dependentTable.cellForRow(at: indexPath) as! SignUpCell
                self.dependentObj["first_name"] = cell.txt_fname.text
                self.dependentObj["last_name"]  = cell.txt_lname.text
                self.dependentObj["dob"]        = cell.txt_dob.text
                self.dependentObj["phone"]      = "\(cell.lblCountryCode.text!)\(cell.txt_phone.text!)".replacingOccurrences(of: "+", with: "00")
                self.dependentObj["email"]      = cell.txt_email.text
                print(dependentObj)
                self.dependentArr.append(dependentObj)
            }
        }
 
        var parameters : [String: Any]
        parameters = [
            "first_name"         : self.txt_fname.text!,
            "last_name"          : self.txt_lname.text!,
            "email"              : self.txt_email.text!,
            "stand_number"       : self.txt_standNum.text!,
            "device_type"        :  "ios",
            "phone"              : "\(self.lblCountryCode.text!)\(self.txt_phone.text!)".replacingOccurrences(of: "+", with: "00"),
            "password"           : self.txt_pass.text!,
            "dependent"          : self.dependentArr
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.registerUser(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                
                self.Shared.userInfo = successResponse.data
                guard let poolURL = successResponse.data?.pool_ip_url else {
                    return
                }
                self.Shared.poolURL = poolURL
                
                KeychainWrapper.standard.set(self.txt_pass.text!, forKey: "userPassword")
                print(successResponse.data?.user_id)
                if let userid = successResponse.data?.user_id {
                    let saveSuccessful: Bool = KeychainWrapper.standard.set(userid, forKey: "userID")
                    print("Save was successful: \(saveSuccessful)")
                }
                
                self.pushController(name: StoryBoardIdentifier.VerificationVC)
                
            }else  {
            
                
                self.displayErrorMessage(title: AlertTitle.alert, message: successResponse.message!)

                
            }
        }) { (error) in
            self.stopAnimating()
        
            self.displayErrorMessage(title: AlertTitle.alert, message: (error?.message)!)

        }
    }
}



extension SignUpVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.925142467, green: 0.9332025647, blue: 0.9455558658, alpha: 1)
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 18, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Gotham-Medium", size: 15)
        headerLabel.textColor = #colorLiteral(red: 0.2335646451, green: 0.2856893241, blue: 0.3274032772, alpha: 1)
        headerLabel.text = self.tableView(self.dependentTable, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "FAMILY MEMBER"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dependentCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let dependentCell = dependentTable.dequeueReusableCell(withIdentifier: "SignUpCell", for: indexPath) as? SignUpCell {
            return dependentCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

extension SignUpVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == txt_fname {
            self.lineFname.backgroundColor = #colorLiteral(red: 0.1091324016, green: 0.4614989161, blue: 0.7148715258, alpha: 1)
        }else if textField == txt_lname {
            self.lineLname.backgroundColor = #colorLiteral(red: 0.1091324016, green: 0.4614989161, blue: 0.7148715258, alpha: 1)
        }else if textField == txt_phone {
            self.linePhone.backgroundColor = #colorLiteral(red: 0.1091324016, green: 0.4614989161, blue: 0.7148715258, alpha: 1)
        }else if textField == txt_email {
            self.lineEmail.backgroundColor = #colorLiteral(red: 0.1091324016, green: 0.4614989161, blue: 0.7148715258, alpha: 1)
        }else if textField == txt_standNum {
            self.lineStandNum.backgroundColor = #colorLiteral(red: 0.1091324016, green: 0.4614989161, blue: 0.7148715258, alpha: 1)
        }else if textField == txt_pass {
            self.linePass.backgroundColor = #colorLiteral(red: 0.1091324016, green: 0.4614989161, blue: 0.7148715258, alpha: 1)
        }else if textField == txt_confirm {
            self.lineConfirm.backgroundColor = #colorLiteral(red: 0.1091324016, green: 0.4614989161, blue: 0.7148715258, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txt_fname {
            self.lineFname.backgroundColor = #colorLiteral(red: 0.925142467, green: 0.9332025647, blue: 0.9455558658, alpha: 1)
            if txt_fname.text?.count == 0 {
                self.tickFname.isHidden = true
            }
        }else if textField == txt_lname {
            self.lineLname.backgroundColor = #colorLiteral(red: 0.925142467, green: 0.9332025647, blue: 0.9455558658, alpha: 1)
            if txt_lname?.text?.count == 0 {
                self.tickLname.isHidden = true
            }
        }else if textField == txt_phone {
            self.linePhone.backgroundColor = #colorLiteral(red: 0.925142467, green: 0.9332025647, blue: 0.9455558658, alpha: 1)
            if txt_phone?.text?.count == 0 {
                self.tickPhone.isHidden = true
            }
        }else if textField == txt_email {
            self.lineEmail.backgroundColor = #colorLiteral(red: 0.925142467, green: 0.9332025647, blue: 0.9455558658, alpha: 1)
            if txt_email?.text?.count == 0 {
                self.tickEmail.isHidden = true
            }
        }else if textField == txt_standNum {
            self.lineStandNum.backgroundColor = #colorLiteral(red: 0.925142467, green: 0.9332025647, blue: 0.9455558658, alpha: 1)
            if txt_standNum?.text?.count == 0 {
                self.tickStandNum.isHidden = true
            }
        }else if textField == txt_pass {
            self.linePass.backgroundColor = #colorLiteral(red: 0.925142467, green: 0.9332025647, blue: 0.9455558658, alpha: 1)
            if txt_pass?.text?.count == 0 {
                self.tickPass.isHidden = true
            }
        }else if textField == txt_confirm {
            self.lineConfirm.backgroundColor = #colorLiteral(red: 0.925142467, green: 0.9332025647, blue: 0.9455558658, alpha: 1)
            if txt_confirm?.text?.count == 0 {
                self.tickConfirm.isHidden = true
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txt_fname {
            if textField.text == "" {
                self.tickFname.isHidden = true
            }else {
                self.tickFname.isHidden = false
            }
        }else if textField == txt_lname {
            if textField.text == ""{
                self.tickLname.isHidden = true
            }else {
                self.tickLname.isHidden = false
            }
        }else if textField == txt_phone {
            
            if (!textField.text!.isValidPhone(value: textField.text!)) {
                self.tickPhone.isHidden = true
            }else {
                self.tickPhone.isHidden = false
            }
        }else if textField == txt_email {
            
            if (!textField.text!.isValidEmail) {
                self.tickEmail.isHidden = true
            }else {
                self.tickEmail.isHidden = false
            }
        }else if textField == txt_standNum {
            if textField.text == ""{
                self.tickStandNum.isHidden = true
            }else {
                self.tickStandNum.isHidden = false
            }
        }else if textField == txt_pass {
            if textField.text == ""{
                self.tickPass.isHidden = true
            }else {
                self.tickPass.isHidden = false
            }
        }else if textField == txt_confirm {
            if textField.text == ""{
                self.tickConfirm.isHidden = true
            }else {
                self.tickConfirm.isHidden = false
            }
        }
        return true
    }
}

 */
