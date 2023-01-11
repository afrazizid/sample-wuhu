//
//  CustomCameraVc.swift
//  Wuhu
//
//  Created by Awais on 27/01/2021.
//  Copyright © 2021 Afraz Ali. All rights reserved.
//

import UIKit
import BlinkReceipt
class CustomCamVc: BRCameraViewController {
    
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var qrView: UIView!
    @IBOutlet weak var countView: UIView!
    
    @IBOutlet weak var header: UIView!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        self.view.bringSubviewToFront(countView)
        

        
    }
    
    override func viewDidLayoutSubviews() {
    
//        self.scanningRegion = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
//        self.view.bringSubviewToFront(header)

    }
    

    
    // MARK: - IBActions
    
    @IBAction func actionCancel(_ sender: UIButton) {
        
    }
    
    @IBAction func actionScan(_ sender: UIButton) {
        
    }
    @IBAction func didTakePhoto(_ sender: UIButton) {
        
    }
    
    @IBAction func actionDone(_ sender: UIButton) {
        
        
    }
    
}
