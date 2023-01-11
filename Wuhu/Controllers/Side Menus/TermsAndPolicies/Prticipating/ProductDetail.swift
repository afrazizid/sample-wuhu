//
//  ProductDetail.swift
//  Wuhu
//
//  Created by Awais on 16/09/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ProductDetail: BaseVC {
    
    @IBOutlet var dlgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionCancel(_ sender:UIButton){
        self.moveBack()
        
    }
    @IBAction func actionCancelDlg(_ sender:UIButton){
       dlgView.isHidden = true
        
    }
    @IBAction func actionContinue(_ sender:UIButton){
//        dlgView.bringSubviewToFront(self.view)
        self.view.bringSubviewToFront(dlgView)
        dlgView.isHidden = false
        
    }
    @IBAction func actionScan(_ sender:UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScanTabVC") as! ScanTabVC
        vc.comesFrom = "ScanForm"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
