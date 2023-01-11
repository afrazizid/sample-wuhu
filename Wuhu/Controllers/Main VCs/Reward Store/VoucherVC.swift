//
//  VoucherVC.swift
//  Wuhu
//
//  Created by afrazali on 11/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class VoucherVC: BaseVC {

    
    @IBOutlet weak var voucherTable: UITableView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lbldescreption: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var dlgView: UIView!
    @IBOutlet weak var dlgFormView: UIStackView!
    @IBOutlet weak var dlgName: UILabel!
    @IBOutlet weak var dlgImg: UIImageView!
    @IBOutlet weak var dlgPoints: UILabel!
    @IBOutlet weak var dlgRs: UILabel!
    @IBOutlet weak var dlgChk: UIButton!
    @IBOutlet weak var dlgFname: UITextField!
    @IBOutlet weak var dlgLname: UITextField!
    @IBOutlet weak var dlgContinue: UIButton!
    @IBOutlet weak var dlgCancel: UIButton!
    @IBOutlet weak var dlgScroll: UIScrollView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var giftView: UIStackView!
    @IBOutlet weak var lblDonate: UILabel!
    @IBOutlet weak var dlgDonate: UILabel!
    @IBOutlet weak var cell: UITextField!
    @IBOutlet weak var confirmCell: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var tickCell: UIImageView!
    @IBOutlet weak var tickConfirmCell: UIImageView!
    @IBOutlet weak var tickEmail: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var tempPhoneBtn: UIButton!
    
    @IBOutlet weak var countryLbl2: UILabel!
    @IBOutlet weak var tempPhoneBtn2: UIButton!
    
    var type = ""
    var image = ""
    var desc = ""
    var benefitId = 0
    var isGift = false
    
    var data = [Datum]()
    var dataObj: Datum!
    var countryList = CountryList()
    var countryCode = ""
    var countryCode2 = ""
    var myTag:Int!
    var countriesList = [CountryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        countryList.delegate = self
        
        self.setUI()
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
                                self.countryLbl.text = (i.flag!) + " +" + i.phoneExtension
                                self.countryLbl2.text = (i.flag!) + " +" + i.phoneExtension
                                self.countryCode =  "+"+"\(i.phoneExtension ?? "")"
                                self.countryCode2 =  "+"+"\(i.phoneExtension ?? "")"
                               
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
        dlgScroll.scrollTop()
        pts.text = "  "+"\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
              rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarBack(view: topBar)
        
    }
    
    // MARK: - functions
    func setUI() {
        self.tableViewSetup()
        img.image = UIImage(imageLiteralResourceName: image)
        lblType.text = type
        lbldescreption.text = desc
        dlgContinue.setBtnUI()
//        dlgImg.layer.cornerRadius = 30
        dlgCancel.layer.cornerRadius = 26
        dlgCancel.layer.borderWidth = 0.5
        dlgCancel.layer.borderColor = #colorLiteral(red: 0.9646012187, green: 0.9647662044, blue: 0.9645908475, alpha: 1)
        if type == "donate" {
            lblType.text = "Donate"
            giftView.isHidden = true
            lblDonate.text = "donation you've selected?"
        }else{
            giftView.isHidden = false
            lblDonate.text = "reward you've selected?"
        }
        cell.addTarget(self, action: #selector(textFieldEditingCell), for: UIControl.Event.editingChanged)
        confirmCell.addTarget(self, action: #selector(textFieldEditingconfirmCell), for: UIControl.Event.editingChanged)
        email.addTarget(self, action: #selector(textFieldEditingemail), for: UIControl.Event.editingChanged)
        self.getCat()
    }
    @objc func textFieldEditingCell(){
        //       checkFields()
        tickCell.isHidden = false
        if (cell.text!.count >= 10) {
            self.tickCell.image = UIImage(named: "tick")
        }else {
            self.tickCell.image = UIImage(named: "cross")
            
        }
    }
    @objc func textFieldEditingconfirmCell(){
        //       checkFields()
        tickConfirmCell.isHidden = false
        if (confirmCell.text!.count >= 10) {
            self.tickConfirmCell.image = UIImage(named: "tick")
        }else {
            self.tickConfirmCell.image = UIImage(named: "cross")
            
        }
    }
    @objc func textFieldEditingemail(){
        //       checkFields()
        tickEmail.isHidden = false
        if (email.text!.isValidEmail) {
            self.tickEmail.image = UIImage(named: "tick")
        }else {
            self.tickEmail.image = UIImage(named: "cross")
            
        }
    }
    func getCat(){
        if type == "Essentials"{
            type = "Groceries"
        }else if type == "Treats"{
            type = "Vouchers"
        }
        var parameters : [String: Any]
        parameters = [
            "type"              : type,
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.storeCat(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.data = successResponse.data
                self.voucherTable.reloadData()
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func isCheck() ->Bool  {
        if cell.text!.count<10 || confirmCell.text!.count<10 || cell.text!.isEmpty || confirmCell.text!.isEmpty{
            self.showSwiftMessage(title: "", message: AlertMsg.invalidPhone, type: "error")
            return false
        }
        if !email.text!.isEmpty && !email.text!.isValidEmail {
            self.showSwiftMessage(title: "", message: AlertMsg.emailValid, type: "error")
            return false
        }
        if self.getPhoneNumber(countryCode: countryCode, actualPhoneNumber: cell.text!) != self.getPhoneNumber(countryCode: countryCode2, actualPhoneNumber: confirmCell.text!) {
        self.showSwiftMessage(title: "", message: "CELLPHONE NUMBER AND CONFIRM CELLPHONE NUMBER MISMATCH", type: "error")
            return false
        }
        
        return true
    }
    func emptyFields()  {
        dlgFname.text = ""
        dlgLname.text = ""
        cell.text = ""
        confirmCell.text = ""
        email.text = ""
    }
    
    // MARK: - Actions
    @IBAction func btnActionback(_ sender: UIButton) {
           
           self.moveBack()
    }
    @IBAction func btnActionChk(_ sender: UIButton) {
        if dlgFormView.isHidden{
            dlgFormView.isHidden = false
            isGift = true
            dlgChk.setImage(UIImage(imageLiteralResourceName: "check"), for: .normal)
        }else{
            dlgChk.setImage(UIImage(imageLiteralResourceName: "unchk"), for: .normal)
            isGift = false
            dlgFormView.isHidden = true
        }
    }
    @IBAction func actionContinue(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = false
        if isGift {
            if isCheck() {
                
            }else{
                return
            }
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RedeemVC") as! RedeemVC
        vc.data = dataObj
        vc.type = type
        vc.mobile = self.getPhoneNumber(countryCode: countryCode, actualPhoneNumber: cell.text!)
        vc.isGift = isGift
        dlgView.isHidden = true
        dlgScroll.scrollTop()
        dlgChk.setImage(UIImage(imageLiteralResourceName: "unchk"), for: .normal)
        dlgFormView.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func actionCancel(_ sender: UIButton) {
        dlgView.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        dlgScroll.scrollTop()
        dlgChk.setImage(UIImage(imageLiteralResourceName: "unchk"), for: .normal)
        dlgFormView.isHidden = true
    }
    @IBAction func btnCountry(_ sender: UIButton) {
        myTag = sender.tag
        CountryList.endpoint = "get-countries"
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
}

extension VoucherVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableViewSetup()  {
        voucherTable.dataSource = self
        voucherTable.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = voucherTable.dequeueReusableCell(withIdentifier: "VoucherCell", for: indexPath) as! VoucherCell
        let imgUrl = URL(string: data[indexPath.row].image)
        cell.logo.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        cell.heading.text = data[indexPath.row].name
        cell.rs.text = "R"+"\(data[indexPath.row].amount ?? 0)"
        cell.points.text = "\(getPoints.points(rs: data[indexPath.row].amount))"+" pts"
        if type == "donate" {

            cell.donation.isHidden = false
            cell.desc.text = "\(data[indexPath.row].descriptionField ?? "")"+"\n\n"
        }
  /*      if indexPath.row == 0{
            cell.logo.image = UIImage(imageLiteralResourceName: "pickpay")
            cell.desc.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do "+"\n"
        }else if indexPath.row == 1{
                   cell.logo.image = UIImage(imageLiteralResourceName: "maker")
        }else if indexPath.row == 2{
                   cell.logo.image = UIImage(imageLiteralResourceName: "uber")
        }else if indexPath.row == 3{
                   cell.logo.image = UIImage(imageLiteralResourceName: "dis")
        }else if indexPath.row == 4{
                   cell.logo.image = UIImage(imageLiteralResourceName: "wool")
        }else if indexPath.row == 5{
                   cell.isHidden = true
        }*/
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dlgView.isHidden = false
//        self.view.window?.addSubview(dlgView)
        self.tabBarController?.tabBar.isHidden = true
//        self.tabBarController?.tabBar.layer.zPosition = -1

        let imgUrl = URL(string: data[indexPath.row].image)
        dlgImg.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        dlgName.text = data[indexPath.row].name
        isGift = false
        if type == "donate" {
            dlgDonate.isHidden = false
           // dlgRs.text = "R"+"\(data[indexPath.row].amount ?? 0)" + " DONATION"
        }else{
            dlgDonate.isHidden = true
        }
        dlgRs.text = "R"+"\(data[indexPath.row].amount ?? 0)"
        
        dlgPoints.text = "\(getPoints.points(rs: data[indexPath.row].amount))"+" pts"
        dataObj = data[indexPath.row]
    }
}





class VoucherCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var donation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension UIScrollView {
    func scrollTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
   }
}
extension VoucherVC : UITextFieldDelegate,CountryListDelegate {
    func selectedCountry(country: CountryModel) {
        if myTag == 0 {
            tempPhoneBtn.isHidden = true
            countryLbl.text = country.flag! + " +" + country.phoneExtension
             countryCode = ("+\(country.phoneExtension ?? "0")")
        }else{
            tempPhoneBtn2.isHidden = true
            countryLbl2.text = country.flag! + " +" + country.phoneExtension
            countryCode2 = ("+\(country.phoneExtension ?? "0")")
        }
        
       
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cell || textField == confirmCell{
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
