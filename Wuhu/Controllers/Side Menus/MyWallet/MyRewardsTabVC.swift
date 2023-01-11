//
//  MyRewardsTabVC.swift
//  Wuhu
//
//  Created by Awais on 20/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import AAFragmentManager

class MyRewardsTabVC: BaseVC {
    
    @IBOutlet weak var childView: AAFragmentManager!
    @IBOutlet var btnIsuued: UIButton!
    @IBOutlet var btnExpire: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var topBar: TopBarView!
     var indx :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setTab()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        Applicationevents.postInfo(string: "my_vouchers")
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        
//        print("Value of notification : ", notification.object ?? "")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRDialouge") as! QRDialouge
        vc.data = notification.object as? VoucherData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
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
        
        
        let identifiers: [String] = ["GroceriesVC", "ExpiredVoucher"]
        let arrayVC = getViewControllers(identifiers)
        
        childView.initManager(viewControllers: arrayVC)
        
        childView.transition.type = .fade
        
        self.btnIsuued.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
        self.btnIsuued.setTitleColor(UIColor.white, for: .normal)
        
        self.btnExpire.backgroundColor = UIColor.clear
        self.btnExpire.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
        
        self.btnIsuued.layer.cornerRadius = 20
        self.btnExpire.layer.cornerRadius = 20
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
            let storyboard: UIStoryboard = UIStoryboard(name: "MyWallet", bundle: nil)
            viewControllers.append(storyboard.instantiateViewController(withIdentifier: id))
        }
        return viewControllers
    }
    @IBAction func pressedBtn(_ sender: UIButton) {
        let index = sender.tag
        self.indx = index
        print(index)
        
        childView.replace(withIndex: index)
        if index == 0 {
            
            self.btnIsuued.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnIsuued.setTitleColor(UIColor.white, for: .normal)
            
            self.btnExpire.backgroundColor = UIColor.clear
            self.btnExpire.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 1 {
            
            self.btnIsuued.backgroundColor = .clear
            self.btnIsuued.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnExpire.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnExpire.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
    
    func callBtnWithSlide(indexValue: Int){
        
        let index = indexValue
        self.indx = index
        if index == 0 {
            childView.replace(withIndex: index)
            self.btnIsuued.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnIsuued.setTitleColor(UIColor.white, for: .normal)
            
            self.btnExpire.backgroundColor = UIColor.clear
            self.btnExpire.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 1 {
            childView.replace(withIndex: index)
            self.btnIsuued.backgroundColor = .clear
            self.btnIsuued.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            self.btnExpire.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnExpire.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            
        }
    }
}
