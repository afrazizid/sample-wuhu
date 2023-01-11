//
//  CustomCameraVc.swift
//  Wuhu
//
//  Created by Awais on 27/01/2021.
//  Copyright © 2021 Afraz Ali. All rights reserved.
//

import UIKit
import BlinkReceipt
class CustomCameraVc: BRMissedEarningsBaseViewController {
    
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var qrView: UIView!
    @IBOutlet weak var countView: UIView!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryCode = "ZA"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didDetectBarcode(_ barcode: String) {
        print(barcode)
        self.lookupUPC(barcode) { (result, new: [AnyHashable : Any])  in
            let msg = new["message"] as! String
            print(msg)
            print(result)
            let refreshAlert = UIAlertController(title: msg, message: "", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                if msg.contains("not found"){
                    self.restartCaptureSession()
                }else{
                    self.pushController(name: "ThankYouScreen")
                }
               
                
            }))

//            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//                  print("Handle Cancel Logic here")
//            }))

            self.present(refreshAlert, animated: true, completion: nil)
            
        }
        
    }
//    override func lookupUPC(_ upc: String, withCompletion completion: @escaping (BRMissedEarningsLookupResult, [AnyHashable : Any]) -> Void) {
//
//        print(upc)
//    }
    
    // MARK: - IBActions
    
    @IBAction func actionCancel(_ sender: UIButton) {
        self.dismissVC(completion: nil)
        self.popVC()
    }
    
    @IBAction func actionScan(_ sender: UIButton) {
        
    }
    @IBAction func didTakePhoto(_ sender: UIButton) {
        self.restartCaptureSession()
    }
    
    @IBAction func actionDone(_ sender: UIButton) {
        
        
    }
    
}
