//
//  MyCustomView.swift
//  Wuhu
//
//  Created by Awais on 07/04/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

@IBDesignable
class MyCustomView: UIView {

     @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

}
