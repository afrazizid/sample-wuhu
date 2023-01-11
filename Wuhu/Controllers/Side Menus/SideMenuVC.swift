//
//  SideMenuVC.swift
//  Wuhu
//
//  Created by afrazali on 29/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
struct ExpandableNames {
    
    var isExpanded: Bool
    let heading: String
    let names: [String]
    let icon: UIImage!
    
}
class SideMenuVC: BaseVC{
    
    var selectedImage: UIImage!
    var showIndexPaths = false
    @IBOutlet var profileImage: UIImageView!
    var twoDimensionalArray: [ExpandableNames] = []
    
    var iconArr = [UIImage(named: "my-account"),UIImage(named: "wallet1"), UIImage(named: "refer"),  UIImage(named: "extra"), UIImage(named: "promos"), UIImage(named: "help1"),UIImage(named: "help") ]
    
    
    var titleArr = ["MY PROFILE","MY WALLET","REFER A FRIEND","EXTRA DEALS", "PROMOS & COMPETITIONS", "HELP & HOW TO", "TERMS & POLICIES","QUIZ"]
    //    HELP & HOW TO
    @IBOutlet var menuTableView: UITableView!
    
    var rowExpended = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetArr()
        self.menuTableView.registerCells([SideMenuCell.self, SideMenuExpendableCell.self])
        
        self.profileImage.drawBorder(width: 4, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        self.profileImage.roundSquareImage()
        
        let userInfo = self.Shared.userInfo
        if userInfo?.user_avatar != nil {
            let fullImgPath = GlobalURL.imgPath + "\(userInfo!.user_avatar!)"
            let imgUrl = URL(string: fullImgPath)
            print(imgUrl!)
            self.profileImage.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        }
    }
    
    func resetArr() {
        twoDimensionalArray = [
            ExpandableNames(isExpanded: false, heading:"MY PROFILE", names: [],icon: UIImage(named: "my-account")),
            ExpandableNames(isExpanded: false, heading:"MY WALLET", names: [],icon: UIImage(named: "wallet1")),
            ExpandableNames(isExpanded: false, heading:"REFER A FRIEND", names: [],icon: UIImage(named: "refer")),
//            ExpandableNames(isExpanded: false, heading:"EXTRA DEALS", names: [],icon:  UIImage(named: "extra")),
            ExpandableNames(isExpanded: false, heading:"PROMOS & COMPETITIONS", names: [],icon:  UIImage(named: "promos")),
            ExpandableNames(isExpanded: false, heading:"HELP & HOW TO", names: ["How Wuhu Works","User Guides","Participating Products","Selected Retailers","FAQ","Contact Us"],icon:  UIImage(named: "help1")),
            ExpandableNames(isExpanded: false, heading:"TERMS & POLICIES", names: ["Terms of Use","Privacy Notice" ,"Cookie Notice","Accessibility"],icon:  UIImage(named: "help")),
//            ExpandableNames(isExpanded: false, heading:"QUIZ", names: [],icon:  UIImage(named: "scansearcg2")),
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.rowExpended = false
        //        var fname = self.Shared.userIno?.first_name!
        //        let lname = self.Shared.userIno?.last_name!
        //        let fulName = fname! + " " + lname!
        //        self.lblUserName.text = fulName
        //        self.lblUserEmail.text = self.Shared.userIno?.phone_number!
        //
        //        if self.Shared.userIno?.profile_image != nil{
        //            var myImgurl = self.Shared.userIno?.profile_image!
        //            self.profileImage.sd_setImage(with: URL(string: myImgurl!), placeholderImage:UIImage(named: "user_placeholder"))
        //        }
    }
    
    //MAKR:- Custom Functions
    
    
    
    
    
    //MARK: - Custom functions
    
    @IBAction func actionLogOut(_ sender: Any) {
        
        var parameters : [String: Any]
        parameters = [
            
            "device_id"   : AppDelegate.deviceId
        ]
        self.showLoader()
        UserHandler.logOutUserCall(params: parameters as NSDictionary,success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.clearDefaults()
                self.AppDelegate.moveToInitial()
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
}



extension SideMenuVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        let header = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        header.lbl.text = twoDimensionalArray[section].heading
        header.btn.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        header.btn.tag = section
        
        header.btnExpand.addTarget(self, action: #selector(ExpandClose), for: .touchUpInside)
        header.btnExpand.tag = section
        header.icon.image = twoDimensionalArray[section].icon
        if twoDimensionalArray[section].names.count>0 {
            if twoDimensionalArray[section].isExpanded {
                header.plus.image = UIImage(imageLiteralResourceName: "menumin")
            }else{
                header.plus.image = UIImage(imageLiteralResourceName: "plus")
            }
        }
        
        view.addSubview(header)
        return view
    }
    @objc func ExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        let section = button.tag
        print(section)
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices {
            //            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        //        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            menuTableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            menuTableView.insertRows(at: indexPaths, with: .fade)
        }
        if section == 5{
            if twoDimensionalArray[5].isExpanded {
                let indexPath = IndexPath(row: 0, section: 5)
                self.menuTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                
            }
        }
        if section == 6{
            if twoDimensionalArray[section].isExpanded {
                menuTableView.scrollToBottom()
            }
        }
        menuTableView.reloadData()
    }
    @objc func handleExpandClose(button: UIButton) {
        
        let section = button.tag
        //        print(section)
        //        var indexPaths = [IndexPath]()
        //        for row in twoDimensionalArray[section].names.indices {
        //            //            print(0, row)
        //            let indexPath = IndexPath(row: row, section: section)
        //            indexPaths.append(indexPath)
        //        }
        //
        //        let isExpanded = twoDimensionalArray[section].isExpanded
        //        twoDimensionalArray[section].isExpanded = !isExpanded
        //
        //        //        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        //
        //        if isExpanded {
        //            menuTableView.deleteRows(at: indexPaths, with: .fade)
        //        } else {
        //            menuTableView.insertRows(at: indexPaths, with: .fade)
        //        }
        
        switch section {
        case 0:
            
            let storyboard: UIStoryboard = UIStoryboard(name: "MyProfile", bundle: Bundle.main)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "MyAccountVC")
            //            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: profileVC)
            //            MainTabBarVC.currentInstance?.selectedIndex = 1
            (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(profileVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            sideMenuViewController?.hideMenuViewController()
            break
            
        case 1:
            let storyboard: UIStoryboard = UIStoryboard(name: "MyWallet", bundle: Bundle.main)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "MyWalletVC")
            
            (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(profileVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            sideMenuViewController?.hideMenuViewController()
            
            break
            
            
            
        case 2:
            
            let storyboard: UIStoryboard = UIStoryboard(name: "ReferAFriend", bundle: Bundle.main)
            let referFriendVC = storyboard.instantiateViewController(withIdentifier: "ReferAFriendTabVC")
            (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(referFriendVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            sideMenuViewController?.hideMenuViewController()
            
            break
//        case 3:
//
//            let storyboard: UIStoryboard = UIStoryboard(name: "ExtraDeal", bundle: Bundle.main)
//            let extraDealvc = storyboard.instantiateViewController(withIdentifier: "ExtraDealVC")
//            //            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: extraDealvc)
//            (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(extraDealvc, animated: true)
//            self.hidesBottomBarWhenPushed = false
//            sideMenuViewController?.hideMenuViewController()
//            break
            
        case 3:
            let storyboard: UIStoryboard = UIStoryboard(name: "ExtraDeal", bundle: Bundle.main)
            let extraDealvc = storyboard.instantiateViewController(withIdentifier: "PromoVc")
            //            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: extraDealvc)
            (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(extraDealvc, animated: true)
            self.hidesBottomBarWhenPushed = false
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 4:
            
            //            let storyboard: UIStoryboard = UIStoryboard(name: "Activity", bundle: Bundle.main)
            //            let activityVC = storyboard.instantiateViewController(withIdentifier: "ActivityVC")
            //            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: activityVC)
            //            self.hidesBottomBarWhenPushed = false
            //            sideMenuViewController?.hideMenuViewController()
            
            //            if twoDimensionalArray[5].isExpanded {
            //                let indexPath = IndexPath(row: 0, section: 5)
            //                self.menuTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            //
            //            }
            break
            
        case 5:
            let storyboard: UIStoryboard = UIStoryboard(name: "PoliciesAndHowTo", bundle: Bundle.main)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "TermsPolicies") as! TermsPolicies
            profileVC.myIndex = 6
            
            (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(profileVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            sideMenuViewController?.hideMenuViewController()
            
            break
        case 6:
//            let storyboard: UIStoryboard = UIStoryboard(name: "Quiz", bundle: Bundle.main)
//            let profileVC = storyboard.instantiateViewController(withIdentifier: "QuizVc")
//
//            (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(profileVC, animated: true)
//            self.hidesBottomBarWhenPushed = false
//            sideMenuViewController?.hideMenuViewController()
            
                        let storyboard: UIStoryboard = UIStoryboard(name: "Initial", bundle: Bundle.main)
                        let activityVC = storyboard.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
                        activityVC.html = "https://wuhu.engage.dev.ire.darkwing.io/survey-form?id=14&user_id="+"\(self.Shared.userInfo?.user_id ?? 0)"
                        sideMenuViewController?.contentViewController = UINavigationController(rootViewController: activityVC)
                        self.hidesBottomBarWhenPushed = false
                        sideMenuViewController?.hideMenuViewController()
            
            break
        default:
            break
        }
        menuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        
        return twoDimensionalArray[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuExpendableCell", for: indexPath) as! SideMenuExpendableCell
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.lbl.text = name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        if indexPath.section == 4{
        var name = ""
        let storyboard: UIStoryboard = UIStoryboard(name: "PoliciesAndHowTo", bundle: Bundle.main)
        if indexPath.row == 4 {
            name = "FAQ"
            
        }else if indexPath.row == 0{
            name = "HowWuhu"
        }else if indexPath.row == 1{
            name = "UserGuide"
        }else if indexPath.row == 3{
            name = "Retailers"
        }else if indexPath.row == 5{
            name = "ContactUs"
        }else if indexPath.row == 2{
            name = "ParticipatingProducts"
            ProductAll.selectedVal = 200000
        }
        print(name)
        
        let profileVC = storyboard.instantiateViewController(withIdentifier: name)
        (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(profileVC, animated: true)
        self.hidesBottomBarWhenPushed = false
        sideMenuViewController?.hideMenuViewController()
        }
        if indexPath.section == 5{
            let storyboard: UIStoryboard = UIStoryboard(name: "PoliciesAndHowTo", bundle: Bundle.main)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "TermsPolicies") as! TermsPolicies
            profileVC.myIndex = indexPath.row
            (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(profileVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            sideMenuViewController?.hideMenuViewController()
        }
    }
    
    
    
    /*  func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return iconArr.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     if indexPath.row == 6 {
     
     let expendedCell = menuTableView.dequeueReusableCell(withIdentifier: "SideMenuExpendableCell", for: indexPath) as! SideMenuExpendableCell
     
     //            expendedCell.lbl.text = titleArr[indexPath.row]
     //            expendedCell.icon.image = iconArr[indexPath.row]
     print("row = ",indexPath.row)
     if self.rowExpended == true {
     
     //                expendedCell.imgExpnd.image = UIImage(named: "cross-white")
     //                expendedCell.configContainer(isExpend: true)
     
     }else {
     //               expendedCell.imgExpnd.image = UIImage(named: "plus")
     //               expendedCell.configContainer(isExpend: false)
     }
     
     expendedCell.selectionStyle = .none
     return expendedCell
     }else {
     let menuCell = menuTableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
     menuCell.icon.image = iconArr[indexPath.row]
     menuCell.lbl.text = titleArr[indexPath.row]
     menuCell.selectionStyle = .none
     return menuCell
     }
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     switch indexPath.row {
     case 0:
     
     let storyboard: UIStoryboard = UIStoryboard(name: "MyProfile", bundle: Bundle.main)
     let profileVC = storyboard.instantiateViewController(withIdentifier: "MyAccountVC")
     sideMenuViewController?.contentViewController = UINavigationController(rootViewController: profileVC)
     self.hidesBottomBarWhenPushed = false
     sideMenuViewController?.hideMenuViewController()
     break
     
     case 1:
     
     //            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
     //            let homeVC = storyboard.instantiateViewController(withIdentifier: "BLAppoitmentVC")
     //            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
     //            sideMenuViewController?.hideMenuViewController()
     
     break
     
     
     
     case 2:
     
     let storyboard: UIStoryboard = UIStoryboard(name: "ReferAFriend", bundle: Bundle.main)
     let referFriendVC = storyboard.instantiateViewController(withIdentifier: "ReferAFriendTabVC")
     sideMenuViewController?.contentViewController = UINavigationController(rootViewController: referFriendVC)
     self.hidesBottomBarWhenPushed = false
     sideMenuViewController?.hideMenuViewController()
     
     break
     case 3:
     
     let storyboard: UIStoryboard = UIStoryboard(name: "ExtraDeal", bundle: Bundle.main)
     let extraDealvc = storyboard.instantiateViewController(withIdentifier: "ExtraDealVC")
     sideMenuViewController?.contentViewController = UINavigationController(rootViewController: extraDealvc)
     self.hidesBottomBarWhenPushed = false
     sideMenuViewController?.hideMenuViewController()
     break
     
     case 4:
     
     
     break
     
     case 5:
     
     //            let storyboard: UIStoryboard = UIStoryboard(name: "Activity", bundle: Bundle.main)
     //            let activityVC = storyboard.instantiateViewController(withIdentifier: "ActivityVC")
     //            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: activityVC)
     //            self.hidesBottomBarWhenPushed = false
     //            sideMenuViewController?.hideMenuViewController()
     break
     case 6:
     
     let index = IndexPath(item: indexPath.row, section: indexPath.section)
     if self.rowExpended == true {
     self.rowExpended = false
     menuTableView.reloadRows(at: [index], with: .automatic)
     }else{
     self.rowExpended = true
     menuTableView.reloadRows(at: [index], with: .automatic)
     }
     
     //            let indx = IndexPath(row: 6, section: 0)
     self.menuTableView.scrollToRow(at: index, at: .top, animated: true)
     break
     default:
     break
     }
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
     var rowHeight = 0.0
     if indexPath.row == 6 {
     if self.rowExpended == true {
     rowHeight = 385.0
     }else {
     rowHeight = 55.0
     }
     }else {
     rowHeight = 55.0
     }
     return CGFloat(rowHeight)
     }*/
}


