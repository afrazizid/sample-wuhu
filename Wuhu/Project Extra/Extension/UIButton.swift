//
//  Array + Extension.swift
//  WATERCO
//
//  Created by afrazali on 02/12/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import Foundation
import UIKit

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
    
    @IBInspectable override var  shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable override var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    func setBtnUI() {
        self.backgroundColor = #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1)
        self.layer.cornerRadius = 26
        self.layer.borderWidth = 1
        self.tintColor = UIColor.white
        self.layer.borderColor = #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1)
    }
    
    
}
