//
//  QRDialouge.swift
//  Wuhu
//
//  Created by Awais on 20/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class QRDialouge: BaseVC {

    @IBOutlet weak var imgBarCode: UIImageView!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var hh: UILabel!
    @IBOutlet weak var mm: UILabel!
    @IBOutlet weak var ss: UILabel!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rsMain: UILabel!
//    @IBOutlet weak var close: UIButton!
    var data: VoucherData!
    var minutes = 60
    var second = 0
    var diff = 0
    var counter = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        print(data ?? "0")
        let imgUrl = URL(string: data.attachmentUrl)
        logo.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        rs.text = "R"+data.voucherAmount
        let pnt = Int(data.voucherAmount)
        points.text = "\(getPoints.points(rs: pnt ?? 0))"+" pts"
        heading.text = data.voucherName
        imgBarCode.image = self.generateQRCode(from: data.voucherCode)

        let cal = Calendar.current
        let d1 = Date()
        let d2 = data.voucherEndDate.toDate(withFormat: "dd-MM-yyyy HH:mm") // April 27, 2018 12:00:00 AM
//        let components = cal.dateComponents([.hour], from: d1, to: d2!)
//        let components2 = cal.dateComponents([.minute], from: d1, to: d2!)
//         diff = components.hour!
//        print(components2.minute!)
        
//        let date = Date()
//        let calendar = Calendar.current
//        let hour = cal.component(.hour, from: d1)
//         minutes = cal.component(.minute, from: d1)
        
        let components2: Set<Calendar.Component> = [.minute, .hour, .day]
        let difference = Calendar.current.dateComponents(components2, from: d1, to: d2!)
        print(difference)
         second = cal.component(.second, from: d1)

        hh.text = "\(difference.day ?? 0)"
        mm.text = "\(difference.hour ?? 0)"
        ss.text = "\(difference.minute ?? 0)"
        diff = difference.hour ?? 0
        counter = difference.second ?? 0
        minutes = difference.minute ?? 0
        // Do any additional setup after loading the view.
    }
    
    @objc func updateCounter() {
         //example functionality
         if counter >= 0 {
             print("\(counter) seconds to the end of the world")
//            ss.text = "\(counter)"
//             countDownLabel.text = "Resend code in 0 : "+"\(counter)"
             counter -= 1
         }else{
            minutes-=1
            ss.text = "\(minutes)"
            counter = 59
            if minutes > 0{
                
            }else{
                mm.text = "\(diff-1)"
            }
//             countDownLabel.isHidden = true
//             resend.isHidden = false
             
     }
     }
     
    override func viewWillAppear(_ animated: Bool) {
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rsMain.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarBack(view: topBar)
    }

    func computeNewDate(from fromDate: Date, to toDate: Date) -> Date{
         let delta = toDate - fromDate // `Date` - `Date` = `TimeInterval`
         let today = Date()
         if delta < 0 {
             return today
         } else {
             return today + delta // `Date` + `TimeInterval` = `Date`
         }
    }
     // MARK: - Actions
    @IBAction func btnActionback(_ sender: UIButton) {
           self.moveBack()
    }
    @IBAction func btnClose(_ sender: UIButton) {
//           self.moveBack()
        let image = imgBarCode.takeScreenshot()
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
