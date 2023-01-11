//
//  ScanResult.swift
//  Wuhu
//
//  Created by Awais on 08/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ScanResult: BaseVC {
    
    @IBOutlet weak var pts:UILabel!
    @IBOutlet weak var rs:UILabel!
    @IBOutlet weak var stamp:UILabel!
    @IBOutlet weak var resolve:UILabel!
    @IBOutlet weak var resolveView:UIView!
    @IBOutlet weak var btnResolve:UIButton!
    
    var data: Content!
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.IsNotification = false
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func setUI() {
        
        //        pts.text = "\(data.notificationContent.content.points ?? 0)"+" pts"
        //        rs.text = "R"+"\(getPoints.rs(point: data.notificationContent.content.points))"
        
        
        updatePoints(val: data.points ?? 0)
        stamp.text = "\(data.stamp ?? 0)"
        resolve.text = "\(data.resolve ?? 0)"
        if data.resolve <= 0 {
            resolveView.isHidden = true
            btnResolve.setTitle("QUERY", for: .normal)
            
        }
    }
    func updatePoints(val:Int) {
        let total = (self.Shared.userInfo?.totalPoint ?? 0) + val
        self.Shared.userInfo?.totalPoint = total
        self.Shared.userInfo?.rs = getPoints.rs(point: total)
        pts.text = "\(val)"+" pts"
        rs.text = "R"+"\(getPoints.rs(point: val))"
    }
    
    
    @IBAction func actionContinue(_ sender:UIButton){
                AppDelegate.moveToHome()
    }
    @IBAction func actionResolve(_ sender:UIButton){
        //        let storyboard = UIStoryboard(name: "Scan", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "SubmittedTillSlip") as! SubmittedTillSlip
        //        (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(vc, animated: true)
        
        //        getdata()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubmittedTillSlip") as! SubmittedTillSlip
        vc.content = data
        vc.board = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
