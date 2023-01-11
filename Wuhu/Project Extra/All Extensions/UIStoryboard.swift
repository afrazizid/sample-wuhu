//
//  Array + Extension.swift
//  WATERCO
//
//  Created by Abdulqadar on 02/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import Foundation

extension UIStoryboard {
    
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
