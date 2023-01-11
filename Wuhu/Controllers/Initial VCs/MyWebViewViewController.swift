//
//  MyWebViewViewController.swift
//  Wuhu
//
//  Created by Awais on 27/06/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class MyWebViewViewController: BaseVC, WKUIDelegate, WKNavigationDelegate, UIWebViewDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var dialougeView: UIView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var btnCont: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    var stepWebView: WKWebView!
    
    var html:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCont.setBtnUI()
        btnBack.setImage(UIImage(imageLiteralResourceName: "btn_arrowBack"), for: .normal)
        btnBack.addTarget(send, action: #selector(backAction), for: .touchUpInside)
        if verifyUrl(urlString: html){
            self.showLoader()
//            btnBack.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
            logo.isHidden = false
            webView.isHidden = true
            getConfiguredWebview()
//            webView.load(URLRequest(url: URL(string: html)!))
        }else{
            btnBack.setImage(UIImage(imageLiteralResourceName: "btn_arrowBack"), for: .normal)
            btnBack.addTarget(send, action: #selector(backAction), for: .touchUpInside)
            getHelp()
        }
        
        
        // Do any additional setup after loading the view.
    }


    private func getConfiguredWebview() -> WKWebView {
        
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
            "head.appendChild(meta);"
        
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let contentController = WKUserContentController()
        contentController.add(self, name: "MobileEvent")
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        contentController.addUserScript(script)
        self.stepWebView = WKWebView( frame: CGRect(x: 0, y: 90, width: self.view.frame.size.width, height: self.view.frame.size.height-150), configuration: config)
                stepWebView.uiDelegate = self
                stepWebView.navigationDelegate = self
        stepWebView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        stepWebView.load(URLRequest(url: URL(string: html)!))
        self.view.addSubview(self.stepWebView)
        
//        self.view.bringSubviewToFront(self.iOSInputView)
        
        
        
//        let config = WKWebViewConfiguration()
//        let js = "document.querySelectorAll('.deploy-button')[0].addEventListener('click', function(){ window.webkit.messageHandlers.clickListener.postMessage('Do something'); })"
//        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
//
//        config.userContentController.addUserScript(script)
//        config.userContentController.add(self, name: "clickListener")
//
//        let webView = WKWebView(frame: .init(x: 0, y: 70, width: self.view.frame.size.width, height: self.view.frame.size.height-70), configuration: config)
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//        self.view.addSubview(webView)
//        webView.load(URLRequest(url: URL(string: html)!))
        return stepWebView
    }
    override func viewWillAppear(_ animated: Bool) {
        self.hideNavigationBar()
    }
    @objc func backAction(){
        
//        if verifyUrl(urlString: html) {
//            AppDelegate.moveToHome()
//        }else{
            self.moveBack()
//        }
        
    }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    @IBAction func actionContinue(_ sender: UIButton){
//           self.moveBack()

//         AppDelegate.moveToHome()
        NotificationCenter.default.post(name: Notification.Name("GoToMission"), object: "")
        backTwo()
           
       }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        self.stopAnimating()
    }
    func getHelp(){
        
        var parameters : [String: Any]
        parameters = [
            "type"              : html ?? "",
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.getHelp(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.title = successResponse.data[0].title.capitalizingFirstLetter()
                let fontSize = 40
                let fontSetting = "<span style=\"font-size: \(fontSize)\"</span>"
                self.webView.loadHTMLString(fontSetting + successResponse.data[0].descriptionField, baseURL: nil)
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message:"Error", type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
        
    }
    
    
}

extension MyWebViewViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
//        let jsonVal = JSON(message.body)
        let myval:String = message.body as! String
        let array = myval.components(separatedBy: " ")
        
        let array2 = array[4].components(separatedBy: "}")
        print(array2[0])
        let myStr = array2[0].replacingOccurrences(of: " ", with: "")
        let points:Int = Int(myStr.trim()) ?? 0
//        let points = jsonVal["points"].intValue
        
        let total = (self.Shared.userInfo?.totalPoint)! + points
        self.Shared.userInfo?.totalPoint = total
        self.Shared.userInfo?.rs = getPoints.rs(point: total)
        
        pts.text = "\(points)"+" pts"
        rs.text = "R"+"\(getPoints.rs(point: points))"
        
        print(points)
        if points > 0 {
        self.view.bringSubviewToFront(dialougeView)
            dialougeView.isHidden = false
        }else{
//            AppDelegate.moveToHome()
            self.moveBack()
        }
        
//        if let data = message.body as? [String : String], let result = data["result"], let points = data["points"] {
//                    showUser(email: result, name: points)
//                }

        
    }
    private func showUser(email: String, name: String) {
           let userDescription = "\(email) \(name)"
           let alertController = UIAlertController(title: "User", message: userDescription, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default))
           present(alertController, animated: true)
       }
    
}
