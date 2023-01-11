//
//  MyAccountVC.swift
//  Wuhu
//
//  Created by afrazali on 30/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class MyAccountVC: BaseVC {

    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var dlgView: pointDialouge!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNotificaion(view: dlgView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.profileImg.drawBorder(width: 4, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        self.profileImg.roundSquareImage()

        let userInfo = self.Shared.userInfo
        
        if userInfo?.user_avatar != nil {
            let fullImgPath = GlobalURL.imgPath + "\(userInfo!.user_avatar!)"
            let imgUrl = URL(string: fullImgPath)
            print(imgUrl!)
            self.profileImg.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        }
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarBack(view: topBar)
    }

    override func moveBack() {
        AppDelegate.moveToHome()
    }
    @IBAction func actionEditProfile(_ sender: Any) {
        self.pushController(name: "EditProfileVC")
    }
    @IBAction func actionMyActivity(_ sender: Any) {
//        self.pushController(name: "EditProfileVC")
        let storyboard: UIStoryboard = UIStoryboard(name: "Activity", bundle: Bundle.main)
        let activityVC = storyboard.instantiateViewController(withIdentifier: "ActivityVC")
        self.navigationController?.pushViewController(activityVC, animated: true)
//        sideMenuViewController?.contentViewController = UINavigationController(rootViewController: activityVC)
    }
    
    @IBAction func actionPreferences(_ sender: Any) {
        self.pushController(name: "PreferencesVC")
    }
    @IBAction func actionReward(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let activityVC = storyboard.instantiateViewController(withIdentifier: "RewardStoreVC") as! RewardStoreVC
//        activityVC.html = GlobalURL.quizBaseUrl+"survey-form?id="+outcome.survey_id+"&user_id="+"\(self.Shared.userInfo?.user_id ?? 0)"
        self.navigationController?.pushViewController(activityVC, animated: true)
//        self.pushController(name: "RewardStoreVC")
    }
    @IBAction func actionWallet(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "MyWallet", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyWalletVC") as! MyWalletVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnActionback(_ sender: UIButton) {
           
        AppDelegate.moveToHome()
//        self.popVC()
    }
}
