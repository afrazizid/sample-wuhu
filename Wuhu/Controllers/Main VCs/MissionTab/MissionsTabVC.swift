//
//  MissionsTabVC.swift
//  Wuhu
//
//  Created by afrazali on 28/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import AAFragmentManager

class MissionsTabVC: BaseVC {
    
    @IBOutlet weak var childView: AAFragmentManager!
    @IBOutlet var btnMission: UIButton!
    @IBOutlet var btnCompleted: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    var indx :Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTab()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("GoToMissionInfo"), object: nil)
    }
        @objc func methodOfReceivedNotification(notification: Notification) {
            
    //        print("Value of notification : ", notification.object ?? "")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MissionInfo") as! MissionInfo
            vc.outcome = notification.object as? Mission
            self.navigationController?.pushViewController(vc, animated: true)
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRDialouge") as! QRDialouge
//            vc.data = notification.object as? VoucherData
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        pts.text = "  "+"\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"

        self.TopBarMenu(view: topBar)
    }
    
    
    func setTab(){


        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
 
        
        let identifiers: [String] = ["MissionVC", "MissionCompletVC"]
        let arrayVC = getViewControllers(identifiers)
                
        childView.initManager(viewControllers: arrayVC)
        
        childView.transition.type = .fade

        self.btnMission.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
        self.btnMission.setTitleColor(UIColor.white, for: .normal)
        
        self.btnCompleted.backgroundColor = UIColor.clear
        self.btnCompleted.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
        
        self.btnMission.layer.cornerRadius = 20
        self.btnCompleted.layer.cornerRadius = 20
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizer.Direction.right:
                if self.indx > 0 {
                    childView.previous()
                    self.indx = indx - 1
                    self.callBtnWithSlide(indexValue: self.indx)
                }
                
            case UISwipeGestureRecognizer.Direction.left:
                if (self.indx < 1){
                    childView.next()
                    self.indx = indx + 1
                    print(self.indx)
                    self.callBtnWithSlide(indexValue: self.indx)
                }
            default:
                break
            }
        }
    }

    func getViewControllers(_ identifiers: [String]) -> [UIViewController] {
        var viewControllers = [UIViewController]()
        identifiers.forEach { (id) in
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            viewControllers.append(storyboard.instantiateViewController(withIdentifier: id))
        }
        return viewControllers
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnActionback(_ sender: UIButton) {
           
        AppDelegate.moveToHome()
    }
    
    @IBAction func pressedBtn(_ sender: UIButton) {
        let index = sender.tag
        self.indx = index
        print(index)
        
        childView.replace(withIndex: index)
        if index == 0 {
            
            self.btnMission.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnMission.setTitleColor(UIColor.white, for: .normal)
            
            self.btnCompleted.backgroundColor = UIColor.clear
            self.btnCompleted.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 1 {

            self.btnMission.backgroundColor = .clear
            self.btnMission.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnCompleted.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnCompleted.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
    
    func callBtnWithSlide(indexValue: Int){
        
        let index = indexValue
        self.indx = index
        if index == 0 {
            childView.replace(withIndex: index)
            self.btnMission.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnMission.setTitleColor(UIColor.white, for: .normal)
            
            self.btnCompleted.backgroundColor = UIColor.clear
            self.btnCompleted.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 1 {
            childView.replace(withIndex: index)
            self.btnMission.backgroundColor = .clear
            self.btnMission.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            self.btnCompleted.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnCompleted.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            
        }
    }
}
