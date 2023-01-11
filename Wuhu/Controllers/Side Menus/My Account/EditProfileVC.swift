//
//  EditProfileVC.swift
//  Wuhu
//
//  Created by afrazali on 30/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import DropDown
import AVFoundation
import LinearProgressView
import SwiftyJSON


class EditProfileVC: BaseVC,CountryListDelegate {
    
    
    
    @IBOutlet var linearProgressView: LinearProgressView!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var txt_fname: UITextField!
    @IBOutlet weak var txt_lname: UITextField!
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_address: UITextField!
    @IBOutlet weak var txt_city: UITextField!
    @IBOutlet weak var txt_province: UITextField!
    @IBOutlet weak var txt_country: UITextField!
    @IBOutlet weak var txt_zip: UITextField!
    
    @IBOutlet weak var txt_dob: UITextField!
    @IBOutlet weak var txt_pass: UITextField!
    @IBOutlet weak var txt_confirmPass: UITextField!
    
    @IBOutlet weak var phoneView: UIView!
    
    @IBOutlet weak var maleview: UIView!
    @IBOutlet weak var femaleView: UIView!
    @IBOutlet weak var lblCodeDD: UILabel!
    @IBOutlet weak var btnCodeDD: UIButton!
    @IBOutlet weak var flageImg: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var lblPercent: UILabel!
    
    @IBOutlet weak var dlgRs: UILabel!
     @IBOutlet weak var dlgPts: UILabel!
     @IBOutlet weak var dlgView: UIView!
    
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var cpassView: UIView!
    @IBOutlet weak var advanceSettings: UIButton!
    
    let codeDD      = DropDown()
    let provincesDD = DropDown()
    let countryDD   = DropDown()
    
    var isMaleSelected = false
    var isFemaleSelected  = false
    var isOtherSelected  = false
    var maleFemaleValue = ""
    
    var selectedImg   = UIImage()
    var isImgSelected = false
    var userInfo:UserData?
    var countryList = CountryList()
    var phoneCode = ""
    var pick = 0
    var countryId = 0
    var stateId = 0
    var countriesList = [CountryModel]()
    
    fileprivate var alertStyle: UIAlertController.Style = .actionSheet
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        Applicationevents.postInfo(string: "my_profile")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileView.isUserInteractionEnabled = true
        profileView.addGestureRecognizer(tapGestureRecognizer)
        countryList.delegate = self
        
    }
    
    
    // MARK: - Custom
    
    func hideSettings(isShow:Bool) {
        
        deleteView.isHidden = isShow
        text.isHidden = isShow
        passView.isHidden = isShow
        cpassView.isHidden = isShow
        
    }
    
    func selectedCountry(country: CountryModel) {
        switch pick {
        case 0:
            lblCodeDD.text = country.flag! + " +" + country.phoneExtension
            phoneCode = ("00\(country.phoneExtension ?? "0")")
            break
        case 1:
            txt_country.text = country.name
            countryId = country.id
            break
        case 2:
            txt_province.text = country.name
            stateId = country.id
        case 3:
            txt_city.text = country.name
        default:
            print("default")
        }

    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.imageSource()
    }
    
    
    func populateUserData() {
        
        userInfo = self.Shared.userInfo
        
        if userInfo?.user_avatar != nil {
            let fullImgPath = GlobalURL.imgPath + "\(userInfo!.user_avatar!)"
            let imgUrl = URL(string: fullImgPath)
            print(fullImgPath)
            self.profileImg.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
//            let newImage = UIImage(cgImage: profileImg.image!.cgImage!, scale: profileImg.image!.scale, orientation: .up)
//            profileImg.image = newImage
            
        }
        
        self.lblPercent.text = "\(userInfo?.completed_profile ?? 0)"+"%"
        linearProgressView.setProgress(Float(userInfo?.completed_profile ?? 0), animated: true)
        self.txt_fname.text = userInfo?.user_first_name
        self.txt_lname.text = userInfo?.user_family_name
        let mobile = userInfo?.user_mobile ?? "0"
        
        if userInfo?.countryCode?.count == 0 {
        
        let code = mobile.substring(to: 4)
        let newString = code.replacingOccurrences(of: "00", with: "")
        phoneCode = newString
        getCountryWithCode(code: newString)
        self.txt_phone.text = mobile.substring(from: 4)
        }else{
            
            let newString = userInfo?.countryCode!.replacingOccurrences(of: "00", with: "")
            getCountryWithCode(code: newString)
            self.txt_phone.text = mobile.substring(from: ((userInfo?.countryCode!.count)!))
            
            if userInfo!.countryCode!.contains("+"){
                let newString = userInfo?.countryCode!.replacingOccurrences(of: "+", with: "")
                getCountryWithCode(code: newString)
                self.txt_phone.text = mobile.substring(from: ((userInfo?.countryCode!.count)!+1))
            }
        }
        
        
//        print(mobile.substring(from: mobile.count-10))         // playground
//        print(mobile.substring(to: mobile.count-10))           // Hello
//                print(mobile.substring(with: 1..<5))
       
        //        self.txt_phone.text = userInfo?.user_mobile
        
        self.txt_email.text = userInfo?.email
        self.txt_address.text = userInfo?.address
        self.txt_city.text = userInfo?.city
        self.txt_zip.text = userInfo?.postal_code
        
        if userInfo?.gender == "male"{
            
//            self.isMaleSelected = true
//            self.btnMale.isSelected = true
            btnMale.setImage(UIImage(named: "m2"), for: .normal)
            maleFemaleValue = "male"
//
//            self.btnFemale.isSelected = false
//            self.isFemaleSelected = false
        }else if userInfo?.gender == "female" {
            
//            self.isMaleSelected = false
//            self.btnMale.isSelected = false
//
            btnFemale.setImage(UIImage(named: "f2"), for: .normal)
            maleFemaleValue = "female"
//
//            self.btnFemale.isSelected = true
//            self.isFemaleSelected = true
        }else{
            btnOther.setImage(UIImage(named: "mf2"), for: .normal)
            maleFemaleValue = "other"
        }
        
        self.txt_dob.text = userInfo?.dob
        self.txt_province.text = userInfo?.state
        self.txt_country.text = userInfo?.country
        
    }
     func getCountryWithCode(code : String?){
            self.showLoader()
            UserHandler.getCountries(endPoint: "get-countries", success: { (successResponse) in
                self.stopAnimating()
                if successResponse.status == true {
                    Applicationevents.postInfo(string: "edit_profile_request")
                    self.countriesList = successResponse.data
                    for i in self.countriesList{
                        if i.phoneExtension == code{
                            self.lblCodeDD.text = (i.flag!) + " +" + i.phoneExtension
                            self.phoneCode = "00"+"\(i.phoneExtension ?? "")"
                            if self.userInfo?.country == "" {
                                self.txt_country.text = "\(i.name ?? "South Africa")"
                            }
                            
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
//    func getCountryWithCode(code : String?) {
//
//        let countries = Countries()
//        let countryList = countries.countries
//
//        var singleCountry = [CountryModel2]()
//
//        for country in countryList {
//            if("+\(country.phoneExtension)" == code){
//                singleCountry.append(country)
//            }
//        }
//
//        if(singleCountry.count > 0){
//            let single = singleCountry.first
//            lblCodeDD.text = (single?.flag!)! + " +" + single!.phoneExtension
//
//            //            countryCode = ("+\(single!.phoneExtension)")
//        }
//
//    }
    func setUIElements() {
        
        linearProgressView.animationDuration = 0.5
        self.setCodeDD()
        self.setCountryDD()
        self.setProvinceDD()
        
        
        self.populateUserData()
        self.profileImg.roundSquareImage()
        self.profileView.drawBorder(width: 4, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        self.profileView.layer.cornerRadius = self.profileView.frame.size.width / 2
        
        self.txt_fname.setBorderWidth(width: 1)
        self.txt_lname.setBorderWidth(width: 1)
        self.txt_email.setBorderWidth(width: 1)
        self.txt_country.setBorderWidth(width: 1)
        self.txt_province.setBorderWidth(width: 1)
        self.txt_city.setBorderWidth(width: 1)
        self.txt_zip.setBorderWidth(width: 1)
        self.txt_dob.setBorderWidth(width: 1)
        self.txt_pass.setBorderWidth(width: 1)
        self.txt_address.setBorderWidth(width: 1)
        
        self.txt_confirmPass.setBorderWidth(width: 1)
        self.phoneView.setBorderWidth(width: 1)
        
        self.txt_fname.setLeftPaddingPoints()
        self.txt_lname.setLeftPaddingPoints()
        self.txt_email.setLeftPaddingPoints()
        self.txt_country.setLeftPaddingPoints()
        self.txt_province.setLeftPaddingPoints()
        self.txt_address.setLeftPaddingPoints()
        
        self.txt_city.setLeftPaddingPoints()
        self.txt_zip.setLeftPaddingPoints()
        self.txt_dob.setLeftPaddingPoints()
        self.txt_pass.setLeftPaddingPoints()
        self.txt_confirmPass.setLeftPaddingPoints()
        
        
        self.btnSave.setBtnUI()
//        btnDelete.layer.cornerRadius = 26
        
    }
    
    func isCheck() -> Bool {
        
        let fname            = self.txt_fname.text
        let lname            = self.txt_lname.text
        //        let phone            = self.txt_phone.text
                let email            = self.txt_email.text
        //        let address          = self.txt_address.text
        //        let city             = self.txt_city.text
        //        let province         = self.txt_province.text
        //        let country          = self.txt_country.text
        //        let zip              = self.txt_zip.text
        //        let dob              = self.txt_dob.text
        let password         = self.txt_pass.text
        let confirmPass      = self.txt_confirmPass.text
        
        
        //        if isImgSelected == false {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.profileImgRequired, type: "error")
        //            return false
        //        }
        
        if fname == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.fNameRequire, type: "error")
            return false
        }
        
        if lname == ""  {
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.lNameRequire, type: "error")
            return false
        }
        
        //        if phone == ""  {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.phoneValid, type: "error")
        //            return false
        //        }else if (phone!.count < 10) {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.phoneValid, type: "error")
        //            return false
        //        }
        //
        //        if email == ""  {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.emailValid, type: "error")
        //            return false
        //        }else
        if (!email!.isValidEmail) {
                    self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.emailValid, type: "error")
                    return false
                }
        
        //
        //        if address == ""  {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.addressRequired, type: "error")
        //            return false
        //        }
        //
        //        if city == ""  {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.cityRequired, type: "error")
        //            return false
        //        }
        //
        //        if province == ""  {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.provinceRequired, type: "error")
        //            return false
        //        }
        //
        //        if country == ""  {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.countryRequired, type: "error")
        //            return false
        //        }
        //
        //        if zip == ""  {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.zipRequired, type: "error")
        //            return false
        //        }
        //
        //        if dob == ""  {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.dobRequired, type: "error")
        //            return false
        //        }
        //
        //        if password == "" {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.passwordRequire, type: "error")
        //            return false
        //        }else if password!.count < 6 {
        //
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.minimumPass, type: "error")
        //            return false
        //
        //        }else if password!.count > 6 {
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
        //                self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.alphanumericpassRequire, type: "error")
        //
        //                return false
        //            }
        //        }
        //
        //
        //        if confirmPass == "" {
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.confirmPasswordRequire, type: "error")
        //            return false
        //        }else if confirmPass!.count < 6 {
        //
        //            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.confirmPasswordRequire, type: "error")
        //            return false
        //
        //        }else if confirmPass!.count > 6 {
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
        //
        //                return false
        //            }
        //        }
        
        if password != confirmPass {
            
            self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.passwordMatch, type: "error")
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
        
        //        self.codeDD.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
        //            guard let cell = cell as? FlagCell else { return }
        //            cell.logoImageView.image = UIImage(named: General.flagImageArray[index])
        //            cell.optionLabel.text = General.countryCodeArray[index]
        //        }
        
        // Action triggered on selection
        self.codeDD.selectionAction = { [unowned self] (index, item) in
            let index = self.codeDD.indexForSelectedRow
            print(index!)
            self.flageImg.image = UIImage(named: General.flagImageArray[index!])
            self.lblCodeDD.text = item
        }
        
        codeDD.cancelAction = { [unowned self] in
        }
    }
    
    func setCountryDD() {
        
        self.countryDD.anchorView = txt_country
        self.countryDD.bottomOffset = CGPoint(x: 10, y: self.txt_country.bounds.height)
        self.countryDD.dataSource = General.countryNameArray
        self.countryDD.textColor = #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1)
        self.countryDD.direction = .any
        self.countryDD.selectionAction = { [weak self] (index, value) in
            self?.txt_country.text = value
        }
        countryDD.cancelAction = { [unowned self] in}
    }
    
    func setProvinceDD() {
        
        self.provincesDD.anchorView = txt_province
        self.provincesDD.bottomOffset = CGPoint(x: 10, y: self.txt_province.bounds.height)
        self.provincesDD.dataSource = General.provinceArray
        self.provincesDD.textColor = #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1)
        self.provincesDD.direction = .any
        self.provincesDD.selectionAction = { [weak self] (index, value) in
            self?.txt_province.text = value
        }
        provincesDD.cancelAction = { [unowned self] in}
    }
    
    func showDOB() {
        
        let currentDate = Date()
        let alert = UIAlertController(style: self.alertStyle, title: "Select Date Of Birth", message: "")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: currentDate) { date in
            let formatter = DateFormatter()
            //            dd MMMM yyyy
            
            formatter.dateFormat = "yyyy-MM-dd"
            self.txt_dob.text = formatter.string(from: date)
        }
        
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    // Image picking from gallery
    
    func imageSource() {
        
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            self.allowedPermision()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    DispatchQueue.main.async {
                        self.allowedPermision()
                        
                    }
                    
                } else {
//                    let alertView = AlertView.failed(message: "User has denaied camera and gallery permission for this application.",okAction: {
//                    })
//                    self.present(alertView, animated: true, completion: nil)
                    DispatchQueue.main.async {
                        self.showSwiftMessage(title: AlertTitle.warning, message: AlertMsg.permissionCamera, type: "error")
                    }
                }
            })
        }
    }
    
    func allowedPermision() {
        
        // call picker controller to pick an image
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        // declaring actionSheet
        let actionSheet = UIAlertController(title: "Please select source", message: "Camera or Photo library", preferredStyle: UIAlertController.Style.actionSheet)
        
        // camera button
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { action -> Void in
            
            // select camera as a source of picker
            pickerController.sourceType = UIImagePickerController.SourceType.camera
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let photoLibraryAction = UIAlertAction(title: "PhotoLibrary", style: UIAlertAction.Style.default) { action -> Void in
            
            // select photo library as a source of picker
            pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        
        // cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        actionSheet.view.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        
        // presenting actionsheet
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - API Call
    
    func updateProfileWithImg(){
        
        print(self.KC_userID)
        
        var parameters : [String: Any]
        parameters = [
            "first_name"        : self.txt_fname.text!,
            "last_name"         : self.txt_lname.text!,
            "city"              : self.txt_city.text!,
            "postal_code"       : self.txt_zip.text!,
            "user_id"           : KC_userID,
            "phone"             : self.getPhoneNumber(countryCode: phoneCode, actualPhoneNumber: setMobile(number: txt_phone.text!)),
            "password"          : self.txt_pass.text!,
            "old_password"      : self.txt_confirmPass.text!,
            "dob"               : self.txt_dob.text!,
            "is_email"          : true,
            "gender"            : maleFemaleValue,
            "address"           : txt_address.text!,
            "state"             : txt_province!.text!,
            "country"           : txt_country.text!,
            "email"             :txt_email.text!,
            "country_code"      :phoneCode
        ]
        
        print(parameters)
        
        self.showLoader()
        //        self.compressImageWithAspectRatio(image: self.selectedImg)
        UserHandler.updateProfileWithParam(params: parameters as NSDictionary, imageData: self.selectedImg.jpegData(compressionQuality: 0.4), success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                
//                var contextData : [String: Any]
//                       contextData = [
//                           "mData.event.profileLinkName"              : "<<PROFILE LINK NAME>>"
//                       ]
//                       ADBMobile.collectLifecycleData(withAdditionalData: contextData)
                AdobeTag.event(key: "UPDATED PROFILE STATUS", value: "ProfileStatus")
                
                self.matomoTracker.track(view: ["UPDATED PROFILE STATUS","ProfileStatus"])
                self.showSwiftMessage(title: AlertTitle.success, message: successResponse.message!, type: "success")
                let points = successResponse.point ?? 0
                if points > 0{

                    self.Shared.userInfo?.totalPoint = (self.Shared.userInfo?.totalPoint)! + points
                    self.Shared.userInfo?.rs = (self.Shared.userInfo?.rs)! + getPoints.rs(point: points)
                    self.dlgPts.text = "\(points)" + " pts"
                    self.dlgRs.text = "R"+"\(getPoints.rs(point: points))"
                    self.view.bringSubviewToFront(self.dlgView)
                    self.dlgView.isHidden = false
                }
                let updated = successResponse.data!
                let old = self.userInfo!
                old.user_first_name = updated.user_first_name
                old.user_family_name = updated.user_family_name
                old.city = updated.city
                old.postal_code = updated.postal_code
                old.dob = updated.dob
                old.is_email = updated.is_email
                old.gender = updated.gender
                old.address = updated.address
                old.state = updated.state
                old.country = updated.country
                old.email = updated.email
                old.user_avatar = updated.user_avatar
                old.completed_profile = updated.completed_profile
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    if successResponse.message == "Please activate your account."{
                        self.Shared.activateParam["is_existing_user"] = "1"
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActiveUser") as! ActiveUser
                        vc.phone = self.phoneCode + self.setMobile(number: self.txt_phone.text!)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        if points > 0{
                        }else{
                            if  MissionInfo.missionVc{
//                                self.backTwo()
                                self.moveBack()
                            }else{
                                self.moveBack()
                            }
                            MissionInfo.missionVc = false
                        }
                    }
                })
                
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
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
                self.txt_confirmPass.isSecureTextEntry = false
            }else {
                self.txt_confirmPass.isSecureTextEntry = true
            }
        }
    }
    func backTwo() {
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    @IBAction func actionDlgCont(_ sender: Any) {
        if  MissionInfo.missionVc{
            NotificationCenter.default.post(name: Notification.Name("GoToMission"), object: "")
            backTwo()
        }else{
        self.moveBack()
        }
        MissionInfo.missionVc = false
    }
    @IBAction func actionSetting(_ sender: UIButton) {

        advanceSettings.isHidden = true
        if deleteView.isHidden{

        hideSettings(isShow: false)
        }else{
        hideSettings(isShow: true)
        }
        
    }
    @IBAction func actionDelete(_ sender: UIButton) {

//        let alert = UIAlertController(title: "Alert", message: "Are you Sure!", preferredStyle: .alert)

        let refreshAlert = UIAlertController(title: "Are you sure you want delete your account?", message: "", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
            self.deleteAcc()
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func maleFemaleActionAction(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        print(sender.isSelected)
        if sender.tag == 0 {
            unselectButton()
            btnMale.setImage(UIImage(named: "m2"), for: .normal)
//            if sender.isSelected   {
//
//                self.isMaleSelected = true
//                self.btnMale.isSelected = true
                maleFemaleValue = "male"
//
//
//                self.btnFemale.isSelected = false
//                self.isFemaleSelected = false
//
//            }else {
//                self.isMaleSelected = false
//                self.btnMale.isSelected = false
//                maleFemaleValue = "female"
//
//                self.btnFemale.isSelected = true
//                self.isFemaleSelected = true
//
//            }
        }else if sender.tag == 1{
            unselectButton()
            btnFemale.setImage(UIImage(named: "f2"), for: .normal)
//            if sender.isSelected {
//                self.isFemaleSelected = true
//                self.btnFemale.isSelected = true
//
                maleFemaleValue = "female"
//
//                self.btnMale.isSelected = false
//                self.isMaleSelected = false
//            }else {
//
//                self.isFemaleSelected = false
//                self.btnFemale.isSelected = false
//                self.btnMale.isSelected = true
//                self.isMaleSelected = true
//
//                maleFemaleValue = "male"
//
//            }
        }else if sender.tag == 2{
            unselectButton()
            btnOther.setImage(UIImage(named: "mf2"), for: .normal)
//            if sender.isSelected {
//                self.isOtherSelected = true
//                self.btnOther.isSelected = true
//
                maleFemaleValue = "other"
//
//                self.btnMale.isSelected = false
//                self.isMaleSelected = false
//                self.btnFemale.isSelected = false
//                self.isFemaleSelected = false
//            }else {
//
//                self.isOtherSelected = false
//                self.btnOther.isSelected = false
//                self.btnMale.isSelected = true
//                self.isMaleSelected = true
//
//                maleFemaleValue = "male"
//
//            }
        }
    }
    func deleteAcc(){
        
        var parameters : [String: Any]
        parameters = [
            ""              : ""
            
        ]
        self.showLoader()
        print(parameters)
        UserHandler.deleteAccount(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            
            let resp = JSON(successResponse)
            
            if resp["status"] == true {
             self.showSwiftMessage(title: AlertTitle.success, message: resp["message"].stringValue, type: "success")
              //  UserDefaults.standard.set("", forKey: KeyChainKeys.userPhone)
                UserDefaults.standard.set(false, forKey: KeyChainKeys.isLogedIn)
                self.AppDelegate.moveToInitial()
//                self.AppDelegate.moveToLogIn(isLogIn: false)
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: resp["message"].stringValue, type: "error")
            }
        }) { (error) in
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func unselectButton() {
        btnMale.setImage(UIImage(named: "m1"), for: .normal)
        btnFemale.setImage(UIImage(named: "f1"), for: .normal)
        btnOther.setImage(UIImage(named: "mf1"), for: .normal)
    }
    
    func callCountry() {
        
        let navController = UINavigationController(rootViewController: countryList)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func btnActionback(_ sender: UIButton) {
        
        self.popVC()
    }
    
    @IBAction func actionCodeDD(_ sender: UIButton) {

        pick = 0
        CountryList.endpoint = "get-countries"
        callCountry()
        //        self.codeDD.show()
    }
    
    @IBAction func actionSelectPicture(_ sender: UIButton) {
        self.imageSource()
        
    }
    @IBAction func actionSave(_ sender: UIButton) {
        
        if isCheck() {
            updateProfileWithImg()
        }
    }
}


extension EditProfileVC : UITextFieldDelegate {
    
    @IBAction func actionCount(_ sender: UIButton) {
        pick = 1
        CountryList.endpoint = "get-countries"
        callCountry()
    }
    @IBAction func actionProvince(_ sender: UIButton) {
        pick = 2
        if txt_country.text!.isEmpty {
            self.showSwiftMessage(title: "", message: "Please Select country", type: "error")
        }else{
            let encoded = txt_country.text!.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            CountryList.endpoint = "get-states?country_name="+"\(encoded ?? "")"
            callCountry()
        }
    }
    @IBAction func actionCity(_ sender: UIButton) {
        pick = 3
        if txt_province.text!.isEmpty {
            self.showSwiftMessage(title: "", message: "Please Select Province", type: "error")
        }else{
            let encoded = txt_province.text!.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            CountryList.endpoint = "get-cities?state_name="+"\(encoded ?? "")"
            
            callCountry()
        }
    }
    @IBAction func actionDob(_ sender: UIButton) {
        self.showDOB()
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_fname {
            self.txt_fname.becomeFirstResponder()
        }else if textField == txt_lname {
            self.txt_lname.becomeFirstResponder()
        }else if textField == txt_phone {
            self.txt_phone.becomeFirstResponder()
        }else if textField == txt_email {
            self.txt_email.becomeFirstResponder()
        }else if textField == txt_address {
            self.txt_address.becomeFirstResponder()
        }else if textField == txt_city {
            self.txt_city.resignFirstResponder()
            pick = 3
            if txt_province.text!.isEmpty {
                self.showSwiftMessage(title: "", message: "Please Select Province", type: "error")
            }else{
                let encoded = txt_province.text!.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                CountryList.endpoint = "get-cities?state_name="+"\(encoded ?? "")"

                callCountry()
            }
        }else if textField == txt_zip {
            self.txt_zip.becomeFirstResponder()
        }else if textField == txt_country {
            self.txt_country.resignFirstResponder()
            pick = 1
            CountryList.endpoint = "get-countries"
            callCountry()
//            self.countryDD.show()
        }else if textField == txt_pass {
            self.txt_pass.becomeFirstResponder()
        }else if textField == txt_confirmPass {
            self.txt_confirmPass.becomeFirstResponder()
        }else if textField == txt_province{
            self.txt_province.resignFirstResponder()
            pick = 2
            if txt_country.text!.isEmpty {
                self.showSwiftMessage(title: "", message: "Please Select country", type: "error")
            }else{
            let encoded = txt_country.text!.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                CountryList.endpoint = "get-states?country_name="+"\(encoded ?? "")"
            callCountry()
            }
//            self.provincesDD.show()
        }else if textField == txt_dob{
            self.txt_dob.resignFirstResponder()
            self.showDOB()
        }else if textField == txt_pass{
            self.txt_pass.becomeFirstResponder()
        }else if textField == txt_confirmPass{
            self.txt_confirmPass.becomeFirstResponder()
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


extension EditProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if var pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            pickedImage = fixOrientation(img: pickedImage)
            self.profileImg.image = pickedImage
//            let newImage = UIImage(cgImage: pickedImage.cgImage!, scale: pickedImage.scale, orientation: .up)
            self.selectedImg = pickedImage
            self.isImgSelected = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
   func fixOrientation(img:UIImage) -> UIImage {

    if (img.imageOrientation == UIImage.Orientation.up) {
          return img;
      }

      UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale);
      let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
    img.draw(in: rect)

    let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext();
      return normalizedImage;

    }
}
