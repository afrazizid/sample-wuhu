//
//  Array + Extension.swift
//  WATERCO
//
//  Created by afrazali on 02/12/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    public static var initialStoryboard: UIStoryboard {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIInitialStoryboardFile") as? String else {
            return UIStoryboard()
        }
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    
    public static var mainStoryboard: UIStoryboard {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
            return UIStoryboard()
        }
        return UIStoryboard(name: name, bundle: bundle)
    }
    
//    enum AppStoryboard : String {
//
//        case Initial = "Initial"
//        case Main = "Main"
//
//        var instance : UIStoryboard {
//          return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
//        }
//    }
    
    
}
