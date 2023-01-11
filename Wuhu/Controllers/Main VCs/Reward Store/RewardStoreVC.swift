//
//  RewardStoreVC.swift
//  Wuhu
//
//  Created by afrazali on 11/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class RewardStoreVC: BaseVC {
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    
    var comesFrom:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Applicationevents.postInfo(string: "rewards_store")
        if comesFrom == "wallet"{
            btnMenu.setImage(UIImage(imageLiteralResourceName: "btn_arrowBack"), for: .normal)
            btnMenu.addTarget(send, action: #selector(backAction), for: .touchUpInside)
        }else{
            btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
              rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        
        self.TopBarMenu(view: topBar)
        
    }
    
    
    // MARK: - IBActions
    @objc func backAction(){
        self.popVC()
        comesFrom = ""
    }
    
    @IBAction func actionFoodDrink(_ sender: Any) {
        self.pushController(name: "Food_DrinkVC")
    }
    
    @IBAction func actionGifts(_ sender: Any) {
        self.pushController(name: "GiftsVC")
    }
    
    @IBAction func actionVoucher(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "VoucherVC") as! VoucherVC
        if sender.tag == 0 {
            
            vc.type = "Treats"
            vc.image = "viucher"
            vc.desc = "Go on, you deserve it!"
            Applicationevents.postInfo(string: "reward_vouchers")
        }else if sender.tag == 1{
            vc.type = "Food & Drink"
            vc.image = "food"
            vc.desc = "Spend your hard earned bucks."
            Applicationevents.postInfo(string: "rewads_foodanddrinks")
        }else if sender.tag == 2{
            vc.type = "Essentials"
            vc.image = "gro"
            vc.desc = "Spend your points on the things you need."
            Applicationevents.postInfo(string: "get_groceries")
        }else if sender.tag == 3{
            vc.type = "donate"
            vc.image = "donate"
            vc.desc = "Donate your cashback to a good cause."
            Applicationevents.postInfo(string: "donate")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionGrocery(_ sender: Any) {
        self.pushController(name: "GroceriesVC")
    }
}
