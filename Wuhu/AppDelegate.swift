//
//  AppDelegate.swift
//  Wuhu
//
//  Created by afrazali on 21/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import IQKeyboardManager
import UserNotifications
import ACPCore
import ACPAnalytics
import ACPTarget
import ACPUserProfile
import SwiftyJSON
import AVFoundation
//import ACPIdentity
import TrustKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window                  : UIWindow?
    var deviceToken             = ""
    var deviceId                = ""
    var IsNotification          = false
    var IsScanned               = false
    var data: Content!
    var bombSoundEffect: AVAudioPlayer?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
        print("deviceId = ",deviceId)
        let secretkey = "this is secret key"
        
        let characters = Array(secretkey)
        print("the initial characters --    \(characters)")
        var rendomAlphaString = randomAlphaNumericString(length: secretkey.count)
        let rendomhashNumber = randomNumericString()
        let constentarry = General.hashIndexArray
        print("the initial rendomAlphaString  --  \(rendomAlphaString)")
        print("the initial rendomhashNumber --    \(rendomhashNumber)")
        var i = 0
        for val in constentarry {
            if let indexvalue = constentarry.firstIndex(of: val) {
                print("the val is \(val)")
                print("the indexvalue is \(indexvalue)")
                i += 1
                let indexval = val + Int(rendomhashNumber)!
                let newString = rendomAlphaString.prefix(indexval) + "\(characters[indexvalue])" + rendomAlphaString.dropFirst(indexval+1)
                rendomAlphaString = String(newString)
            }
            
            
        }
        
        print("the rendomAlphaString ---    \(rendomAlphaString)")
        let finalString = rendomAlphaString.prefix(rendomAlphaString.count - 2) + "\(rendomhashNumber)" + rendomAlphaString.dropFirst(rendomAlphaString.count - 1)
        print("the finalString ---          \(finalString)")
        
        IQKeyboardManager.shared().isEnabled = true
        
        registerForPushNotifications()
        //        let center = UNUserNotificationCenter.current()
        //        center.delegate = self //DID NOT WORK WHEN self WAS MyOtherDelegateClass()
        //
        //        center.requestAuthorization(options: [.alert, .sound, .badge]) {
        //            (granted, error) in
        //                // Enable or disable features based on authorization.
        //                if granted {
        //                    // update application settings
        //                }
        //        }
        checkUserSession()
        
        //        ACPCore.configure(withAppId: "")
        //        ACPAnalytics.registerExtension()
        //        ACPIdentity.registerExtension()
        //        ACPCore.start(nil)
        
        ACPCore.setLogLevel(.debug)
        #if Wuhu
        ACPCore.configure(withAppId: "e6bd1902389a/7b36fbb0f3e5/launch-83be09cb248c-development")
        #elseif WuhuQA
        ACPCore.configure(withAppId: "e6bd1902389a/7b36fbb0f3e5/launch-11eb63c25443-staging")
        #elseif WuhuPROD
        ACPCore.configure(withAppId: "e6bd1902389a/7b36fbb0f3e5/launch-ba2fca251d98")
        #endif
        
        
        ACPAnalytics.registerExtension()
        ACPUserProfile.registerExtension()
        ACPIdentity.registerExtension()
        ACPLifecycle.registerExtension()
        ACPSignal.registerExtension()
        var contextData : [String: String]
        contextData = [
            "mData.appType"              : "iOS"
        ]
        ACPCore.start {
            ACPCore.lifecycleStart(contextData)
        }
        
        //        #if Wuhu
        //        baseurl = "https://wuhu.engage.dev.ire.darkwing.io/api/" // Dev
        //        #elseif WuhuQA
        //        baseurl = "https://wuhu.engage.qa.ire.soldi.io/api/" // QA
        //        #elseif WuhuPROD
        //        baseurl = "https://wuhu.engage.prod.ire.soldi.io/api/" // prod
        //        #endif
        //"wuhu.engage.dev.ire.darkwing.io"
        var relicToken = ""
        var domain = ""
        var KeyHash = ""
        #if Wuhu
        relicToken = "AA9e6d35d9e4b2bc4c442b65b1c52b7cd2c73cec56-NRMA" // Dev
        domain = "wuhu.engage.dev.ire.darkwing.io"
        KeyHash = "sha256/7pikZaPRVuapNrVoJSLxw4dNJxbBAZbnIlR3mWj3YOU="
        #elseif WuhuQA
        relicToken = "AA806b50161f2e2d0c2583776c725d8f911edf90ec-NRMA" // QA
        //        domain = "https://wuhu.engage.qa.ire.soldi.io"// qa
        //        KeyHash = "sha256/7pikZaPRVuapNrVoJSLxw4dNJxbBAZbnIlR3mWj3YOU1="
        #elseif WuhuPROD
        relicToken = "AA4fa2abbe9cd946ebef8675539922b0137b6a4df2-NRMA" // PROD
        //  domain = "https://wuhu.engage.prod.ire.soldi.io" //prod
        //  KeyHash = "sha256/7pikZaPRVuapNrVoJSLxw4dNJxbBAZbnIlR3mWj3YOU1="
        
        #endif
        NewRelic.start(withApplicationToken:relicToken)
        
        //        ADBMobile.setDebugLogging(true)
        //        var contextData : [String: Any]
        //        contextData = [
        //            "mData.appType"              : "iOS"
        //        ]
        //        ADBMobile.collectLifecycleData(withAdditionalData: contextData)
        
        
        
        
//        let trustKitConfig = [
//            kTSKEnforcePinning: true,
//            kTSKIncludeSubdomains: true,
//            kTSKSwizzleNetworkDelegates: false,
//            kTSKPinnedDomains: [
//                "wuhu.engage.dev.ire.darkwing.io": [
//                    kTSKPublicKeyHashes: ["sha256/7pikZaPRVuapNrVoJSLxw4dNJxbBAZbnIlR3mWj3YOU="
//                    ],
//                ]
//            ]
//        ] as [String : Any]
//        TrustKit.initSharedInstance(withConfiguration:trustKitConfig)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        ACPCore.lifecyclePause()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        
        let token: String = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device token is: \(token)")
        self.deviceToken = token
        //        checkUserSession()
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("i am not available in simulator \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("notification received\(userInfo)")
        
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler: @escaping (UNNotificationPresentationOptions)->()) {
        
        
        let temp:NSDictionary = notification.request.content.userInfo as NSDictionary
        print("values are = ",JSON(temp))
        let jsonVal = JSON(temp)
        let type = jsonVal["notification_content"]["content"]
        print(type)
        data = Content(fromJson: type)
        IsNotification = true
        IsScanned = true
        if data.stamp > 0{
            AdobeTag.event(key: "STAMP EARNED STATUS", value: "Earn Stamp")
        }
        if data.points > 0 || data.stamp > 0{
            NotificationCenter.default.post(name: Notification.Name("GotPoints"), object: "")
            playSound()
            AdobeTag.event(key: "EARN POINTS STATUS", value: "points earned")
            withCompletionHandler([.alert, .badge])
            
            
            /*  if IsScanned{
             
             IsScanned = false
             }else{
             self.moveToHome()
             }*/
            
        }else{
            self.moveToHome()
            withCompletionHandler([.alert, .sound, .badge])
        }
        
        
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive notification: UNNotificationResponse,
                                withCompletionHandler: @escaping ()->()) {
        print(notification.notification.request.content.userInfo)
        let actionSheet = UIAlertController(title: "Please select source", message: "Camera or Photo library", preferredStyle: UIAlertController.Style.actionSheet)
        
        // camera button
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { action -> Void in
            
        }
        
        let photoLibraryAction = UIAlertAction(title: "PhotoLibrary", style: UIAlertAction.Style.default) { action -> Void in
            
            
        }
        
        // cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        actionSheet.view.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        
        // presenting actionsheet
        //            actionSheet.show()
        withCompletionHandler()
    }
    //    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    //
    //        print("Recived: \(userInfo)")
    //       //Parsing userinfo:
    //        var temp : NSDictionary = userInfo as NSDictionary
    //    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    // MARK: - Custom Global Functions
    func playSound() {
        let path = Bundle.main.path(forResource: "money.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
    func moveToHome() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarVC")
        let side = storyboard.instantiateViewController(withIdentifier: "SideMenuVC")
        
        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: homeVC), leftMenuViewController: side)
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: true))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 20.0))
        UIApplication.shared.keyWindow?.rootViewController = sideMenu
        window?.makeKeyAndVisible()
        
    }
    func moveToScanView() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Scan", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "ScanResult") as! ScanResult
        let side = storyboard.instantiateViewController(withIdentifier: "SideMenuVC")
        
        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: homeVC), leftMenuViewController: side)
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: true))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 20.0))
        UIApplication.shared.keyWindow?.rootViewController = sideMenu
        window?.makeKeyAndVisible()
        
    }
    
    func moveToLogIn(isLogIn: Bool) {
        
        let sb = UIStoryboard(name: "Initial", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if isLogIn == true {
            vc.autoLogIn()
        }
        UIApplication.shared.keyWindow?.rootViewController = nav
    }
    
    func moveToInitial() {
        
        let sb = UIStoryboard(name: "Initial", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "InitialVC") as! InitialVC
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        UIApplication.shared.keyWindow?.rootViewController = nav
    }
    
    
    func setStatusBar() {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = .clear
        }
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                guard let self = self else { return }
                print("Permission granted: \(granted)")
                
                guard granted else { return }
                
                self.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func checkUserSession() {
        
        //        let userEmail      = UserDefaults.standard.string(forKey: KeyChainKeys.userPhone )
        //        let userPassword   = UserDefaults.standard.string(forKey: KeyChainKeys.userPassword)
        let islogin      = UserDefaults.standard.bool(forKey: KeyChainKeys.isLogedIn )
        
        if islogin == true {
            self.moveToLogIn(isLogIn: true)
        }else {
            self.moveToInitial()
        }
    }
}
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}



extension String {
    var containsSpecialCharacter: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
}


func randomAlphaNumericString(length: Int) -> String {
    let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let allowedCharsCount = UInt32(allowedChars.count)
    var randomString = ""
    
    for _ in 0 ..< length {
        let randomNum = Int(arc4random_uniform(allowedCharsCount))
        let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
        let newCharacter = allowedChars[randomIndex]
        randomString += String(newCharacter)
    }
    
    return randomString
}
func randomNumericString() -> String {
    let allowedChars = "0123456789"
    let allowedCharsCount = UInt32(allowedChars.count)
    var randomString = ""
    
    //for _ in 0 ..< length {
    let randomNum = Int(arc4random_uniform(allowedCharsCount))
    let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
    let newCharacter = allowedChars[randomIndex]
    randomString = String(newCharacter)
    // }
    
    return randomString
}
