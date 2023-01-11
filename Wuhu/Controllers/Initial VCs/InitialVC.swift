//
//  InitialVC.swift
//  Wuhu
//
//  Created by afrazali on 21/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import FSPagerView

class InitialVC: BaseVC {
    
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl!
    
    @IBOutlet weak var lblHeading: UILabel!
    
    @IBOutlet weak var lblDisc: UILabel!
   
    let imageNames = ["ic_wuhu_1.jpg","ic_wuhu_5.jpg","ic_wuhu_2.jpg","ic_wuhu_3.jpg","ic_wuhu_4.jpg"]
    let headings = ["Getting Started", "Wuhu Participating Products", "Main Menu", "Scan", "Till Slip Results", "Wuhu Product", "Reward Store",  "Missions"]
    let descriptions = ["Scan your grocery slips to earn cashback on every valid product!",
                        "An easy way to find all the products that you can get cashback on",
                        "Here’s what these buttons do",
                        "Some hints to make sure we get the best photos of your till slips",
                        "This is what you’ll see once we’ve analysed your till slip",
                        "Ilibusam estia voluptatem acescii scimusantes consectorum",
                        "Ilibusam estia voluptatem acescii scimusantes consectorum",
                        "Ilibusam estia voluptatem acescii scimusantes consectorum" ]

    var numberOfItems = 8

    override func viewDidLoad() {
        super.viewDidLoad()
//         UserDefaults.standard.set(false, forKey: "walkthrough_completed")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.setPagerTry()
        self.setPageControl()
    }
    
    override func viewDidLayoutSubviews() {
        
        view.layoutIfNeeded()
        
    }
    
    // MARK: - IBActions

    @IBAction func actionSignUp(_ sender: Any) {
        self.pushController(name: "SignUpVC1")
    }
    
    @IBAction func actionLogIn(_ sender: Any) {
//        AppDelegate.checkUserSession()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        if KC_isLogedIn == true {
//        vc.autoLogIn()
//        }
        let islogin      = UserDefaults.standard.bool(forKey: KeyChainKeys.isLogedIn )
        
        if islogin == true {
            vc.autoLogIn()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionSkip(_ sender: Any) {
        self.pushController(name: "LoginVC")
    }
    
    //MARK: - Custom
    
    func setPageControl() {
        
        pageControl.numberOfPages = self.imageNames.count
        pageControl.contentHorizontalAlignment = .fill

        pageControl.setFillColor(#colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1), for: .selected)
        pageControl.setFillColor(#colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1), for: .normal)
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 20)
//        pageControl.itemSpacing = 10
        pageControl.itemSpacing = 1.0 + CGFloat(0.48*8.0) // [6 - 16]
        
        self.pageControl.hidesForSinglePage = false
        
    }
    
    func setPager() {
        
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.isInfinite = true
        
        pagerView.transformer = FSPagerViewTransformer(type: .depth)

        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.itemSize = FSPagerView.automaticSize
        pagerView.backgroundColor = .clear
        pagerView.backgroundView?.backgroundColor = .clear
        
    }
    
    func setPagerTry() {
        
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.itemSize = FSPagerView.automaticSize
        pagerView.decelerationDistance = 1
    }
}


extension InitialVC : FSPagerViewDataSource,FSPagerViewDelegate {
    
    // MARK:- FSPagerView DataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)

        
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
//        cell.imageView?.contentMode = .
//        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.clipsToBounds = true
//        cell.imageView?.shadowOffset = CGSize()
//        cell.imageView?.shadowRadius = 0
    
        //        cell.textLabel?.text = index.description+index.description
        if index == imageNames.count-1 {
            UserDefaults.standard.set(true, forKey: "walkthrough_completed")
        }
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        //        pagerView.deselectItem(at: index, animated: true)
        //        pagerView.scrollToItem(at: index, animated: true)
//        self.pushController(name: "ResourceDetailVC")
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
//        if targetIndex == 1{
//            heightConst.constant = 0
//        }else{
//            heightConst.constant = 35
//        }
        self.pageControl.currentPage = targetIndex
        self.lblHeading.text = headings[targetIndex]
        self.lblDisc.text = descriptions[targetIndex]
        

    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }

}
