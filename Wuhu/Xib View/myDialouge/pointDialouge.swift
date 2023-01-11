//
//  pointDialouge.swift
//  Wuhu
//
//  Created by Awais on 13/01/2021.
//  Copyright © 2021 Afraz Ali. All rights reserved.
//

import UIKit

class pointDialouge: UIView {
    @IBOutlet var tabContainer: UIView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var cont: UIButton!
    
    @IBOutlet var normalView: UIView!
    @IBOutlet var receiptView: UIView!
    
    @IBOutlet weak var receiptPts:UILabel!
    @IBOutlet weak var receiptRs:UILabel!
    @IBOutlet weak var stamp:UILabel!
    @IBOutlet weak var resolve:UILabel!
    @IBOutlet weak var resolveView:UIView!
    @IBOutlet weak var receiptCont: UIButton!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commitinit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitinit()
    }
    private func commitinit(){
        Bundle.main.loadNibNamed("DialougeView", owner: self, options: nil)
        addSubview(tabContainer)
        tabContainer.frame = self.bounds
        tabContainer.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    @IBAction func actionEmail(_ sender: UIButton) {
        
//        let appURL = URL(string: "hello@wuhu.co.za")!

        let email = "hello@wuhu.co.za"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }

}
}
