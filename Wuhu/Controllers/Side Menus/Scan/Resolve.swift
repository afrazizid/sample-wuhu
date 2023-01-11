//
//  Resolve.swift
//  Wuhu
//
//  Created by Awais on 12/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON
import SwiftMessages
import BlinkReceipt
class Resolve: BaseVC {
    
    var imgArr = [String]()
    var alias_id: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        
        // Do any additional setup after loading the view.
    }

    func showSwiftMessag(title: String, message: String, type: String) {
             
         let view: MessageView

                view = try! SwiftMessages.viewFromNib()
                
                view.configureContent(title: title, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in SwiftMessages.hide() })
                
                view.button?.isHidden = true
                view.iconImageView?.isHidden = false
                
                let iconStyle: IconStyle
                iconStyle = .default

                if type == "info"{
                    view.configureTheme(.info, iconStyle: iconStyle)
                    view.accessibilityPrefix = "info"

                }else if type == "success"{
                    view.configureTheme(.success, iconStyle: iconStyle)
                    view.accessibilityPrefix = "success"

                }else if type == "warning"{
                    view.configureTheme(.warning, iconStyle: iconStyle)
                    view.accessibilityPrefix = "warning"

                    
                }else if type == "error"{
                    view.configureTheme(.error, iconStyle: iconStyle)
                    view.accessibilityPrefix = "error"

                }
                
                var config = SwiftMessages.Config()
                config.presentationStyle = .top
                config.duration = .forever
        config.presentationContext = .window(windowLevel: .statusBar)
                config.interactiveHide = true
           
                SwiftMessages.show(config: config, view: view)
    }
    
    func sendObserv(){
        
        var newUploadFilesArray = [AnyObject]()
        for item in imgArr.indices {
            let singleImageDict = [
                "mimetype": "image/jpeg",
                "content" : imgArr[item]
            ]
            newUploadFilesArray.append(singleImageDict as AnyObject)
        }
        let body: [String: Any] = [
            "images": newUploadFilesArray as AnyObject
        ]
        
        //        var images = [String: Any]()
        //        for i in imgArr.indices{
        //            images = [
        //                "mimetype": "image/jpeg",
        //                "content" : imgArr[i]
        //            ]
        //        }
        //
        
        
        var parameters : [String: Any]
        parameters = [
            "alias_id"              : alias_id ?? 0,
            "images":  [
                [
                    "mimetype": "image/jpeg",
                    "content": imgArr[0]
                ],
                [
                    "mimetype": "image/jpeg",
                    "content": imgArr[1]
                ]
            ]
            
            //                "images"                : body
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.sendObservation(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let resp = JSON(successResponse)
            print(resp)
            if resp["status"] == true{
                self.pushController(name: "ThankYouScreen")
                self.showSwiftMessage(title: AlertTitle.success, message: resp["message"].stringValue, type: "success")
            }else{
                self.showSwiftMessage(title: AlertTitle.error, message: resp["message"].stringValue, type: "error")
                
            }
            
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func getImageFileSize(image:UIImage) -> Int{
        let jpegData = image.jpegData(compressionQuality: 1.0)
        let jpegSize: Int = jpegData?.count ?? 0
        print("size of jpeg image in KB: %f ", Double(jpegSize) / 1024.0)
        
        return jpegSize
        
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func imageSource() {

        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            self.allowedPermision()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    DispatchQueue.main.async {
                        self.allowedPermision()
                        
                    }
                    
                } else {
                    let alertView = AlertView.failed(message: AlertMsg.permissionCamera,okAction: {
                    })
                    self.present(alertView, animated: true, completion: nil)
                }
            })
        }
    }
    
    func allowedPermision() {
        
        // call picker controller to pick an image
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        pickerController.sourceType = UIImagePickerController.SourceType.camera
        self.present(pickerController, animated: true, completion: nil)
                if imgArr.count == 0{
                    self.showSwiftMessag(title: "", message: "PHOTO 1: FRONT OF THE PRODUCT", type: "info")
                }else{
                    self.showSwiftMessag(title: "", message: "PHOTO 2: BARCODE OF THE PRODUCT", type: "info")
//                    msg = "PHOTO 2: BARCODE OF THE PRODUCT"
                }

        
    }
    
    @IBAction func actionContinue(_ sender:UIButton){
      /*  if imgArr.count == 2 {
            
            sendObserv()
        }else{
            
            imageSource()
        }*/
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomCameraVc") as! CustomCameraVc
                
        self.navigationController?.pushViewController(vc, animated: true)
//           BRScanManager.shared().startReceiptCorrection("567427C4-B1E5-425D-98D9-B5209E6CCEDD", from: self, withCustomFont: nil, withCompletion: {results,_ in
//
//                print(results!)
//            })
    }
    @IBAction func actionCancel(_ sender:UIButton){
//        AppDelegate.moveToHome()
        popVC()
    }
}
extension Resolve : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        SwiftMessages.hide()
        var pickedImage:UIImage!
        pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        pickedImage = pickedImage.resizeImage(200.0, opaque: true)
        imgArr.append(pickedImage.toBase64() ?? "nil")
        
        dismiss(animated: true, completion: nil)
        if imgArr.count == 1{
            imageSource()
            return
        }
//        sendObserv()
                self.pushController(name: "ThankYouScreen")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        SwiftMessages.hide()
    }
}
extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> UIImage? {
        let imageData = jpegData(compressionQuality: jpegQuality.rawValue)
        return UIImage(data: imageData!)!
    }
}

extension UIImage {
    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        let size = self.size
        let aspectRatio =  size.width/size.height
        
        switch contentMode {
        case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }
            
        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }
        
        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = opaque
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return newImage
    }
}
