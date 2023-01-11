//
//  AlertView.swift
//  Kansai User
//
//  Created by Afraz Ali / Engr.aqadar@gmail.com on 30/1/2019.
//  Copyright © 2019 Afraz Ali / Engr.aqadar@gmail.com. All rights reserved.
//

import Foundation
import UIKit


class AlertView {
    
    class func prepare(title: String, message: String, okAction: (() -> ())?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default) { action in
            okAction?()
        }
        
        alertController.addAction(OKAction)
        
        return alertController
    }
    
    class func prepare(title: String, action1 title1: String, action2 title2: String?, message: String, actionOne: (() -> ())?, actionTwo: (() -> ())?, cancelAction: (() -> ())?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionOne = UIAlertAction(title: title1, style: .default) { action in
            actionOne?()
        }
        
        alertController.addAction(actionOne)
        
        if let _ = title2 {
            let actionTwo = UIAlertAction(title: title2, style: .cancel) { action in
                actionTwo?()
            }
            
            alertController.addAction(actionTwo)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            cancelAction?()
        }
        
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    class func success(message: String, okAction: (() -> ())?) -> UIAlertController {
        
        let alert = UIAlertController(title: "SUCCESS", message: message, preferredStyle: UIAlertController.Style.alert)
        
//        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.4549019608, blue: 0.7137254902, alpha: 1)]), forKey: "attributedTitle")
        
        alert.view.tintColor = #colorLiteral(red: 0, green: 0.4549019608, blue: 0.7137254902, alpha: 1)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            okAction?()
        }
        alert.addAction(OKAction)
        return alert
    }
    
    class func failed(message: String, okAction: (() -> ())?) -> UIAlertController {
        
        let alert = UIAlertController(title: "ALERT", message: message, preferredStyle: UIAlertController.Style.alert)
        
//        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8745098039, green: 0.07450980392, blue: 0.2078431373, alpha: 1)]), forKey: "attributedTitle")
        
        alert.view.tintColor = #colorLiteral(red: 0.8745098039, green: 0.07450980392, blue: 0.2078431373, alpha: 1)

        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            okAction?()
        }
        alert.addAction(OKAction)
        return alert
        
    }
    
    
    
}
