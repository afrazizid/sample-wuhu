//
//  BaseVC.swift
//  RewCap
//
//  Created by Afraz Ali / Engr.aqadar@gmail.com on 01/1/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.

import UIKit
import NVActivityIndicatorView
import Alamofire
import SwiftMessages
import Foundation
import SDWebImage
import LinearProgressView
import MatomoTracker

class BaseVC: UIViewController ,NVActivityIndicatorViewable{
    
    var pointsView: pointDialouge!
    
    //    let locationManager        = CLLocationManager()
    let Shared                 = SharedData.SharedUserInfo
    let AppDelegate            = UIApplication.shared.delegate as! AppDelegate
    
  //  let KC_userPhone    = UserDefaults.standard.string(forKey: KeyChainKeys.userPhone)
    let KC_userEmail    = UserDefaults.standard.string(forKey: KeyChainKeys.userEmail)
   // let KC_userPassword = UserDefaults.standard.string(forKey: KeyChainKeys.userPassword)
    let KC_userID       = UserDefaults.standard.integer(forKey: KeyChainKeys.userID)
    let KC_isLogedIn    = UserDefaults.standard.bool(forKey: KeyChainKeys.isLogedIn)
    let KC_Walk         = UserDefaults.standard.bool(forKey: "walkthrough_completed")
    
        //Bool
    
    
    #if Wuhu
    let matomoTracker = MatomoTracker(siteId: "5", baseURL: URL(string: "https://analytics.dev.syd.darkwing.io/matomo.php")!) // Dev
    #elseif WuhuQA
    let matomoTracker = MatomoTracker(siteId: "6", baseURL: URL(string: "https://analytics.dev.syd.darkwing.io/matomo.php")!) // QA
    #elseif WuhuPROD
    let matomoTracker = MatomoTracker(siteId: "22", baseURL: URL(string: "https://analytics.dev.syd.darkwing.io/matomo.php")!) // prod
    #endif
    
    let Defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Custom Functions
    
    @objc func didChangeText(textField:UITextField) {
        //        textField.text = self.modifyCreditCardString(creditCardString: textField.text!)
    }
    
    func showLoader(){
       
//        let new = NVActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: .ballSpinFadeLoader, color: #colorLiteral(red: 0.2760836482, green: 0.09022749215, blue: 0.4942057133, alpha: 1), padding: 0.0)
//        new.startAnimating()
//        NVActivityIndicatorView.startAnimating(self)
        self.startAnimating(ActivitySize.size, message: General.loadingMessage, messageFont: UIFont(name: General.fontName, size: 14), type: .ballSpinFadeLoader, color: #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1))
    }
   
    func clearDefaults(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    func setClearNavigationBar(){
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: General.fontName, size: 18)!]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0.2335646451, green: 0.2856893241, blue: 0.3274032772, alpha: 1)
    }
    
    func setImageNavigationBar(){
        
        let shadeImg = UIImage(named: "navImg.png") //Your logo url here
        
        self.navigationController!.navigationBar.setBackgroundImage(shadeImg, for: .default)
        self.navigationController!.navigationBar.shadowImage = shadeImg
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: General.fontName, size: 18)!]
        self.navigationController!.navigationBar.tintColor = UIColor.white
    }
    
    func hideNavigationBar(animated: Bool = false) {
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(animated: Bool = false) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @objc func moveBack() {
        navigationController?.popViewController(animated: true)
        dismissVC(completion: nil)
    }
    
    // set progressView
    func updateLinearProgressView(value: Float, progressView: LinearProgressView) {
        
        progressView.setProgress(value, animated: true)
    }
    
    // ============== Display Alert Message Code Below
    
    func showAlert () {
        
        var config = SwiftMessages.defaultConfig
        let view = MessageView()
        view.configureContent(title: title, body: "", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })
        SwiftMessages.show(config: config, view: view)
        
        
    }
    func showSwiftMessage(title:String, message:String, type: String){
        
        let view: MessageView
        
        view = try! SwiftMessages.viewFromNib()
        
        view.configureContent(title: title, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in SwiftMessages.hide() })
        
        view.button?.isHidden = true
        view.iconImageView?.isHidden = false
        
        let iconStyle: IconStyle
        iconStyle = .default
        
        if type == "info"{
            view.configureTheme(.info, iconStyle: iconStyle)
            view.accessibilityPrefix = "info"
            
        }else if type == "success"{
            view.configureTheme(.success, iconStyle: iconStyle)
            view.accessibilityPrefix = "success"
            
        }else if type == "warning"{
            view.configureTheme(.warning, iconStyle: iconStyle)
            view.accessibilityPrefix = "warning"
            
            
        }else if type == "error"{
            view.configureTheme(.error, iconStyle: iconStyle)
            view.accessibilityPrefix = "error"
            
        }
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        //        config.duration = .forever
        config.presentationContext = .window(windowLevel: .normal)
        config.duration = .seconds(seconds: 5)
        config.interactiveHide = true
        
        SwiftMessages.show(config: config, view: view)
        
        
    }
    
    //    func displaySuccessMessage(title:String, message:String){
    //
    //
    //        ISMessages.showCardAlert(withTitle: title, message: message, duration: 3, hideOnSwipe: true, hideOnTap: true, alertType: .success, alertPosition: .top, didHide: {(hide) in
    //
    //        })
    //    }
    //
    //    func displayFeatureMessage(){
    //        ISMessages.showCardAlert(withTitle: AlertTitle.alert, message: AlertMsg.underDevelopment, duration: 3, hideOnSwipe: true, hideOnTap: true, alertType: .info, alertPosition: .top, didHide: {(hide) in
    //
    //        })
    //    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "XXXXXXXXXXXXXXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func addPopUpView(myView: UIView, myBg: UIView) {
        
        myView.center = self.view.center
        myView.alpha = 1
        myView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        self.view.addSubview(myView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            myBg.isHidden = false
            myView.transform = .identity
        })
    }
    
    func removePopUpView(myView: UIView, myBg: UIView) {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            myView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            myBg.isHidden = true
        }) { (success) in
            myView.removeFromSuperview()
        }
    }
    
    func getPhoneNumber(countryCode:String, actualPhoneNumber:String) -> String {
        var phoneNumber:String = ""
        //        let countryCodeWithoutPlus:String = countryCode.replaceCharacterOccurance(character: "+", withCharacter: "00")
        let countryCodeWithoutPlus: String = countryCode.replacingOccurrences(of: "+", with: "00")
        phoneNumber = countryCodeWithoutPlus+actualPhoneNumber
        return phoneNumber.trim()
        //        return phoneNumber.stringByRemovingWhitespaces
    }
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    func setMobile(number:String) -> String {
        var newIs = number
        let result = String(number.prefix(1))
        
        if result == "0"{
            newIs.remove(at: newIs.startIndex)
        }
        print(newIs)
        return newIs
    }
    
    func convertDate(date:String,desireFormat:String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy HH:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = desireFormat
        
        if let date1 = dateFormatterGet.date(from: date) {
            print(dateFormatterPrint.string(from: date1))
            return dateFormatterPrint.string(from: date1)
        } else {
            
            print("There was an error decoding the string")
            return ""
        }
    }
    
    func convertPointsToFloat(val:Int) -> String {
       let new = Float(val)
        return String(format: "%.2f", new/10)
    }
    
    @objc func TopBarMenu(view:TopBarView){
        view.menu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        view.pts.text = "  "+"\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        view.rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        view.wallet.addTarget(self, action: #selector(gotoWallet), for: .touchUpInside)
    }
    @objc func TopBarBack(view:TopBarView){
        view.menu.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
        view.menu.setImage(UIImage(named: "btn_arrowBack"), for: .normal)
        view.pts.text = "  "+"\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        view.rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        view.wallet.addTarget(self, action: #selector(gotoWallet), for: .touchUpInside)
    }
    @objc func gotoWallet(sender: UIButton!){
        print("press")
        let storyboard: UIStoryboard = UIStoryboard(name: "MyWallet", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "MyWalletVC")
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    // dialouge setting
    
    func points(view:pointDialouge){
        
        view.isHidden = false
        self.view.bringSubviewToFront(view)
        
        if AppDelegate.data.receiptId != 0 {
            view.receiptView.isHidden = false
            view.normalView.isHidden = true
            view.receiptPts.text = "\(AppDelegate.data.points ?? 0)" + " pts"
            view.receiptRs.text = "R"+convertPointsToFloat(val: AppDelegate.data.points)
            view.receiptCont.addTarget(self, action: #selector(dialougeAction), for: .touchUpInside)
           
            view.stamp.text = "\(AppDelegate.data.stamp ?? 0)"
            view.resolve.text = "\(AppDelegate.data.resolve ?? 0)"
            if AppDelegate.data.resolve <= 0 {
                view.resolveView.isHidden = true
//                btnResolve.setTitle("QUERY", for: .normal)
                
            }
        }else{
            view.receiptView.isHidden = true
            view.normalView.isHidden = false
            view.pts.text = "\(AppDelegate.data.points ?? 0)" + " pts"
            view.rs.text = "R"+convertPointsToFloat(val: AppDelegate.data.points)
            view.cont.addTarget(self, action: #selector(dialougeAction), for: .touchUpInside)
        }
        
        


    }
    @objc func dialougeAction(){
        
        pointsView.isHidden = true
        AppDelegate.IsScanned = false
        AppDelegate.IsNotification = false
    }
    
    func checkNotificaion(view:pointDialouge) {
        pointsView = view
//        pointsView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedPush(notification:)), name: Notification.Name("GotPoints"), object: nil)
    }
    @objc func methodOfReceivedPush(notification: Notification) {
        points(view: pointsView)
        updatePoints1(val: AppDelegate.data.points)
        self.view.bringSubviewToFront(pointsView)
        
    }
    
    func updatePoints1(val:Int) {
        if AppDelegate.IsNotification{
        let total = (self.Shared.userInfo?.totalPoint ?? 0) + val
        self.Shared.userInfo?.totalPoint = total
        self.Shared.userInfo?.rs = getPoints.rs(point: total)
            AppDelegate.IsNotification = false
        }
//        pts.text = "\(total)"+" pts"
//        rs.text = "R"+"\(getPoints.rs(point: total))"
    }
}




