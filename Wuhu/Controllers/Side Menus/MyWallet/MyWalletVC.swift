//
//  MyWalletVC.swift
//  Wuhu
//
//  Created by Awais on 27/04/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class MyWalletVC: BaseVC {
    
    @IBOutlet weak var btnmenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    
    @IBOutlet weak var ptsCard: UILabel!
    @IBOutlet weak var rsCard: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    var userInfo:UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnmenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        Applicationevents.postInfo(string: "my_wallet")
        userInfo = self.Shared.userInfo
        
        let concat = (userInfo?.user_first_name)! + " " + (userInfo?.user_family_name)!
        
        name.text = concat
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"

        if let date1 = dateFormatterGet.date(from: userInfo?.created_at ?? "") {
            print(dateFormatterPrint.string(from: date1))
            date.text = dateFormatterPrint.string(from: date1)
        } else {
           print("There was an error decoding the string")
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        
        ptsCard.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rsCard.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
//        self.TopBarBack(view: topBar)
        self.TopBarMenu(view: topBar)
    }
    @IBAction func actionVoucher(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "MyWallet", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "MyRewardsTabVC") as! MyRewardsTabVC
//        profileVC.type = "Vouchers"
//        profileVC.image = "viucher"
//        profileVC.desc = "Go on, you deserve it!"
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @IBAction func actionStore(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let storeVc = storyboard.instantiateViewController(withIdentifier: "RewardStoreVC") as! RewardStoreVC
        storeVc.comesFrom = "wallet"
    
        self.navigationController?.pushViewController(storeVc, animated: true)
    }
    
    @IBAction func actionBtnBack(_ sender: Any) {
        self.popVC()
    }
    @IBAction func actionMission(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let activityVC = storyboard.instantiateViewController(withIdentifier: "MissionsTabVC") as! MissionsTabVC
//        activityVC.html = GlobalURL.quizBaseUrl+"survey-form?id="+outcome.survey_id+"&user_id="+"\(self.Shared.userInfo?.user_id ?? 0)"
        self.navigationController?.pushViewController(activityVC, animated: true)
    }
    
}
