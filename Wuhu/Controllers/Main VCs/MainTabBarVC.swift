//
//  MainTabBarVC.swift
//  Wuhu
//
//  Created by afrazali on 28/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import BlinkReceipt

class MainTabBarVC: CustomTabBar {
   
    let Shared          = SharedData.SharedUserInfo
static private(set) var currentInstance: MainTabBarVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        MainTabBarVC.currentInstance = self
        self.selectedIndex = 0
        self.setupMiddleButton()
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.7294117647, green: 0.7294117647, blue: 0.7294117647, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1)
        
//        addSeparatorToTabBar()

        setupTabBarSeparators()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 10)!], for: .selected)
        
                
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        self.Shared.selectedTab = tabBarController.selectedIndex
        print( self.Shared.selectedTab)
        if self.Shared.selectedTab == 2 {
//            self.tabBar.layer.zPosition = -1
            self.tabBar.isHidden = true
        }else {
//            self.tabBar.layer.zPosition = 0
            self.tabBar.isHidden = false

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func customScanerLoader() {
        
        BRScanManager.shared().licenseKey = "sRwAAAERY29tLnVuaWxldmVyLnd1aHXN7hytxMMbkRbkdIbIdghysv5I+I4JUPVe9E79cUlK++/ZTpkNWyasf7lKpFqVQmvRJ5g6dCZGXS0wwJaij8AfE/XZ49NyszJyCPQA2HEMrveRXAvRNfnmxqrXH9mpHzU3w/ARuNbVc/TvhL+ONEtQHrhXFNEAChU9uLCY6wr2BX0JoogrVA=="
        
        let scanOptions = BRScanOptions()
        scanOptions.retailerId = WFRetailerId.unknown
        
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanTabVC") as? ScanTabVC else  {
            
            return
        }
                
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanTabVC") as? ScanTabVC
//        BRScanManager.shared().startCustomCamera(vc, from: self, scanOptions: scanOptions, with: vc.self)
        
    }
    func setupTabBarSeparators() {
        let itemWidth = floor(self.tabBar.frame.size.width / CGFloat(self.tabBar.items!.count))

        // this is the separator width.  0.5px matches the line at the top of the tab bar
        let separatorWidth: CGFloat = 0.5

        var myheight: CGFloat = 0.0
        var start: CGFloat = 0.0
        // iterate through the items in the Tab Bar, except the last one
        for i in 0...(self.tabBar.items!.count - 1) {
            // make a new separator at the end of each tab bar item
            if  i == 1 || i == 2 {
                start = self.tabBar.frame.size.height/2
                myheight = self.tabBar.frame.size.height/2
            }else{
               start = 0
               myheight = self.tabBar.frame.size.height
            }
            let separator = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1) - CGFloat(separatorWidth / 2), y: start, width: CGFloat(separatorWidth), height: myheight))

            // set the color to light gray (default line color for tab bar)
            separator.backgroundColor = UIColor.lightGray

            self.tabBar.addSubview(separator)
        }
    }
    
    
    fileprivate func addSeparatorToTabBar() {
        if let items = self.tabBarController?.tabBar.items {

            //Get the height of the tab bar

            let height = (self.tabBarController?.tabBar.bounds)!.height

            //Calculate the size of the items

            let numItems = CGFloat(items.count)
            let itemSize = CGSize(
                width: (self.tabBarController?.tabBar.frame.width)! / numItems,
                height: (self.tabBarController?.tabBar.frame.height)!)

            for (index, _) in items.enumerated() {

                //We don't want a separator on the left of the first item.

                if index > 0 {

                    //Xposition of the item

                    let xPosition = itemSize.width * CGFloat(index)

                    /* Create UI view at the Xposition,
                     with a width of 0.5 and height equal
                     to the tab bar height, and give the
                     view a background color
                     */
                    let separator = UIView(frame: CGRect(
                        x: xPosition, y: 0, width: 0.5, height: height))
                    separator.backgroundColor = UIColor.black
                    self.tabBarController?.tabBar.insertSubview(separator, at: 1)
                }
            }
        }
    }
}
