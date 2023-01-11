//
//  TermsPolicies.swift
//  Wuhu
//
//  Created by Awais on 29/04/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import WebKit
class TermsPolicies: BaseVC, WKNavigationDelegate, WKUIDelegate {
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var expandableTableView: UITableView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    var myIndex:Int!
    
    var data = [Section]()
    var arrList = [String]()
    
    var contentHeights : [CGFloat] = [0.0, 0.0]
    var listData = [HelpDatum]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self .tableViewSetup()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
//        data[1].list![0] = "<p>Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut</p>"
        // Do any additional setup after loading the view.
        Applicationevents.postInfo(string: "notices")
        getHelp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarMenu(view: topBar)
    }
    func getHelp(){
                 
                 var parameters : [String: Any]
                 parameters = [
                     ""              : "",
                 ]
                 
                 print(parameters)
                 self.showLoader()
                 UserHandler.getHelp(params: parameters as NSDictionary, success: { (successResponse) in
                     self.stopAnimating()
                     if successResponse.status == true {
                        self.listData = successResponse.data
                        self.setValues()
                     }else  {
                         self.showSwiftMessage(title: AlertTitle.warning, message:"Error", type: "error")
                     }
                 }) { (error) in
                     self.stopAnimating()
                     self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
                 }
             }
    
    func setValues() {
      
        for i in listData{
            if i.type == "terms_of_use"{
                arrList.insert(i.descriptionField, at: 0)
            }else if i.type == "privacy_notice"{
                arrList.insert(i.descriptionField, at: 1)
            }else if i.type == "cookie_notice"{
                arrList.insert(i.descriptionField, at: 2)
            }else if i.type == "accessibility"{
                arrList.insert(i.descriptionField, at: 3)
            }
        }
        data = [
               Section(title: "Terms of Use", discription: "",  list: [arrList[0]], isColleps: false),
               
               Section(title: "Privacy Notice", discription: "", list: [arrList[1]], isColleps: false),
               
               Section(title: "Cookie Notice", discription: "", list: [arrList[2]], isColleps: false),
               Section(title: "Accessibility", discription: "", list: [arrList[3]], isColleps: false)]
        if myIndex == 6{
            
        }else{
        data[myIndex].isColleps = true
        }
        expandableTableView.reloadData()
    }
    
}
extension TermsPolicies : UITableViewDelegate,UITableViewDataSource{
    
    func tableViewSetup()  {
        expandableTableView.dataSource = self
        expandableTableView.delegate = self
        expandableTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeight.Header.rawValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        let header : HeaderCell = tableView.dequeueReusableCell(withIdentifier: String(describing : HeaderCell.self)) as! HeaderCell
        
        let sectionData = data[section]
        header.lblTitle.text = sectionData.title!
        //          header.lblDisc.text = sectionData.discription
        
        ///arrow rotate
        //        header.btnExpend.transform = CGAffineTransform(rotationAngle: (sectionData.isColleps)! ? 0.0 : .pi)
        
        
        header.btnExpend.tag = section
        
        header.btnExpend.setImage(sectionData.isColleps! ? UIImage(named: "pomin") : UIImage(named: "plus-skyBlue"), for: .normal)
        header.btnExpend.addTarget(self, action: #selector(buttonHandlerSectionArrowTap(sender:)), for: .touchUpInside)
        return header.contentView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data[section].isColleps ?? false ? (data[section].list?.count ?? 0) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableCell = tableView.dequeueReusableCell(withIdentifier: String(describing : TableCell.self)) as! TableCell
        let listData = data[indexPath.section].list
//        cell.lbl.text = listData?[indexPath.row]
        let htmlString = listData?[indexPath.row]
        let htmlHeight = contentHeights[indexPath.row]

        cell.webView.tag = indexPath.row
        let fontSize = 40
        let fontSetting = "<span style=\"font-size: \(fontSize)\"</span>"
//        webView.loadHTMLString( fontSetting + myHTMLString, baseURL: nil)
        cell.webView.loadHTMLString(fontSetting + htmlString!, baseURL: nil)
        cell.webView.navigationDelegate = self
        cell.webView.uiDelegate = self
//        cell.webView.scrollView.isScrollEnabled = false
        cell.webView.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: htmlHeight)
//        cell.wkHeight.constant = cell.webView.scrollView.contentSize.height
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//           if contentHeights[indexPath.row] != 0 {
//               return contentHeights[indexPath.row]
//           }else{
//            return 10
//        }
//       }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        if (contentHeights[webView.tag] != 0.0)
//               {
//                   // we already know height, no need to reload cell
//                   return
//               }
//
//               contentHeights[webView.tag] = webView.scrollView.contentSize.height
//               expandableTableView.reloadRows(at: [IndexPath(row: webView.tag, section: myIndex)], with: .automatic)
//    }
    //Button action arrow in header
    @objc func buttonHandlerSectionArrowTap(sender : UIButton)  {
        let sectionData = data[sender.tag]
        sectionData.isColleps = !sectionData.isColleps!
        expandableTableView.reloadSections(IndexSet(integer: sender.tag), with: .automatic)
    }
    
    
}
class TableCell: UITableViewCell{
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var webView: WKWebView!
//    @IBOutlet weak var wkHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
