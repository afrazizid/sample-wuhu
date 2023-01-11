//
//  UserGuide.swift
//  Wuhu
//
//  Created by Awais on 30/04/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import WebKit

class UserGuide: BaseVC  {
@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var html:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
  btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        // Do any additional setup after loading the view.
        Applicationevents.postInfo(string: "user_guides")
        
        html = GlobalURL.baseUrl + "get-page-info?page_name=user-guide"
        if verifyUrl(urlString: html){
            self.showLoader()
            webView.load(URLRequest(url: URL(string: html)!))
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
    }

}
extension UserGuide: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell : FaqCell = tableView.dequeueReusableCell(withIdentifier: String(describing : FaqCell.self)) as! FaqCell
        return cell
    }
    
    
}
extension UserGuide: WKUIDelegate, WKNavigationDelegate, UIWebViewDelegate{
    func webView(_ webView: WKWebView,
                     didFinish navigation: WKNavigation!){
            print("loaded")
        self.stopAnimating()
    }
}
