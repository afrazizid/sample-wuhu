//
//  CustomTabBar.swift
//  Wuhu
//
//  Created by afrazali on 28/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import BlinkReceipt
class CustomTabBar: UITabBarController, UITabBarControllerDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
   }
    
    func setupMiddleButton() {

        let scanBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-38, y: -45, width: 76, height: 76))
        
        //STYLE THE BUTTON YOUR OWN WAY
//        middleBtn.setIcon(icon: .fontAwesomeSolid(.home), iconSize: 20.0, color: UIColor.white, backgroundColor: UIColor.white, forState: .normal)
//        middleBtn.applyGradient(colors: colorBlueDark.cgColor,colorBlueLight.cgColor])
        
        scanBtn.setImage(UIImage(named: "scan_menu"), for: .normal)
        
        //add to the tabbar and add click event
        self.tabBar.addSubview(scanBtn)
        scanBtn.addTarget(self, action: #selector(self.scanButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }

    // Menu Button Touch Action
    @objc func scanButtonAction(sender: UIButton) {
        
        self.selectedIndex = 2   //to select the middle tab. use "1" if you have only 3 tabs.
        self.tabBar.isHidden = true
    }
}


@IBDesignable
class MyTabBar: UITabBar {
    
    private var shapeLayer: CALayer?
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 0.2
        
        //The below 4 lines are for shadow above the bar. you can skip them if you do not want a shadow
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    func createPath() -> CGPath {
        let height: CGFloat = 38.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough

        path.addCurve(to: CGPoint(x: centerWidth, y: height),
        controlPoint1: CGPoint(x: (centerWidth - 28), y: 0), controlPoint2: CGPoint(x: centerWidth - 33, y: height))

        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
        controlPoint1: CGPoint(x: centerWidth + 33, y: height), controlPoint2: CGPoint(x: (centerWidth + 28), y: 0))

        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}
