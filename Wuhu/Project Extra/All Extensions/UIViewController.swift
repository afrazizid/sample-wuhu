//
//  Array + Extension.swift
//  WATERCO
//
//  Created by Abdulqadar on 02/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
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
//
    
    
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
        var separatedString = string.components(separatedBy: " ")
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
            
            //            let imageData = img.UIImageJPEGRepresentation(compressionQuality: 0.5)
            
            //            let imageData = img.UIImageJPEGRepresentation(compressionQuality: 0.5)!
            //            let imageData = UIImageJPEGRepresentation(img, compressionQuality)!
            
            let imageData = image.jpegData(compressionQuality: 0.5)!
            
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
    
    
}
