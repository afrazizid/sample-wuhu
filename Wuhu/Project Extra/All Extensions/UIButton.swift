//
//  Array + Extension.swift
//  WATERCO
//
//  Created by Abdulqadar on 02/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import Foundation

extension UIButton {
        
    func underline() {
        if let textString = self.titleLabel?.text {
            
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    
    func setBtnUI() {
        self.backgroundColor = #colorLiteral(red: 0.001225539832, green: 0.4330366254, blue: 0.7154155374, alpha: 1)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.tintColor = UIColor.white
        self.layer.borderColor = #colorLiteral(red: 0.001225539832, green: 0.4330366254, blue: 0.7154155374, alpha: 1)
    }
}
