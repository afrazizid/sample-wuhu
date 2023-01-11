//
//  SubmittedTillSlip.swift
//  Wuhu
//
//  Created by Awais on 11/05/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
struct tableData {
    
    var isResolve: Bool
    let name: String!
    let pts: String!
    let rs: String!
    
}
class SubmittedTillSlip: BaseVC {
    
    @IBOutlet weak var receiptTable: UITableView!
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var upperView: UIStackView!
    @IBOutlet weak var midleView: UIView!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var pts:UILabel!
    @IBOutlet weak var rs:UILabel!
    @IBOutlet weak var stamp:UILabel!
    @IBOutlet weak var resolve:UILabel!
    @IBOutlet weak var resolveView:UIView!
    @IBOutlet weak var phone:UILabel!
    @IBOutlet weak var total:UILabel!
    @IBOutlet weak var storeName:UILabel!
    @IBOutlet weak var address:UILabel!
    @IBOutlet weak var date:UILabel!
    @IBOutlet weak var retailerImage:UIImageView!
    
    var content: Content!
    var top: receiptDatum!
    var arr = [Product]()
    var receiptId:Int!
    var board = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptTable.isScrollEnabled = false
        
        if board == 1{
            receiptId = content.receiptId
            btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        }else if board == 2{
            btnMenu.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
            btnMenu.setImage(UIImage(named: "btn_arrowBack"), for: .normal)
        }
        getdata()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.receiptTable.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.receiptTable.removeObserver(self, forKeyPath: "contentSize")
        super.viewWillDisappear(true)
    }
    func getdata(){
        
        var parameters : [String: Any]
        parameters = [
            "receipt_id"              :receiptId!,
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.getReceipt(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.arr = successResponse.receiptData.products
                self.top = successResponse.receiptData
                self.setUi()
            }else  {
                self.popVC()
                self.showSwiftMessage(title: AlertTitle.warning, message: "An error has been occured", type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func setUi() {
        receiptTable.reloadData()
        if board == 1{
            pts.text = "\(content.points ?? 0)"+" pts"
            rs.text = "R"+"\(getPoints.rs(point: content.points))"
            stamp.text = "\(content.stamp ?? 0)"
            resolve.text = "\(content.resolve ?? 0)"
            if content.resolve <= 0 {
                resolveView.isHidden = true
            }
        }else if board == 2{
            
            pts.text = "\(top.receiptloyal.points ?? 0)"+" pts"
            let new = Float(top.receiptloyal.points)
            rs.text = "R"+String(format: "%.2f", new/10)
//            rs.text = "R"+"\(getPoints.rs(point: top.receiptloyal.points))"
            stamp.text = "\(top.receiptloyal.stamps ?? 0)"
            resolve.text = "\(2)"
            let url = URL(string: top.retailerLogo)
            retailerImage.sd_setImage(with: url)
            
            
            
        }
        
        
        total.text = "R"+String(format: "%.2f", top.total)
        storeName.text = top.retailer
        address.text = top.retailerAddress
        phone.text = "Tel No: "+top.number
        //        let nc = top.scanDate.replacingOccurrences(of: "T", with: " ")
        let nc = top.receiptDate ?? ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let date1 = dateFormatterGet.date(from: nc) {
            print(dateFormatterPrint.string(from: date1))
            date.text = dateFormatterPrint.string(from: date1) + " " + top.time
        } else {
            date.text = nc + " " + top.time
            print("There was an error decoding the string")
        }
        
        
        //        arr[1].requiresObservation  = true
        
        //        arr = [tableData(isResolve: false, name: "Vegetable Soup Inst", pts: "10", rs: "6.95"),
        //               tableData(isResolve: false, name: "mini tennis biscuit", pts: "20", rs: "16.95"),
        //               tableData(isResolve: true, name: "50g Biltong", pts: "20", rs: "10.90"),
        //               tableData(isResolve: false, name: "24 litre vtc (Foods)", pts: "10", rs: "5.75"),
        //               tableData(isResolve: true, name: "yoghurt 175g", pts: "20", rs: "6.00"),
        //               tableData(isResolve: false, name: "bread/brown", pts: "10", rs: "13.95"),
        //        tableData(isResolve: false, name: "mini tennis biscuit", pts: "20", rs: "16.95"),
        //        tableData(isResolve: true, name: "50g Biltong", pts: "20", rs: "10.90"),
        //        tableData(isResolve: false, name: "24 litre vtc (Foods)", pts: "10", rs: "5.75"),
        //        tableData(isResolve: true, name: "yoghurt 175g", pts: "20", rs: "6.00"),
        //        tableData(isResolve: false, name: "bread/brown", pts: "10", rs: "13.95"),]
        
        receiptTable.layoutIfNeeded()
        
//        scrollHeight.constant = receiptTable.contentSize.height + upperView.frame.height + lowerView.frame.height + midleView.frame.height + 1000
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){

            if let newvalue = change?[.newKey]{
                let newsize  = newvalue as! CGSize
                self.scrollHeight.constant = newsize.height + upperView.frame.height + lowerView.frame.height + midleView.frame.height + 20
            }
        }
    }
    @IBAction func actionUp(_ sender:UIButton){
        
        scrollView.scrollTop()
    }
    
    
}
extension SubmittedTillSlip: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SlipCell") as! SlipCell
        
        if arr[indexPath.row].loyalty.points == 0 {
            cell.prdPoints.text = ""
//            arr[indexPath.row].requiresObservation = true
        }else{
            cell.prdPoints.text = "\(arr[indexPath.row].loyalty.points!)"+" pts"
//            arr[indexPath.row].requiresObservation = false
        }
        if arr[indexPath.row].requiresObservation {
            cell.background.backgroundColor = #colorLiteral(red: 0.9530758262, green: 0.9407428503, blue: 0.9654083848, alpha: 1)
            cell.dot.isHidden = false
            cell.menu.isHidden = false
            cell.imgSearch.isHidden = false
            cell.prdPoints.isHidden = true
        }else{
            cell.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.dot.isHidden = true
            cell.menu.isHidden = true
            cell.imgSearch.isHidden = true
            cell.prdPoints.isHidden = false
        }
        cell.prdName.text = arr[indexPath.row].descriptionField.uppercased()
        //        cell.prdPoints.text = arr[indexPath.row].pts.uppercased()+" PTS"
        cell.prdPrice.text = "R"+String(format: "%.2f", arr[indexPath.row].totalPrice)
        

        return cell
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if arr[indexPath.row].requiresObservation {
            return true
        }else{
            return false
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //        if indexPath.section == 0{
        //        let ttl = ""+"Resolve"+"".padding(toLength: 10, withPad: " ", startingAt: 0)
        let cancel = UIContextualAction(style: .destructive, title: "   Resolve   ") { action, view, complete in
            print("Cancel")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Resolve") as! Resolve
            //            vc.alias_id = self.arr[indexPath.row].sku
            self.navigationController?.pushViewController(vc, animated: true)
            complete(false)
        }
        cancel.backgroundColor = #colorLiteral(red: 0.5483766794, green: 0, blue: 1, alpha: 1)
        
        //        cancel.image = #imageLiteral(resourceName: "iconReward")
        
        return UISwipeActionsConfiguration(actions: [cancel])
    }
    
    
}
class SlipCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var dot: UIView!
    @IBOutlet weak var prdName: UILabel!
    @IBOutlet weak var prdPoints: UILabel!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var prdPrice: UILabel!
    @IBOutlet weak var menu: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
