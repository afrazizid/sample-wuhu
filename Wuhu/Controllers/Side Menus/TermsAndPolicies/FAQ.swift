//
//  FAQ.swift
//  Wuhu
//
//  Created by Awais on 30/04/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import SwiftyJSON

class FAQ: BaseVC {
    @IBOutlet weak var expandableTableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var ScrollHeight: NSLayoutConstraint!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    var indexArr = [200,201]
   static var indexlikeArr = [200,201]
   static var indexDislikeArr = [200,201]
    var isCalled:Bool!
    
    var isCheck:Bool!
    
    var data = [FaqCatDatum]()
    var faqs = [FAQsDatum]()
    
    var catId = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        isCalled = false
        isCheck = false
        Applicationevents.postInfo(string: "faq")
        getFaqCat()
        expandableTableView.isScrollEnabled = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarMenu(view: topBar)
        self.expandableTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.expandableTableView.removeObserver(self, forKeyPath: "contentSize")
        super.viewWillDisappear(true)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            
            if let newvalue = change?[.newKey]{
                let newsize  = newvalue as! CGSize
                self.tableHeight.constant = newsize.height  + 100
            }
        }
    }
    func getFaqCat(){
        self.showLoader()
        UserHandler.getFaqCat(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.isCalled = true
                self.data = successResponse.data
                for i in self.data{
                    if i.name == "General"{
                        self.catId = i.id
                    }
                }
                self.getFAQs()
                
                self.expandableTableView.reloadData()
                
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func getFAQs(){
        
        var parameters : [String: Any]
        parameters = [
            "category_id"              : catId,
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.getFAQs(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.faqs = successResponse.data
                self.indexArr.removeAll()
                self.indexArr.append(200)
                self.indexArr.append(201)
                self.expandableTableView.reloadData()
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    // MARK: -  functions
    func postInfo(id:String,action:Bool){
        
        var parameters : [String: Any]
        parameters = [
            "feedback_id"              : id,
            "feed_back"                : action
            
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.postFaq(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let resp = JSON(successResponse)
            if resp["status"] == true {
                if action{
                    
                }else{
                    self.showSwiftMessage(title: AlertTitle.info, message: "Sorry this is not the answer you need. Reach out to us for help.", type: "info")
                }
                self.expandableTableView.reloadData()
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: resp["message"].stringValue, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    @IBAction func actionCat(_ sender: UIButton){
        if isCalled {
            
            if sender.tag == 0{
                for i in data{
                    if i.name == "General"{
                        catId = i.id
                    }
                }
            }else if sender.tag == 1{
                for i in data{
                    if i.name == "Till Slips"{
                        catId = i.id
                    }
                }
            }else if sender.tag == 2{
                for i in data{
                    if i.name == "Points & Cashback"{
                        catId = i.id
                    }
                }
            }else if sender.tag == 3{
                for i in data{
                    if i.name == "Missions & Stampcards"{
                        catId = i.id
                    }
                }
            }else if sender.tag == 4{
                for i in data{
                    if i.name == "Promos & Competitions"{
                        catId = i.id
                    }
                }
            }else if sender.tag == 5{
                for i in data{
                    if i.name == "Account"{
                        catId = i.id
                    }
                }
            }
            
            isCheck = true
            getFAQs()
        }else{
            
        }
    }
}




extension FAQ:UITableViewDelegate,UITableViewDataSource{
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 2
    //    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if section == 0 {
        return faqs.count
        //        }else{
        //            return 1
        //        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        if indexPath.section == 0 {
        //        tableHeight.constant = expandableTableView.contentSize.height+60
        //        expandableTableView.layoutIfNeeded()
        //        expandableTableView.reloadData()
        
        let cell : FaqCell = tableView.dequeueReusableCell(withIdentifier: String(describing : FaqCell.self)) as! FaqCell
        var pre = "0"
        if indexPath.row+1 > 9{
            pre = ""
        }
        cell.lblCount.text = pre+"\(indexPath.row+1)"
        cell.lblQuestion.text = "\(faqs[indexPath.row].title ?? "")"
        cell.lblAns.setHTMLFromString(htmlText: faqs[indexPath.row].descriptionField)
        //        let htmlTextWithStyle = faqs[indexPath.row].descriptionField + ("<style>body{font-family: '\(UIFont.systemFont(ofSize: 14.0))'; font-size:\(14.0);}</style>")
        //        cell.lblAns.text = faqs[indexPath.row].descriptionField
        //        cell.lblAns.attributedText = faqs[indexPath.row].descriptionField.attributedHtmlString
        cell.btnDrop.addTarget(self, action: #selector(buttonHandlerSectionArrowTap(sender:)), for: .touchUpInside)
        cell.btnDrop.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(buttonLikeTap(sender:)), for: .touchUpInside)
        cell.btnLike.tag = indexPath.row
        cell.btnDislike.addTarget(self, action: #selector(buttonDisLikeTap(sender:)), for: .touchUpInside)
        cell.btnDislike.tag = indexPath.row
        if indexArr.contains(indexPath.row) {
            cell.expendedView.isHidden = false
            cell.btnDrop.setImage(UIImage(imageLiteralResourceName: "up_arrow"), for: .normal)
        }else{
            cell.expendedView.isHidden = true
            cell.btnDrop.setImage(UIImage(imageLiteralResourceName: "down_arrow"), for: .normal)
        }
        if faqs[indexPath.row].like{
            cell.btnLike.setImage(UIImage(imageLiteralResourceName: "filllike"), for: .normal)
        }else{
            cell.btnLike.setImage(UIImage(imageLiteralResourceName: "like"), for: .normal)
        }
        if faqs[indexPath.row].dislike {
            cell.btnDislike.setImage(UIImage(imageLiteralResourceName: "filldislike"), for: .normal)
        }else{
            cell.btnDislike.setImage(UIImage(imageLiteralResourceName: "dislike"), for: .normal)
        }
        tableHeight.constant = expandableTableView.contentSize.height+60
        expandableTableView.layoutIfNeeded()
        //        if faqs.count>0 {
        //
        //
        if indexPath.row == faqs.count-1 {
            //            cell.isHidden = true
            tableHeight.constant = expandableTableView.contentSize.height+60
            expandableTableView.layoutIfNeeded()
            if isCheck {
                
                
                expandableTableView.reloadData()
                isCheck = false
            }
        }
        //        }
        
        return cell
        //        }else{
        //               let cell : FaqCell = tableView.dequeueReusableCell(withIdentifier: "FaqCell2") as! FaqCell
        //            cell.lblCount.text = "\(indexPath.row)"
        //            return cell
        //        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                // do here...
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : FaqCell = expandableTableView.dequeueReusableCell(withIdentifier: String(describing : FaqCell.self)) as! FaqCell
        //        if cell.expendedView.isHidden {
        //            cell.expendedView.isHidden = false
        //        }else{
        //             cell.expendedView.isHidden = true
        //        }
        //        expandableTableView.reloadData()
        
    }
    @objc func buttonHandlerSectionArrowTap(sender : UIButton)  {
        //   let cell : FaqCell = expandableTableView.dequeueReusableCell(withIdentifier: String(describing : FaqCell.self)) as! FaqCell
        //
        //        cell.expendedView.isHidden = false
        //        let sectionData = data[sender.tag]
        //        sectionData.isColleps = !sectionData.isColleps!
        //        expandableTableView.reloadSections(IndexSet(integer: sender.tag), with: .automatic)
        //        indexArr.removeAll()
        if indexArr.contains(sender.tag) {
            indexArr.remove(object: sender.tag)
        }else{
            indexArr.append(sender.tag)
        }
        //        ScrollHeight.constant = expandableTableView.contentSize.height+380
        //        expandableTableView.layoutIfNeeded()
        isCheck = true
        expandableTableView.reloadData()
        
    }
    @objc func buttonLikeTap(sender : UIButton)  {
        
        
        if faqs[sender.tag].like ||  faqs[sender.tag].dislike {
//            indexDislikeArr.remove(object: sender.tag)
            
        }else{
//            self.showLoader()
//            FAQ.indexlikeArr.append(sender.tag)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                self.stopAnimating()
//                self.expandableTableView.reloadData()
//            }
            faqs[sender.tag].like = true
            postInfo(id: "\(faqs[sender.tag].id ?? 0)", action: true)
        }
        
    }
    @objc func buttonDisLikeTap(sender : UIButton)  {
        
        
        if faqs[sender.tag].like ||  faqs[sender.tag].dislike {
//            indexDislikeArr.remove(object: sender.tag)
            
        }else{
//            self.showLoader()
//            FAQ.indexDislikeArr.append(sender.tag)
            faqs[sender.tag].dislike = true
            postInfo(id: "\(faqs[sender.tag].id ?? 0)", action: false)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                self.stopAnimating()
//                self.expandableTableView.reloadData()
//                self.showSwiftMessage(title: AlertTitle.info, message: "Sorry this is not the answer you need. Reach out to us for help.", type: "info")
//
//            }
        }
        

    }
}
class FaqCell: UITableViewCell {
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAns: UILabel!
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var expendedView: UIView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnDislike: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
}
extension String {
    
    var utfData: Data {
        return Data(utf8)
    }
    
    var attributedHtmlString: NSAttributedString? {
        
        do {
            return try NSAttributedString(data: utfData,
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue
                                          ], documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
}
extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format:"<span style=\"font-family: 'Roboto-Regular'; font-size: \(self.font!.pointSize); color:#8D8D8E\">%@</span>", htmlText)
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
}
