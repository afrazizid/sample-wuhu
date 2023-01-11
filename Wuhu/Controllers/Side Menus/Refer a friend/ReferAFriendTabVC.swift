//
//  StoresTab.swift
//  RewCap
//
//  Created by Afraz Ali on 05/04/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import UIKit
import AAFragmentManager


class ReferAFriendTabVC: BaseVC {
    
//    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var childView: AAFragmentManager!
    @IBOutlet var btnRefer: UIButton!
    @IBOutlet var btnPastRefer: UIButton!
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    var indx :Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)

        self.setTab()
        Applicationevents.postInfo(string: "refer")
        
//        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)

        // Do any additional setup after loading the view.
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
 
        
        let identifiers: [String] = ["ReferVC", "PastReferVC"]
        let arrayVC = getViewControllers(identifiers)
                
        childView.initManager(viewControllers: arrayVC)
        
        childView.transition.type = .fade

        self.btnRefer.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
        self.btnRefer.setTitleColor(UIColor.white, for: .normal)
        
        self.btnPastRefer.backgroundColor = UIColor.clear
        self.btnPastRefer.setTitleColor(#colorLiteral(red: 0.2745098039, green: 0.1137254902, blue: 0.4862745098, alpha: 1), for: .normal)
        
        self.btnPastRefer.layer.cornerRadius = 20
        self.btnRefer.layer.cornerRadius = 20
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
            let storyboard: UIStoryboard = UIStoryboard(name: "ReferAFriend", bundle: nil)
            viewControllers.append(storyboard.instantiateViewController(withIdentifier: id))
        }
        return viewControllers
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnActionback(_ sender: UIButton) {
           
//        AppDelegate.moveToHome()
        self.popVC()
    }
    
    @IBAction func pressedBtn(_ sender: UIButton) {
        let index = sender.tag
        self.indx = index
        print(index)
        
        childView.replace(withIndex: index)
        if index == 0 {
            
            self.btnRefer.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnRefer.setTitleColor(UIColor.white, for: .normal)
            
            self.btnPastRefer.backgroundColor = UIColor.clear
//            self.btnPastRefer.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            self.btnPastRefer.setTitleColor(#colorLiteral(red: 0.2745098039, green: 0.1137254902, blue: 0.4862745098, alpha: 1), for: .normal)
            
        }else if index == 1 {

            self.btnRefer.backgroundColor = .clear
            self.btnRefer.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnPastRefer.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnPastRefer.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
    
    func callBtnWithSlide(indexValue: Int){
        
        let index = indexValue
        self.indx = index
        if index == 0 {
            childView.replace(withIndex: index)
            self.btnRefer.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnRefer.setTitleColor(UIColor.white, for: .normal)
            
            self.btnPastRefer.backgroundColor = UIColor.clear
//            self.btnPastRefer.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            self.btnPastRefer.setTitleColor(#colorLiteral(red: 0.2745098039, green: 0.1137254902, blue: 0.4862745098, alpha: 1), for: .normal)
        }else if index == 1 {
            childView.replace(withIndex: index)
            self.btnRefer.backgroundColor = .clear
            self.btnRefer.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
//            self.btnPastRefer.setTitleColor(#colorLiteral(red: 0.2745098039, green: 0.1137254902, blue: 0.4862745098, alpha: 1), for: .normal)
            self.btnPastRefer.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnPastRefer.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            
        }
    }
}
