//
//  UIColor.swift
//  WATERCO
//
//  Created by Abdulqadar on 02/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import Foundation

extension UIColor {
    
    static let navbar = UIColor(hexString: "1F2029")
    static let background = UIColor.groupTableViewBackground
    static let blueText = UIColor(hexString: "0091EA")
    static let grayText = UIColor(hexString: "737373")
    static var placeholderColr:UIColor{
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        
    }
    static var updateActiveColor:UIColor{
        return UIColor(red: 32, green: 106, blue: 143, alpha: 1)
        
    }
    static var updateDeactivateColor:UIColor{
        return UIColor(red: 141, green: 179, blue: 198, alpha: 1)
        
    }
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 115, 115, 115)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
