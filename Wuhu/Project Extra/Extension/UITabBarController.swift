//
//  Array + Extension.swift
//  WATERCO
//
//  Created by afrazali on 02/12/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController {
    func removeTabbarItemsText() {
        tabBar.items?.forEach {
            $0.title = ""
            $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}

extension UITabBar {

//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//    var sizeThatFits = super.sizeThatFits(size)
//    sizeThatFits.height = 60 // adjust your size here
//    return sizeThatFits
//   }
}

extension UITabBar {
    static let height: CGFloat = 60.0

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if #available(iOS 11.0, *) {
            sizeThatFits.height = UITabBar.height + window.safeAreaInsets.bottom
        } else {
            sizeThatFits.height = UITabBar.height
        }
        return sizeThatFits
    }
}

