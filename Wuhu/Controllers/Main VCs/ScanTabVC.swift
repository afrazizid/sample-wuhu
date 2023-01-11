//
//  ScanTabVC.swift
//  Wuhu
//
//  Created by afrazali on 28/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import BlinkReceipt
import AVKit
import SwiftyJSON
import MBProgressHUD

//class ScanTabVC: BaseVC  {
//
//    @IBOutlet weak var btnMenu: UIButton!
//
//    @IBOutlet weak var qrView: UIView!
//    @IBOutlet weak var lblCount: UILabel!
//    @IBOutlet weak var countView: UIView!
//
//    var picCount = 0
//
//    var imgArr : [UIImage] = []
//    var captureSession: AVCaptureSession?
//    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
//    var capturePhotoOutput: AVCapturePhotoOutput?
//    var qrCodeFrameView: UIView?
//
//    override func loadView() {
//        super.loadView()
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.picCount = 0
//        self.imgArr = []
//        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
//
//        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
//            fatalError("No video device found")
//        }
//
//        do {
//            // Get an instance of the AVCaptureDeviceInput class using the previous deivce object
//            let input = try AVCaptureDeviceInput(device: captureDevice)
//
//            // Initialize the captureSession object
//            captureSession = AVCaptureSession()
//
//            // Set the input devcie on the capture session
//            captureSession?.addInput(input)
//
//            // Get an instance of ACCapturePhotoOutput class
//            capturePhotoOutput = AVCapturePhotoOutput()
//            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
//
//            // Set the output on the capture session
//            captureSession?.addOutput(capturePhotoOutput!)
//
//            // Initialize a AVCaptureMetadataOutput object and set it as the input device
//            let captureMetadataOutput = AVCaptureMetadataOutput()
//            captureSession?.addOutput(captureMetadataOutput)
//
//            // Set delegate and use the default dispatch queue to execute the call back
//            captureMetadataOutput.setMetadataObjectsDelegate(self as AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main)
//            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//
//            //Initialise the video preview layer and add it as a sublayer to the viewPreview view's layer
//            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//            videoPreviewLayer?.frame = view.layer.bounds
//            qrView.layer.addSublayer(videoPreviewLayer!)
//            qrView.clipsToBounds = true
//            //start video capture
//            captureSession?.startRunning()
//
//            //Initialize QR Code Frame to highlight the QR code
//            qrCodeFrameView = UIView()
//
//            if let qrCodeFrameView = qrCodeFrameView {
//                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
//                qrCodeFrameView.layer.borderWidth = 2
//                view.addSubview(qrCodeFrameView)
//                view.bringSubviewToFront(qrCodeFrameView)
//            }
//        } catch {
//            //If any error occurs, simply print it out
//            print(error)
//            return
//        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//       super.viewWillAppear(animated)
//       // Setup your camera here...
//    }
//
//    override func viewDidLayoutSubviews() {
//
//        self.decorateUI()
//    }
//
//
//    // MARK: - Custom
//
//    func decorateUI() {
//
//        self.qrView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
//        self.countView.layer.cornerRadius = self.countView.frame.size.width / 2
//    }
//
////    func sendImages()
////    {
////        if Network.isAvailable == true {
////
////            let url = GlobalURL.baseUrl+URLExtension.sendScanImgs
////            let myUrl = URL(string: url)
////            let request = NSMutableURLRequest(url:myUrl as! URL);
////            request.httpMethod = "POST";
////
////            let headers: HTTPHeaders = [
////                "Authorization"  : self.KC_!
////            ]
////
////
////            self.showLoader()
////            Alamofire.upload(
////                multipartFormData: { multipartFormData in
////                    if self.imgArr != nil && (self.imgArr.count) > 0 {
////                        for (index, obj) in (self.imgArr.enumerated()) {
////                            multipartFormData.append(self.compressImageWithAspectRatio(image: obj), withName: "image_\(index+1)", fileName: "image_\(index+1).png", mimeType: "image/png")
////                        }
////                    }else {
////                        let alertView = AlertView.failed(message: "You must have to select atleast one picture.", okAction: {
////                        })
////                        self.present(alertView, animated: true, completion: nil)
////                    }
////                    // import parameters
////                    for (key, value) in parameters {
////                        let val = value as! String
////                        multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
////                    }
////            },
////
////                usingThreshold:UInt64.init(),
////                to:URL(string: Constants.baseUrl+self.urlExtension)!,
////                method:.post,
////                headers:headers,
////                encodingCompletion: { encodingResult in
////
////                    switch encodingResult {
////                    case .success(let upload, _, _):
////                        upload.responseJSON { response in
////                            if(response.result.value != nil){
////                                self.stopAnimating()
////                                self.showSwiftMessage(title: AlertTitle.success, message: successResponse.message!, type: "success")
////
////
////                            }else{
////                                self.stopAnimating()
////                                let alert = AlertView.failed(message: "No Result Found"  , okAction: nil)
////                                self.present(alert, animated: true, completion: nil)
////                            }
////                        }
////                    case .failure(let encodingError):
////                        self.showSwiftMessage(title: AlertTitle.warning, message: encodingError!, type: "error")
////                    }
////            })
////        } else {
////            self.stopAnimating()
////            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
////        }
////    }
//
//    // MARK: - IBActions
//
//    @IBAction func actionCancel(_ sender: UIButton) {
//
//        if sender.tag == 0 {
//            self.AppDelegate.moveToHome()
//        }else {
//            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
//            }) { (success) in
//                self.AppDelegate.moveToHome()
//            }
//        }
//    }
//
//    @IBAction func actionScan(_ sender: UIButton) {
//
//        if picCount > 4 {
//            self.showSwiftMessage(title: AlertTitle.info, message: "You can't send more than 5 scan pictures.", type: "info")
//        }else{
//            guard let capturePhotoOutput = self.capturePhotoOutput else { return }
//            // Get an instance of AVCapturePhotoSettings class
//            let photoSettings = AVCapturePhotoSettings()
//            // Set photo settings for our need
//            photoSettings.isAutoStillImageStabilizationEnabled = true
//            photoSettings.isHighResolutionPhotoEnabled = true
//            photoSettings.flashMode = .off
//            // Call capturePhoto method by passing our photo settings and a delegate implementing AVCapturePhotoCaptureDelegate
//            capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
//        }
//    }
//}
//
//
//extension ScanTabVC : AVCapturePhotoCaptureDelegate {
//    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
//                 didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
//                 previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
//                 resolvedSettings: AVCaptureResolvedPhotoSettings,
//                 bracketSettings: AVCaptureBracketedStillImageSettings?,
//                 error: Error?) {
//        // Make sure we get some photo sample buffer
//        guard error == nil,
//            let photoSampleBuffer = photoSampleBuffer else {
//            print("Error capturing photo: \(String(describing: error))")
//            return
//        }
//
//        // Convert photo same buffer to a jpeg image data by using AVCapturePhotoOutput
//        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
//            return
//        }
//
//        // Initialise an UIImage with our image data
//        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
//        if let image = capturedImage {
//            // Save our captured image to photos album
//
//            self.picCount = picCount + 1
//            self.imgArr.append(image)
//            self.lblCount.text = "\(self.picCount)"
////            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        }
//    }
//}
//
//extension ScanTabVC : AVCaptureMetadataOutputObjectsDelegate {
//    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
//                       didOutput metadataObjects: [AVMetadataObject],
//                       from connection: AVCaptureConnection) {
//        // Check if the metadataObjects array is contains at least one object.
//        if metadataObjects.count == 0 {
//            qrCodeFrameView?.frame = CGRect.zero
//            return
//        }
//
//        // Get the metadata object.
//        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//
//        if metadataObj.type == AVMetadataObject.ObjectType.qr {
//            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
//            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
//            qrCodeFrameView?.frame = barCodeObject!.bounds
//
//            if metadataObj.stringValue != nil {
////                messageLabel.text = metadataObj.stringValue
//            }
//        }
//    }
//}
//
//extension UIInterfaceOrientation {
//    var videoOrientation: AVCaptureVideoOrientation? {
//        switch self {
//        case .portraitUpsideDown: return .portraitUpsideDown
//        case .landscapeRight: return .landscapeRight
//        case .landscapeLeft: return .landscapeLeft
//        case .portrait: return .portrait
//        default: return nil
//        }
//    }
//}







class ScanTabVC: BaseVC, AVCapturePhotoCaptureDelegate  {
    
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var qrView: UIView!
    @IBOutlet weak var countView: UIView!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var comesFrom:String = ""
    var hud = MBProgressHUD()
    var maxScan = false
    var isDuplicate = false
    var userInfo:UserData?
    var imgArr : [UIImage] = []
    override func loadView() {
        super.loadView()
        
        //        BRScanManager.shared().licenseKey = "sRwAAAERY29tLnVuaWxldmVyLnd1aHXN7hytxMMbkRbkdIbIdghysv5I+I4JUPVe9E79cUlK++/ZTpkNWyasf7lKpFqVQmvRJ5g6dCZGXS0wwJaij8AfE/XZ49NyszJyCPQA2HEMrveRXAvRNfnmxqrXH9mpHzU3w/ARuNbVc/TvhL+ONEtQHrhXFNEAChU9uLCY6wr2BX0JoogrVA=="
        userInfo = self.Shared.userInfo
        var mylicenseKey = ""
        
        let getKey = userInfo?.blinkData
        for i in getKey!{
            if i.name == "microblink_ios_key" {
                mylicenseKey = i.value ?? ""
            }
        }
        
        
        
        
        BRScanManager.shared().licenseKey = mylicenseKey
        
        #if Wuhu
        BRScanManager.shared().prodIntelKey = "BL2efGH/VTNxFKu9LQIJPWJURs/gH635gM1eKYA/TKY="// Dev
        #elseif WuhuQA
        BRScanManager.shared().prodIntelKey = "BL2efGH/VTNxFKu9LQIJPVqTZmxMQ+ZUQ2ZJS/PWqWw=" // QA
        #elseif WuhuPROD
        BRScanManager.shared().prodIntelKey = "BL2efGH/VTNxFKu9LQIJPVqTZmxMQ+ZUQ2ZJS/PWqWw=" // prod
        #endif
        
        let scanOptions = BRScanOptions()
        scanOptions.storeUserFrames = true
        scanOptions.countryCode = "ZA"
        scanOptions.detectDuplicates = true
        
        
        
        let cameraController = CustomCamVc()
        
        
        
        
        //        BRScanManager.shared().getResultsForReceiptCorrection("567427C4-B1E5-425D-98D9-B5209E6CCEDD", withCompletion: {result,arr in
        //
        //            let  json1 = JSON(result?.dictionaryForSerializing() as Any)
        //
        //            print(json1)
        //        })
        
        
        BRScanManager.shared().startStaticCamera(from: self, scanOptions: scanOptions, with: self)
        //        BRScanManager.shared().startCustomCamera(T##customController: BRCameraViewController##BRCameraViewController, from: <#T##UIViewController#>, scanOptions: <#T##BRScanOptions?#>, with: <#T##BRScanResultsDelegate#>)
        //        BRScanManager.shared().startCustomCamera(cameraController, from: self, scanOptions: scanOptions, with: self)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        Applicationevents.postInfo(string: "scan")
        //        imageSource()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    /* override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
     // Setup your camera here...
     captureSession = AVCaptureSession()
     captureSession.sessionPreset = .medium
     
     guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
     else {
     print("Unable to access back camera!")
     return
     }
     do {
     let input = try AVCaptureDeviceInput(device: backCamera)
     //Step 9
     stillImageOutput = AVCapturePhotoOutput()
     
     if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
     captureSession.addInput(input)
     captureSession.addOutput(stillImageOutput)
     setupLivePreview()
     }
     }
     catch let error  {
     print("Error Unable to initialize back camera:  \(error.localizedDescription)")
     }
     
     }*/
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        //Step12
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            //Step 13
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
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
        //                    if imgArr.count == 0{
        //                        self.showSwiftMessag(title: "", message: "PHOTO 1: FRONT OF THE PRODUCT", type: "info")
        //                    }else{
        //                        self.showSwiftMessag(title: "", message: "PHOTO 2: BARCODE OF THE PRODUCT", type: "info")
        //                    }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        self.decorateUI()
    }
    
    
    // MARK: - Custom
    
    func sendImages(receiptId:String)
    {
        if Network.isAvailable == true {
            
            let url = GlobalURL.baseUrl+URLExtension.sendScanImgs
            let myUrl = URL(string: url)
            let request = NSMutableURLRequest(url:myUrl!);
            request.httpMethod = "POST";
            
            var headers: HTTPHeaders
            guard let userToken = UserDefaults.standard.value(forKey: KeyChainKeys.userAuthToken) as? String else {
                
                headers = [
                    "Accept": "application/json",
                    "Content-Type" : "application/json"
                ]
                return
            }
            
            headers = [
                "Accept": "application/json",
                "Authorization" : "Bearer \(userToken)"
            ]
            
            
                        self.showLoader()
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    if self.imgArr.count > 0 {
                        //                        for (index, obj) in (self.imgArr.enumerated()) {
                        //                            multipartFormData.append(self.compressImageWithAspectRatio(image: obj), withName: "slip\(index+1)", fileName: "slip\(index+1).png", mimeType: "slip/png")
                        //                        }
                        multipartFormData.append("\(receiptId)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"receipt_id")
                        for (_, obj) in (self.imgArr.enumerated()) {
                            multipartFormData.append(self.compressImageWithAspectRatio(image: obj), withName: "slip[]", fileName: "slip.png", mimeType: "slip/png")
                        }
                        //
                        //                        for (_, value) in self.imgArr.enumerated() {
                        //                            multipartFormData.append(value.jpegData(compressionQuality: 0.5)!, withName: "slip[]", fileName: "slip", mimeType: "slip/jpeg")
                        //                        }
                    }else {
//                        let alertView = AlertView.failed(message: "You must have to select atleast one picture.", okAction: {
//                        })
//                        self.present(alertView, animated: true, completion: nil)
                    }
                    // import parameters
                    //                    for (key, value) in parameters {
                    //                        let val = value as! String
                    //                        multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                    //                    }
                },
                
                usingThreshold:UInt64.init(),
                to:URL(string: GlobalURL.baseUrl+URLExtension.sendScanImgs)!,
                method:.post,
                headers:headers,
                encodingCompletion: { encodingResult in
                    
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if(response.result.value != nil){
                                self.stopAnimating()
                                self.showSwiftMessage(title: AlertTitle.success, message: "You scanned your receipt successfully.", type: "success")
                                //                                print(response.result.value)
//                                AdobeTag.event(key: "SCANNED SLIP STATUS", value: "Scan Slip")
                                if self.comesFrom == "ScanForm"{
                                    self.dismissVC(completion: nil)
                                    let storyboard: UIStoryboard = UIStoryboard(name: "PoliciesAndHowTo", bundle: Bundle.main)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "ScanForm") as! ScanForm
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }else{
                                    
                                    self.callBack(max: false)
                                }
                            }else{
                                self.stopAnimating()
                                let alert = AlertView.failed(message: "No Result Found"  , okAction: nil)
                                self.present(alert, animated: true, completion: nil)
                                //                                self.callBack()
                            }
                        }
                    case .failure(let encodingError):
                        print(encodingResult)
                        self.showSwiftMessage(title: AlertTitle.warning, message: encodingError as! String, type: "error")
                    //                        self.callBack()
                    }
                })
        } else {
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: NetworkIndicators.internetNotAvailable, type: "error")
        }
    }
    func callBack(max:Bool) {
        self.dismissVC(completion: nil)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AfterScan") as! AfterScan
        vc.isMax = max
        self.navigationController?.pushViewController(vc, animated: true)
        /*  if  MissionInfo.missionVc{
         //            NotificationCenter.default.post(name: Notification.Name("GoToMission"), object: "")
         self.popVC()
         //            self.backTwo()
         //            self.AppDelegate.moveToHome()
         }else{
         let vc = self.storyboard!.instantiateViewController(withIdentifier: "AfterScan") as! AfterScan
         self.navigationController?.pushViewController(vc, animated: true)
         //            self.AppDelegate.moveToHome()
         }
         MissionInfo.missionVc = false*/
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    func sendImages2(){
        
        self.showLoader()
        
        
        var parameters : [String: Any]
        parameters = [
            "slip"              : self.imgArr
        ]
        
        print(parameters)
        UserHandler.sendScanImages(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                print(successResponse.status)
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    func decorateUI() {
        
        self.qrView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        self.countView.layer.cornerRadius = self.countView.frame.size.width / 2
        //        self.scanningRegion = self.qrView.bounds
    }
    
    // MARK: - IBActions
    
    @IBAction func actionCancel(_ sender: UIButton) {
        
        //        if captureImageView.isHidden {
        //            AppDelegate.moveToHome()
        //        }else{
        //            captureImageView.isHidden = true
        //        }
        
        if sender.tag == 0 {
            self.callBack(max: false)
        }else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            }) { (success) in
                self.callBack(max: false)
            }
        }
        
    }
    
    @IBAction func actionScan(_ sender: UIButton) {
        
        //        let scanOptions = BRScanOptions()
        //        scanOptions.retailerId = WFRetailerId.unknown
        //        BRScanManager.shared().startStaticCamera(from: self, scanOptions: scanOptions, with: self)
    }
    @IBAction func didTakePhoto(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
        else { return }
        
        var image = UIImage(data: imageData)
        captureImageView.isHidden = false
        captureImageView.image = image
        
        image = image!.resizeImage(200.0, opaque: true)
        self.imgArr.removeAll()
        self.imgArr.append(image!)
        
    }
    @IBAction func actionDone(_ sender: UIButton) {
        //        if captureImageView.isHidden {
        //        }else{
        //        self.showLoader()
        //         self.sendImages()
        //        }
        
    }
    /*  override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     self.captureSession.stopRunning()
     }*/
    
}

extension ScanTabVC: BRScanResultsDelegate {
    
    
    
    func didFinishScanning(_ cameraViewController: UIViewController!, with scanResults: BRScanResults!) {
        //        cameraViewController.dismiss(animated: true, completion: nil)
        //process scanResults object
        self.stopAnimating()
        let arrImg = BRScanManager.shared().userFramesFilepaths
//        let arrayOfDictionaries = [
//            "receipt_images" : arrImg
//        ]
//        let arrayOfDictionaries: [[String:AnyObject]] = [
//            ["abc":123, "def": "ggg", "xyz": true],
//            ["abc":456, "def": "hhh", "xyz": false]
//        ]
//        let gson = JSON(arrImg as Any)
        let data = JSON([
                    "receipt_images": arrImg])
        print(data)
        hud.hide(animated: true)
       
        
        //        BRScanManager.shared().startReceiptCorrection(<#T##blinkReceiptId: String##String#>, from: <#T##UIViewController#>, withCustomFont: <#T##UIFont?#>, withCompletion: <#T##((BRScanResults?, Error?) -> Void)?##((BRScanResults?, Error?) -> Void)?##(BRScanResults?, Error?) -> Void#>)
        //        print(scanResults.dictionaryForSerializing() as Any)
        
        //        let jsonEncoder = JSONEncoder()
        //        let jsonData = try jsonEncoder.encode(scanResults.dictionaryForSerializing())
        //        let json = String(data: jsonData, encoding: String.Encoding.utf16)
        
        var  json1 = JSON(scanResults.dictionaryForSerializing() as Any)
        
        do {
            try
                json1.merge(with: data)
        } catch  {
            
        }
        
        //        let jsonPro = json1["products"]
        print(json1)
        if scanResults.products.count == 0{
            self.dismissVC(completion: nil)
            
            if comesFrom == "ScanForm"{
                self.moveBack()
            }else{
                if MissionInfo.missionVc {
                    popVC()
                }else{
                    AppDelegate.moveToHome()
                }
                
            }
            self.showSwiftMessage(title: AlertTitle.warning, message: "Yikes! We can't analyse this image. Please try again if it is a valid slip.", type: "error")
            //        }else if(scanResults.isDuplicate){
            //            self.showSwiftMessage(title: AlertTitle.warning, message: "This is a duplicate receipt which has been scanned previously", type: "error")
            //            self.callBack()
        }else{
          let idR = postInfo(data:json1.description)
        
        }
        //        for i in scanResults.products.indices{
        //            print(scanResults.products[i].productDescription.value ?? "aws")
        //        }
        
        
        //        print(BRScanManager.shared().userFramesFilepaths!)
        //        print(BRScanManager.shared().userFramesFilepaths![0])
        //        print(BRScanManager.shared().description.)
        //        print(scanResults.debugDescription)
        

        
    }
    
    
    
    func didCancelScanning(_ cameraViewController: UIViewController!) {
        cameraViewController.dismiss(animated: true, completion: nil)
        if comesFrom == "ScanForm"{
            self.moveBack()
        }else{
            self.dismissVC(completion: nil)
            if MissionInfo.missionVc {
                popVC()
            }else{
                AppDelegate.moveToHome()
            }
            
            //            AppDelegate.moveToHome()
        }
        
    }
    
    // MARK: -  postInfo
    func postInfo(data:String) -> String{
        var receiptId = ""
        var parameters : [String: Any]
        parameters = [
            "slip_data"              : data,
            
        ]
        
        print(parameters)
        //        self.showLoader()
        UserHandler.receiptData(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let resp = JSON(successResponse)
            print(resp)
            if resp["status"] == true {
                receiptId = resp["receipt_id"].stringValue
                self.showSwiftMessage(title: "", message: resp["message"].stringValue, type: "success")
                //                 self.showSwiftMessage(title: AlertTitle.success, message: "You scanned your receipt successfully.", type: "success")
                //                                             print(response.result.value)
                //                self.AppDelegate.IsScanned = true
                AdobeTag.event(key: "SCANNED SLIP STATUS", value: "Scan Slip")
                if self.comesFrom == "ScanForm"{
                    self.dismissVC(completion: nil)
                    let storyboard: UIStoryboard = UIStoryboard(name: "PoliciesAndHowTo", bundle: Bundle.main)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ScanForm") as! ScanForm
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    
//
                    if BRScanManager.shared().userFramesFilepaths != nil && receiptId != ""{
                        for i in 0...BRScanManager.shared().userFramesFilepaths!.count - 1 {
                            let img = UIImage(contentsOfFile: BRScanManager.shared().userFramesFilepaths![i])
                            self.imgArr.append(img!)
                        }
                        Applicationevents.sendImages(receiptId: receiptId, imgArr: self.imgArr)
                        self.callBack(max: false)
//                        self.sendImages(receiptId: receiptId)
    //                    self.sendImages2()
                    }
                }
            }else  {
                
                if resp["max_scan"].exists(){
                    self.callBack(max: true)
                    return
                }
                self.AppDelegate.moveToHome()
                self.showSwiftMessage(title: AlertTitle.warning, message: resp["message"].stringValue, type: "error")
            }
        }) { (error) in
            self.AppDelegate.moveToHome()
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
        
        return receiptId
    }
    
    /* self.showSwiftMessage(title: AlertTitle.success, message: "You scanned your receipt successfully.", type: "success")
     //                                print(response.result.value)
     AdobeTag.event(key: "SCANNED SLIP STATUS", value: "Scan Slip")
     if self.comesFrom == "ScanForm"{
     self.dismissVC(completion: nil)
     let storyboard: UIStoryboard = UIStoryboard(name: "PoliciesAndHowTo", bundle: Bundle.main)
     let vc = storyboard.instantiateViewController(withIdentifier: "ScanForm") as! ScanForm
     self.navigationController?.pushViewController(vc, animated: true)
     }else{
     
     self.callBack()
     }*/
    
    
    //    override func userSnappedPhoto(onReady readyBlock: ((UIImage?, Bool, Bool) -> Void)!) {
    //
    //    }
    //
    //    override func userCancelledScan() {
    //
    //    }
    //    override func userFinishedScan() {
    //
    //    }
}
extension ScanTabVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //        SwiftMessages.hide()
        var pickedImage:UIImage!
        pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        pickedImage = pickedImage.resizeImage(200.0, opaque: true)
        self.imgArr.append(pickedImage)
        dismiss(animated: true, completion: nil)
        self.showLoader()
//        self.sendImages()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        //        self.callBack()
        //        self.moveBack()
        //        SwiftMessages.hide()
    }
}
extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}
