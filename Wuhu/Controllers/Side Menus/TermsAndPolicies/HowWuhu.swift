//
//  HowWuhu.swift
//  Wuhu
//
//  Created by Awais on 30/04/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import WebKit

class HowWuhu: BaseVC {
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        Applicationevents.postInfo(string: "how_wuhu_works")
        getHelp()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
    }
    
    func getHelp(){
           
           var parameters : [String: Any]
           parameters = [
               "type"              :  "how_wuhu_works"
           ]
           
           print(parameters)
           self.showLoader()
           UserHandler.getHelp(params: parameters as NSDictionary, success: { (successResponse) in
               self.stopAnimating()
               if successResponse.status == true {
//                   self.title = successResponse.data[0].title.capitalizingFirstLetter()
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
