//
//  ThankYouScreen.swift
//  Wuhu
//
//  Created by Awais on 12/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ThankYouScreen: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func actionContinue(_ sender:UIButton){
       for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: SubmittedTillSlip.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
}
