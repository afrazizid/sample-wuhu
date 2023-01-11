//
//  Array + Extension.swift
//  WATERCO
//
//  Created by afrazali on 02/12/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
//    func setUpDownImgIcon (_ sender: UIButton, img: UIImageView) {
//
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected {
//            UIView.animate(withDuration: 0.2) {
//                    img.image.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * -0.999))
//            }
//        }else {
//            UIView.animate(withDuration: 0.2) {
//                img.image.transform = .identity
//            }
//        }
//    }
    
    func modifyCreditCardString(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if(arrOfCharacters.count > 0) {
            for i in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
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
//    func showLoader(){
//        self.startAnimating(Constants.activitySize.size, message: Constants.loaderMessages.loadingMessage.rawValue.localized,messageFont: UIFont.systemFont(ofSize: 14), type: NVActivityIndicatorType.ballClipRotatePulse)
//    }
    
    //Tableviews height calculate to set scroll
    func adjustScrollViewHeight(scrollParentViewHeightConstraint: NSLayoutConstraint, tableView: UITableView, otherViewElementsHeight:CGFloat) {
        scrollParentViewHeightConstraint.constant = getRunTimeTableHeight(table: tableView)+otherViewElementsHeight
        tableView.isScrollEnabled = false
        tableView.reloadData()
    }
    
    func getRunTimeTableHeight(table: UITableView) -> CGFloat{
        table.layoutIfNeeded()
        return table.contentSize.height
    }
    
//    open func pushVC(_ vc: UIViewController) {
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
//    open func pushVC(storyBoard : UIStoryboard, vcIdentifier : String) {
//
//        let myStoryBoard = storyBoard
//        let viewPush = myStoryBoard.instantiateViewController(withIdentifier: vcIdentifier)
//        self.navigationController?.pushViewController(viewPush, animated: true)
//    }
//
    func pushController(name : String) {
        print(name)
        let viewPush = self.storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(viewPush!, animated: true)
    }
    
//    func pushController(sName : String, iName: String) {
//
//        let storyboard = UIStoryboard(name: sName, bundle: nil)
//        let viewPush = storyboard.instantiateViewController(withIdentifier: iName)
//        self.navigationController?.pushViewController(viewPush, animated: true)
//    }

    
    
    open func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    open func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    open func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    open func dismissVC(completion: (() -> Void)? ) {
        dismiss(animated: true, completion: completion)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    func myDateFormater(date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        
        print(date)
        let mydate = dateFormatterGet.date(from: date)
        print(dateFormatterPrint.string(from: mydate!))
        return dateFormatterPrint.string(from: mydate!)
        
    }

    
    func timeFormate(unixTime: Int) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date as Date)
    }
    
    func setUpView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.8, options: .transitionFlipFromBottom, animations: {
            view.isHidden = hidden
        })
    }
    
    func setDownView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.8, options: .transitionFlipFromTop, animations: {
            view.isHidden = hidden
        })
    }
    
    func setPopUpView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCurlUp, animations: {
            view.isHidden = hidden
        })
    }
    
    
    func compressImageWithAspectRatio (image: UIImage) -> Data {

        let data = image.jpegData(compressionQuality: 0.5)
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(data!.count))
        print("Data size is: \(string)")
        print(image.size.height)
        print(image.size.width)

        let separatedString = string.components(separatedBy: " ")
        print(separatedString)
        let dataLenth = separatedString[0]
        //let removedComma = dataLenth.stringByReplacingOccurrencesOfString(",", withString: "")
        let removedComma = dataLenth.replacingOccurrences(of: ",", with: "")
        print(Int(removedComma)!)
        
        if(Int(removedComma)! > 200 ){
            let actualHeight:CGFloat = image.size.height
            let actualWidth:CGFloat = image.size.width
            
            let imgRatio:CGFloat = actualWidth/actualHeight
            let maxWidth:CGFloat = 1440.0
            let resizedHeight:CGFloat = maxWidth/imgRatio
            let compressionQuality:CGFloat = 0.5
            
            let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
            UIGraphicsBeginImageContext(rect.size)
            //image.drawInRect(rect)
            image.draw(in: rect)
            let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            let imageData = image.jpegData(compressionQuality: compressionQuality)!
            
            UIGraphicsEndImageContext()
            print("Data size is: \(imageData.count)")
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
            bcf.countStyle = .file
            let string = bcf.string(fromByteCount: Int64(imageData.count))
            print("Data size is: \(string)")
            return imageData
            
        } else{
            return data!
        }
        //return UIImage(data: imageData)!
    }
    
    func addDatePicker(mode: UIDatePicker.Mode, date: Date?, minimumDate: Date? = nil, maximumDate: Date? = nil, action: DatePickerViewController.Action?) {
        let datePicker = DatePickerViewController(mode: mode, date: date, minimumDate: minimumDate, maximumDate: maximumDate, action: action)
//        set(vc: datePicker, height: 217)
        
//        guard let vc = vc else { return }
        setValue(datePicker, forKey: "contentViewController")
        datePicker.preferredContentSize.height = 220
        preferredContentSize.height = 220
    }
}


final class DatePickerViewController: UIViewController {
    
    public typealias Action = (Date) -> Void
    
    fileprivate var action: Action?
    
    fileprivate lazy var datePicker: UIDatePicker = { [unowned self] in
        $0.addTarget(self, action: #selector(DatePickerViewController.actionForDatePicker), for: .valueChanged)
        return $0
    }(UIDatePicker())
    
    required init(mode: UIDatePicker.Mode, date: Date? = nil, minimumDate: Date? = nil, maximumDate: Date? = nil, action: Action?) {
        super.init(nibName: nil, bundle: nil)
        datePicker.datePickerMode = mode
        datePicker.date = date ?? Date()
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        self.action = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Log("has deinitialized")
    }
    
    override func loadView() {
        view = datePicker
    }
    
    @objc func actionForDatePicker() {
        action?(datePicker.date)
    }
    
    public func setDate(_ date: Date) {
        datePicker.setDate(date, animated: true)
    }
}


public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        guard let object = object else { return }
        print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
    #endif
}


extension UIAlertController {
    
    /// Create new alert view controller.
    ///
    /// - Parameters:
    ///   - style: alert controller's style.
    ///   - title: alert controller's title.
    ///   - message: alert controller's message (default is nil).
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: alert controller's tint color (default is nil)
    convenience init(style: UIAlertController.Style, source: UIView? = nil, title: String? = nil, message: String? = nil, tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: style)
        
        // TODO: for iPad or other views
        let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
        let root = UIApplication.shared.keyWindow?.rootViewController?.view
        
        //self.responds(to: #selector(getter: popoverPresentationController))
        if let source = source {
            Log("----- source")
            popoverPresentationController?.sourceView = source
            popoverPresentationController?.sourceRect = source.bounds
        } else if isPad, let source = root, style == .actionSheet {
            Log("----- is pad")
            popoverPresentationController?.sourceView = source
            popoverPresentationController?.sourceRect = CGRect(x: source.bounds.midX, y: source.bounds.midY, width: 0, height: 0)
            //popoverPresentationController?.permittedArrowDirections = .down
            popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
        }
        
        if let color = tintColor {
            self.view.tintColor = color
        }
    }
}


// MARK: - Methods
extension UIAlertController {
    
    /// Present alert view controller in the current view controller.
    ///
    /// - Parameters:
    ///   - animated: set true to animate presentation of alert controller (default is true).
    ///   - vibrate: set true to vibrate the device while presenting the alert (default is false).
    ///   - completion: an optional completion handler to be called after presenting alert controller (default is nil).
    public func show(animated: Bool = true, vibrate: Bool = false, style: UIBlurEffect.Style? = nil, completion: (() -> Void)? = nil) {
        
        /// TODO: change UIBlurEffectStyle
        if let style = style {
            for subview in view.allSubViewsOf(type: UIVisualEffectView.self) {
                subview.effect = UIBlurEffect(style: style)
            }
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
            if vibrate {
//                AudioServicesPlayAlertSound(nil)
            }
        }
    }
    
    /// Add an action to Alert
    ///
    /// - Parameters:
    ///   - title: action title
    ///   - style: action style (default is UIAlertActionStyle.default)
    ///   - isEnabled: isEnabled status for action (default is true)
    ///   - handler: optional action handler to be called when button is tapped (default is nil)
    func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        //let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
        //let action = UIAlertAction(title: title, style: isPad && style == .cancel ? .default : style, handler: handler)
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        
        // button image
        if let image = image {
            action.setValue(image, forKey: "image")
        }
        
        // button title color
        if let color = color {
            action.setValue(color, forKey: "titleTextColor")
        }
        
        addAction(action)
    }
    
    /// Set alert's title, font and color
    ///
    /// - Parameters:
    ///   - title: alert title
    ///   - font: alert title font
    ///   - color: alert title color
    func set(title: String?, font: UIFont, color: UIColor) {
        if title != nil {
            self.title = title
        }
        setTitle(font: font, color: color)
    }
    
    func setTitle(font: UIFont, color: UIColor) {
        guard let title = self.title else { return }
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let attributedTitle = NSMutableAttributedString(string: title, attributes: attributes)
        setValue(attributedTitle, forKey: "attributedTitle")
    }
    
    /// Set alert's message, font and color
    ///
    /// - Parameters:
    ///   - message: alert message
    ///   - font: alert message font
    ///   - color: alert message color
    func set(message: String?, font: UIFont, color: UIColor) {
        if message != nil {
            self.message = message
        }
        setMessage(font: font, color: color)
    }
    
    func setMessage(font: UIFont, color: UIColor) {
        guard let message = self.message else { return }
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let attributedMessage = NSMutableAttributedString(string: message, attributes: attributes)
        setValue(attributedMessage, forKey: "attributedMessage")
    }
    
    /// Set alert's content viewController
    ///
    /// - Parameters:
    ///   - vc: ViewController
    ///   - height: height of content viewController
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
}
