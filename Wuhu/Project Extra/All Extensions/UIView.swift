//
//  Array + Extension.swift
//  WATERCO
//
//  Created by Abdulqadar on 02/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import Foundation
import UIKit

var associateObjectValue: Int = 0


extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    fileprivate var isAnimate: Bool {
        get {
            return objc_getAssociatedObject(self, &associateObjectValue) as? Bool ?? false
        }
        set {
            return objc_setAssociatedObject(self, &associateObjectValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var shimmerAnimation: Bool {
        get {
            return isAnimate
        }
        set {
            self.isAnimate = newValue
        }
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
    
    func addGradiantColor(_ view: UIView, colorArray colors: [AnyHashable], cornerRadius radi: CGFloat, opacity: CGFloat, at index: UInt) {

        view.layer.cornerRadius = radi
        view.clipsToBounds = true

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds

        gradientLayer.colors = colors

        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.addSublayer(gradientLayer)
//        if index == -1 {
//            view.layer.addSublayer(gradientLayer)
//        } else {
//            view.layer.insertSublayer(gradientLayer, at: UInt32(index))
//        }
        view.layer.opacity = Float(opacity)

    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
           gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)// (x: 0.5, y: 1.0)
           gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
           gradientLayer.locations = [0, 1]
           gradientLayer.frame = bounds
           
           layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addBlackGradientLayerInForeground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    
    // For insert layer in background
    func addBlackGradientLayerInBackground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setCustomView() {
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.6705882353, blue: 0.8862745098, alpha: 1)//UIColor(red: 0, green: 153, blue: 212, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8

    }
    
    func setCustomRedView() {
        self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)//UIColor(red: 0, green: 153, blue: 212, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 8
        
    }
    
    func setView(view: UIView, hidden: Bool, style : AnimationOptions) {
        UIView.transition(with: view, duration: 0.5, options: style, animations: {
            view.isHidden = hidden
        })
    }
    
    
    func setBorderWidth(width: CGFloat) {
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = width
        self.layer.cornerRadius = 5
        
    }
    
    var roundRect: CGFloat {
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
        get{
            return layer.cornerRadius
        }
    }
    
    var invert: Bool {
        set {
            if newValue{
                self.tag = 1
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }else {
                self.tag = 0
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            }
        }
        get{
            return self.tag == 1
        }
    }
    
    func drawBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = 5
    }
    
    
    var hide: Bool {
        if self.alpha == 1 {
            hideView(withAlpha: 0)
        }else {
            hideView(withAlpha: 1)
        }
        return alpha == 0
    }
    
    private func hideView(withAlpha: CGFloat){
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = withAlpha
        }, completion: nil)
    }
    
    // Animating View
    func hideViewWithAnimation(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    
    class func instanceFromNib(nibName: String) ->UIView{
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func animationScale(with duration: Double, completion:@escaping () -> ()) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: {_ in
            completion()
        })
    }
    
    func circulateView(invert: Bool) {
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
    
//    func makeShadow() {
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowRadius = 2
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
//    }
    
//    @IBInspectable
//    var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//        }
//    }
//    var borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.borderColor = color.cgColor
//            } else {
//                layer.borderColor = nil
//            }
//        }
//    }
    
//    @IBInspectable
//    var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//        }
//    }
    
//    @IBInspectable
//    var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//
//    @IBInspectable
//    var borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.borderColor = color.cgColor
//            } else {
//                layer.borderColor = nil
//            }
//        }
//    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
//    @IBInspectable
//    var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
//    @IBInspectable
//    var shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
}
