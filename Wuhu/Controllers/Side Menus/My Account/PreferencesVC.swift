//
//  PreferencesVC.swift
//  Wuhu
//
//  Created by afrazali on 31/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import Foundation
import LUExpandableTableView
import SwiftyJSON

//class PreferencesVC: BaseVC {
//
//    @IBOutlet weak var expandableTableView: LUExpandableTableView!
//
//    var sectionTitleArr = ["Products", "Notification Type", "Content Type"]
//    var sectionDescArr = ["Select which product offers appeal to you most", "Choose the channel ", "Choose the type of notifications"]
//
//
//    private let sectionHeaderReuseIdentifier = "MySectionHeader"
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setExpendableTable()
//
//    }
//
//
//    func setExpendableTable() {
//
//        expandableTableView.register(PreferencesTableCell.self, forCellReuseIdentifier: "PreferencesTableCell")
//        expandableTableView.register(UINib(nibName: "MyExpandableTableViewSectionHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: sectionHeaderReuseIdentifier)
//
//        expandableTableView.expandableTableViewDataSource = self
//        expandableTableView.expandableTableViewDelegate = self
//    }
//
//
//    @IBAction func btnActionback(_ sender: UIButton) {
//
//           self.popVC()
//    }
//
//}
//
//extension PreferencesVC: LUExpandableTableViewDataSource {
//    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
//        return 3
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
////        let myCell = expandableTableView.dequeueReusableCell(withIdentifier: "PreferencesTableCell", for: indexPath) as? PreferencesTableCell
//
//        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: "PreferencesTableCell") as? PreferencesTableCell else {
//            assertionFailure("Cell shouldn't be nil")
//            return UITableViewCell()
//        }
//            //        myCell!.lbl.text = "Cell at row \(indexPath.row) section \(indexPath.section)"
//            //        myCell!.togle.isOn = true
//
//
////        cell.label.text = "Cell at row \(indexPath.row) section \(indexPath.section)"
//
//        return cell
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
//        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderReuseIdentifier) as? MyExpandableTableViewSectionHeader else {
//            assertionFailure("Section header shouldn't be nil")
//            return LUExpandableTableViewSectionHeader()
//        }
//
//        sectionHeader.lblTitle.text = self.sectionTitleArr[section]
//        sectionHeader.lblDisc.text = self.sectionDescArr[section]
//
//        return sectionHeader
//    }
//}
//
//// MARK: - LUExpandableTableViewDelegate
//
//extension PreferencesVC: LUExpandableTableViewDelegate {
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
//        return 60
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
//        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
//        return 80
//    }
//
//    // MARK: - Optional
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
//        print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
//        print("Did select section header at section \(section)")
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
//        print("Will display section header for section \(section)")
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }
//
//    func expandableTableView(_ expandableTableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
//}


enum cellHeight : CGFloat{
    case Header = 80
    case Row = 60
}

class PreferencesVC: BaseVC {
    
    @IBOutlet weak var expandableTableView: UITableView!
    
    
    
    var data : [Section] = [
        Section(title: "Products", discription: "Select which product offers appeal to you most",  list: ["Condiments", "Food Sauces & Mixes", "Herbs & Spices", "Household Cleaning", "Ice Cream", "Laundry", "Oral Care", "Skincare", "Teas & Drinks", "Toiletries & Health"], isColleps: false),
        
        Section(title: "Notification Type", discription: "Choose the channel ", list: ["SMS", "Email", "In-App"], isColleps: false),
        
        Section(title: "Content Type", discription: "Choose the type of notifications", list: ["Promotions", "News"], isColleps: false)]
    
    var data1 = [dataArr]()
    var indexVal:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewSetup()
        Applicationevents.postInfo(string: "preferences")
        getPrefrences()
    }
    func getPrefrences(){
        self.showLoader()
        UserHandler.getprefrences(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.data1 = successResponse.data
                self.expandableTableView.reloadData()
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    @IBAction func btnActionback(_ sender: UIButton) {
        
        self.popVC()
    }
}

extension PreferencesVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableViewSetup()  {
        expandableTableView.dataSource = self
        expandableTableView.delegate = self
        expandableTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data1.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeight.Header.rawValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        let header : HeaderCell = tableView.dequeueReusableCell(withIdentifier: String(describing : HeaderCell.self)) as! HeaderCell
        
        let sectionData = data[section]
        let sectionData1 = data1[section]
        //        header.lblTitle.text = sectionData.title!
        header.lblTitle.text = sectionData1.name!
        header.lblDisc.text = sectionData.discription
        
        ///arrow rotate
        //        header.btnExpend.transform = CGAffineTransform(rotationAngle: (sectionData.isColleps)! ? 0.0 : .pi)
        
        
        header.btnExpend.tag = section
        
        header.btnExpend.setImage(sectionData.isColleps! ? UIImage(named: "cross-blue") : UIImage(named: "plus-skyBlue"), for: .normal)
        header.btnExpend.addTarget(self, action: #selector(buttonHandlerSectionArrowTap(sender:)), for: .touchUpInside)
        return header.contentView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data[section].isColleps ?? false ? (data1[section].val?.count ?? 0) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PreferencesTableCell = tableView.dequeueReusableCell(withIdentifier: String(describing : PreferencesTableCell.self)) as! PreferencesTableCell
        
        let listData = data[indexPath.section].list
        let listData1 = data1[indexPath.section].val
        indexVal = indexPath.section
        cell.lbl.text = listData1?[indexPath.row].fieldLabel
        cell.togle.addTarget(self, action: #selector(togle(sender:)), for: .touchUpInside)
        cell.togle.tag = indexPath.row
        cell.cancel.layer.cornerRadius = 26
        cell.save.layer.cornerRadius = 26
        if listData1?[indexPath.row].value == true {
            cell.togle.isOn = true
        }else{
            cell.togle.isOn = false
        }
        
        //        if listData?[indexPath.row] == "Email"{
        //            if cell.togle.isOn{
        //                cell.emailView.isHidden = false
        //            }else{
        //               cell.emailView.isHidden = true
        //            }
        //        }else{
        //           cell.emailView.isHidden = true
        //        }
        //        cell.togle.isOn = false
        return cell
    }
    
    //Button action arrow in header
    @objc func buttonHandlerSectionArrowTap(sender : UIButton)  {
        let sectionData = data[sender.tag]
        //        indexVal = sender.tag
        sectionData.isColleps = !sectionData.isColleps!
        expandableTableView.reloadSections(IndexSet(integer: sender.tag), with: .automatic)
    }
    @objc func togle(sender : UISwitch)  {
        let postVal = data1[indexVal]
        
        savePref(type: postVal.name, label: postVal.val[sender.tag].fieldLabel, val: sender.isOn)
        
        
        //     let listData = data[indexVal].list
        //     let val = listData?[sender.tag]
        //        if val == "Email"{
        //            expandableTableView.reloadData()
        //        }
    }
    
    func savePref(type:String,label:String,val:Bool){
        
        var parameters : [String: Any]
        parameters = [
            "type"              : type,
            "field_label"    : label,
            "value"        : val
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.savePrefrences(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            
            //            let resp = JSON(successResponse)
            
            if successResponse.status == true {
                
                self.data1 = successResponse.data
                self.expandableTableView.reloadData()
                
            }else  {
                
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
}

class Section {
    var title        : String?
    var discription  : String?
    var list         : [String]?
    var isColleps    : Bool?
    init() {
    }
    
    init(title : String? , discription: String? , list : [String]?, isColleps : Bool?) {
        self.title = title
        self.discription = discription
        self.list = list
        self.isColleps = isColleps
    }
}

//class List {
//    var title        : [String]?
//    var value        : Bool?
//    init() {
//    }
//
//    init(title : String? , discription: String? , list : [String]?, isColleps : Bool?) {
//        self.title = title
//        self.discription = discription
//        self.list = list
//        self.isColleps = isColleps
//    }
//}


import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var btnExpend: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDisc: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class PreferencesTableCell: UITableViewCell {
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var togle: UISwitch!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var save: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
