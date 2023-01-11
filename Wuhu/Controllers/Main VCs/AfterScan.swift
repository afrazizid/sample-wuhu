//
//  AfterScan.swift
//  Wuhu
//
//  Created by Awais on 13/01/2021.
//  Copyright © 2021 Afraz Ali. All rights reserved.
//

import UIKit

class AfterScan: BaseVC {
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var dlgView: pointDialouge!
    @IBOutlet weak var maxDlg: UIView!
    
    var isMax:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        if isMax {
            maxDlg.isHidden = false
        }
        
        checkNotificaion(view: dlgView)
        if AppDelegate.IsScanned{
            points(view: dlgView)
            AppDelegate.IsScanned = false
        }
    }
    override func dialougeAction() {
        if  MissionInfo.missionVc{
            NotificationCenter.default.post(name: Notification.Name("GoToMission"), object: "")
            backTwo()
        }else{
            
            self.AppDelegate.moveToHome()
        }
        MissionInfo.missionVc = false
    }
    @IBAction func actionCancel(_ sender: UIButton) {
        if  MissionInfo.missionVc{
            NotificationCenter.default.post(name: Notification.Name("GoToMission"), object: "")
            backTwo()
        }else{
            
            self.AppDelegate.moveToHome()
        }
        MissionInfo.missionVc = false
    }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
    }
    @IBAction func actionContinue(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Activity", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ActivityVC") as! ActivityVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
