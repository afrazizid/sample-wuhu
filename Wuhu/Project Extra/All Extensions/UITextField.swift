//
//  UITextField.swift
//  WATERCO
//
//  Created by Abdulqadar on 02/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import Foundation

extension UITextField {
    
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
    
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        iconView.tintColor = #colorLiteral(red: 0, green: 0.4549019608, blue: 0.7137254902, alpha: 1)//UIColor(red:0.81, green:0.05, blue:0.18, alpha:1.0)
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
//    func setBorderWidthColor(borderWidth: CGFloat, color: UIColor) {
//        self.layer.borderColor = color
//        self.layer.borderWidth = borderWidth
//        self.layer.cornerRadius = 5
//    }
    
//    func setFeild() {
//        //Basic texfield Setup
//        self.borderStyle = .none
//        self.backgroundColor = UIColor.groupTableViewBackground // Use anycolor that give you a 2d look.
//
//        //To apply corner radius
//        self.layer.cornerRadius = self.frame.size.height / 2
//
//        //To apply border
//        self.layer.borderWidth = 0.25
//        self.layer.borderColor = UIColor.white.cgColor
//
//        //To apply Shadow
//        self.layer.shadowOpacity = 1
//        self.layer.shadowRadius = 3.0
//        self.layer.shadowOffset = CGSize.zero // Use any CGSize
//        self.layer.shadowColor = UIColor.gray.cgColor
//
//        //To apply padding
//        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
//        self.leftView = paddingView
//        self.leftViewMode = UITextFieldViewMode.always
//    }
    
    func setField() {
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.6705882353, blue: 0.8862745098, alpha: 1)//UIColor(red: 0, green: 153, blue: 212, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    func setRedField() {
        self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)//UIColor(red: 0, green: 153, blue: 212, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 8
    }
    
    func setColorField() {
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.6705882353, blue: 0.8862745098, alpha: 1) //UIColor(red: 0/255, green: 116/255, blue: 182/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 8
    }
}
