//
//  ParticipatingProducts.swift
//  Wuhu
//
//  Created by Awais on 15/09/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import AAFragmentManager

class ParticipatingProducts: BaseVC {
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var childView: AAFragmentManager!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var all: UIButton!
    @IBOutlet weak var foods: UIButton!
    @IBOutlet weak var care: UIButton!
    @IBOutlet weak var personal: UIButton!
    
    var indx :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        setTab()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("productDetail"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarMenu(view: topBar)
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("Value of notification : ", notification.object ?? "")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageShowVc") as! ImageShowVc
//        vc.imgString = notification.object as! String
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetail") as! ProductDetail
        self.navigationController?.pushViewController(vc, animated: true)

    }
    // MARK: - custom functions
    
    func unselectedBtn() {
        NormalBtn(btn:all)
        NormalBtn(btn:foods)
        NormalBtn(btn:care)
        NormalBtn(btn:personal)
    }
    func NormalBtn(btn:UIButton) {
        btn.backgroundColor = UIColor.clear
        btn.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
    }
    func selectedBtn(btn:UIButton) {
        btn.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
        btn.setTitleColor(UIColor.white, for: .normal)
    }
    func setTab(){
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        let identifiers: [String] = ["ProductAll", "ProductAll","ProductAll","ProductAll"]
        let arrayVC = getViewControllers(identifiers)
        
        childView.initManager(viewControllers: arrayVC)
        
        childView.transition.type = .fade
        
        
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
                if (self.indx < 3){
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
            let storyboard: UIStoryboard = UIStoryboard(name: "PoliciesAndHowTo", bundle: nil)
            viewControllers.append(storyboard.instantiateViewController(withIdentifier: id))
        }
        return viewControllers
    }
    @IBAction func pressedBtn(_ sender: UIButton) {
        let index = sender.tag
        self.indx = index
        print(index)
        
        callBtnWithSlide(indexValue:index)
    }
    func callBtnWithSlide(indexValue: Int){
        
        let index = indexValue
        self.indx = index
        print(index)
        
        childView.replace(withIndex: index)
        unselectedBtn()
        if index == 0 {
            
            selectedBtn(btn:all)
            
        }else if index == 1 {
            selectedBtn(btn:foods)
            
        }else if index == 2 {
            selectedBtn(btn:care)
            
        }else if index == 3 {
            selectedBtn(btn:personal)
            
        }
    }
}
