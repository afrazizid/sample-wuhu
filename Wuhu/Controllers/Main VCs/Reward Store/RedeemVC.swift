//
//  RedeemVC.swift
//  Wuhu
//
//  Created by afrazali on 13/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import SwiftyJSON

class RedeemVC: BaseVC {
    @IBOutlet weak var imgBarCode: UIImageView!
    @IBOutlet weak var lblVoucherNmbr: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var reveal: UIButton!
    @IBOutlet weak var save: UIView!
    @IBOutlet weak var dlgView: UIView!
    @IBOutlet weak var dlgHeading: UILabel!
    @IBOutlet weak var dlgMsg: UILabel!
    @IBOutlet weak var dlgImg: UIImageView!
    @IBOutlet weak var dlgDesc: UILabel!
    
    @IBOutlet weak var dlgFb: UIView!
    @IBOutlet weak var dlgTw: UIView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var mainRs: UILabel!
    @IBOutlet weak var expiry: UILabel!
    @IBOutlet weak var hideit: UIView!
    @IBOutlet weak var codeView: UIView!
    
    @IBOutlet weak var gift: UILabel!
    @IBOutlet weak var gifttedTo: UILabel!
    
    //    var benefitId = 0
    var data: Datum!
    var type:String!
    var mobile:String!
    var isGift:Bool!
    var qRImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if data.amount > self.Shared.userInfo?.rs ?? 0 {
            dlgView.isHidden = false
            dlgHeading.text = "Oooops"
            dlgMsg.text = "You`re short on points"
            dlgImg.image = UIImage(imageLiteralResourceName: "oops")
            dlgDesc.text = "You'll need more points to buy this reward. Maybe try another one or come back after some more scanning."
        }else{
            reveal.setBtnUI()
            
            if type == "donate" {
                hideit.isHidden = false
                dlgFb.isHidden = false
                dlgTw.isHidden = false
                donate()
                
            }else{
                if isGift{
                    hideit.isHidden = false
                    claimIncentive()
                }else{
                    hideit.isHidden = true
                    setUI()
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        mainRs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarBack(view: topBar)
    }
    // MARK: - functions
    func setUI() {
//        logo.layer.cornerRadius = 32.5
//        imgBarCode.layer.cornerRadius = 62.5
        logo.isHidden = true
        let imgUrl = URL(string: data.image ?? "")
        logo.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        imgBarCode.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        heading.text = data.name
        rs.text = "R"+"\(data.amount ?? 0)"
        points.text = "\(getPoints.points(rs: data.amount))"+" pts"
        redeemIncentive()
    }
    func redeemIncentive(){
        
        var parameters : [String: Any]
        parameters = [
            "benefit_id"              : data.benefitId ?? 0,
            
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.redeemIncentive(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.qRImage = self.generateQRCode(from: successResponse.body.voucher[0].raw)
                self.lblVoucherNmbr.text = successResponse.body.voucher[0].raw
                AdobeTag.event(key: "VOUCHER REDEEMED STATUS", value: "Redeem Voucher")
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd MMM yyyy"

                if let date = dateFormatterGet.date(from: successResponse.body.voucherExpiry) {
                    print(dateFormatterPrint.string(from: date))
                     self.expiry.text = "Expire:  " + dateFormatterPrint.string(from: date)
                } else {
                   print("There was an error decoding the string")
                }
//                self.expiry.text = successResponse.body.voucherExpiry
                
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func claimIncentive(){
        
        var parameters : [String: Any]
        parameters = [
            "benefit_id"              : data.benefitId ?? 0,
            "mobile_no"    : mobile!,
            "gift"    :  isGift!
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.claimIncentive(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            
            //            self.reveal.isHidden = true
            self.putDialouge(obj: successResponse)
            if successResponse.status == true {
                AdobeTag.event(key: "VOUCHER REDEEMED STATUS", value: "Redeem Voucher")
                 self.reveal.isHidden = true
                self.codeView.isHidden = false
                self.reveal.isHidden = true
                self.save.isHidden = false
                self.logo.isHidden = false
                self.imgBarCode.image = self.qRImage
                self.imgBarCode.layer.cornerRadius = 0
                self.updatePoints(val: successResponse.totalPoints)
                
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func donate(){
        
        var parameters : [String: Any]
        parameters = [
            "donor_id"              : data.benefitId ?? 0,
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.donation(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let resp = JSON(successResponse)
            self.putDialouge(resp: resp)
            if resp["status"] == true {
                let val = resp["total_points"].intValue
                self.updatePoints(val: val)
                
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: resp["message"].stringValue, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func updatePoints(val:Int) {
        self.Shared.userInfo?.totalPoint = val
        self.Shared.userInfo?.rs = getPoints.rs(point: val)
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        mainRs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
    }
    func putDialouge(obj:ClaimIncentive) {
        dlgView.isHidden = false
        if obj.status{
            dlgHeading.text = "Thank you"
            if isGift{
              dlgMsg.text = ""
            }else{
            dlgMsg.text = obj.message
            }
            dlgImg.image = UIImage(imageLiteralResourceName: "giftReward")
            dlgDesc.text = obj.description
            if isGift {
                let main_string = "Your gift has been sent to \n\n"
//                var string_to_color = "World"

                let range = (main_string as NSString).range(of: obj.description)
                let attributedString = NSMutableAttributedString(string:main_string)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(cgColor: #colorLiteral(red: 0.2760836482, green: 0.09022749215, blue: 0.4942057133, alpha: 1)) , range: range)
//                dlgDesc.text = "Your gift has been sent to \n\n"+obj.description
               // dlgDesc.attributedText = attributedString
                gift.isHidden = false
                gifttedTo.isHidden = false
                dlgDesc.isHidden = true
                gifttedTo.text = obj.description
            }
        }else{
            dlgHeading.text = "Oooops"
            dlgMsg.text = obj.message
            dlgImg.image = UIImage(imageLiteralResourceName: "oops")
            dlgDesc.text = obj.description
        }
    }
    func putDialouge(resp:JSON) {
        dlgView.isHidden = false
        if resp["status"] == true{
            dlgHeading.text = "Thank you"
            dlgMsg.text = "for your generous donation to"
            let imgUrl = URL(string: data.image)
            dlgImg.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
            //            dlgImg.image = UIImage(imageLiteralResourceName: "giftReward")
            dlgDesc.text = ""
        }else{
            dlgHeading.text = "Oooops"
            dlgMsg.text = "You're short on points"
            let imgUrl = URL(string: data.image)
//            dlgImg.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
             dlgImg.image = UIImage(imageLiteralResourceName: "oops")
            dlgDesc.text = "You'll need more points to buy this reward. Maybe try another one or come back after some more scanning."
        }
    }
    
    // MARK: - Actions
    @IBAction func btnActionback(_ sender: UIButton) {
        self.moveBack()
    }
    @IBAction func actionclaim(_ sender: UIButton) {
        
        claimIncentive()
    }
    @IBAction func actionReveal(_ sender: UIButton) {
                 claimIncentive()
        
//        self.reveal.isHidden = true
    }
    
    @IBAction func actionsAll(_ sender: UIButton) {
        let image = imgBarCode.takeScreenshot()
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        
        
    }
    @IBAction func dlgActionContinue(_ sender: UIButton) {
        if dlgHeading.text == "Oooops"{
           self.moveBack()
        }else{
        if type == "donate" {
            self.moveBack()
        }else{
            if isGift{
                isGift = false
                self.moveBack()
            }else{
            dlgView.isHidden = true
            }
            
        }
    }
    }
}

extension UIImageView {
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}
