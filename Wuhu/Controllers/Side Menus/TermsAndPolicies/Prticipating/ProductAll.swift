//
//  ProductAll.swift
//  Wuhu
//
//  Created by Awais on 15/09/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ProductAll: BaseVC {
    @IBOutlet weak var productTable: UITableView!
    var brandData = [Brand]()
    var index = 0
    var select = ""
    var rowCount = 0
    static var selectedVal = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getBrand()
       
        // Do any additional setup after loading the view.
    }
    func getBrand(){
        
        self.showLoader()
        
        UserHandler.getbrands(success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                self.brandData = successResponse.data.brands
                
                self.check()
                
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func check() {
        
        if brandData.count%2==0 {
            rowCount = brandData.count/2
        }else{
            rowCount = (brandData.count+1)/2
        }
        productTable.reloadData()
        if ProductAll.selectedVal == 200000{
            
        }else{
        index = ProductAll.selectedVal

        if index > rowCount-1{
            select = "right"
            index = index-rowCount
            print(index)
            let indexPath:IndexPath = IndexPath(row: index, section: 0)
            self.productTable.scrollToRow(at: indexPath, at: .none, animated: true)
        }else{
            select = "left"
            let indexPath:IndexPath = IndexPath(row: index, section: 0)
            self.productTable.scrollToRow(at: indexPath, at: .none, animated: true)
        }


        }
       
}
}
extension ProductAll:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(rowCount)

        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "ProductAllCell", for: indexPath) as! ProductAllCell
       
        
       ///
        cell.outer2.isHidden = false
        cell.brandImg2.isHidden = false
        ///
        
        cell.expandView.isHidden = true
        cell.operImg1.isHidden = true
        cell.operImg2.isHidden = true
        
        cell.outer1.layer.cornerRadius = 10
        cell.outer1.layer.borderWidth = 2
        cell.outer1.tintColor = UIColor.white
        cell.outer1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.outer1.backgroundColor = UIColor.white
        cell.layer.opacity = 0.1
        
        cell.outer2.layer.cornerRadius = 10
        cell.outer2.layer.borderWidth = 2
        cell.outer2.tintColor = UIColor.white
        cell.outer2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.outer2.backgroundColor = UIColor.white
        

            let url = URL(string: brandData[indexPath.row].image!)
            cell.brandImg1.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
        if indexPath.row == rowCount-1 && brandData.count%2 == 1 {
            cell.outer2.isHidden = true
            cell.brandImg2.isHidden = true
                      }else{
                        cell.outer2.isHidden = false
                        cell.brandImg2.isHidden = false
            let url2 = URL(string: brandData[indexPath.row+rowCount].image!)
            cell.brandImg2.sd_setImage(with: url2, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
                      }
        cell.btn1.addTarget(self, action: #selector(connected1(sender:)), for: .touchUpInside)
        cell.btn1.tag = indexPath.row
        
        cell.btn2.addTarget(self, action: #selector(connected2(sender:)), for: .touchUpInside)
        cell.btn2.tag = indexPath.row
        
        cell.closeBtn.addTarget(self, action: #selector(close(sender:)), for: .touchUpInside)
        cell.closeBtn.tag = indexPath.row
        
        cell.moveBtn.addTarget(self, action: #selector(move(sender:)), for: .touchUpInside)
        cell.moveBtn.tag = indexPath.row
        
        if select == "right"{

            if indexPath.row == index{
                cell.expandView.isHidden = false
                cell.expandImg.image = UIImage(named: "rnechaye")
                cell.outer2.layer.cornerRadius = 0
                cell.outer2.layer.borderWidth = 0
                cell.outer2.tintColor = UIColor.clear
                cell.outer2.backgroundColor = UIColor.clear
                cell.operImg2.isHidden = false
                if indexPath.row == rowCount-1 && brandData.count%2 == 1 {
                    cell.outer2.isHidden = true
                    cell.brandImg2.isHidden = true
                              }else{
                                cell.outer2.isHidden = false
                                cell.brandImg2.isHidden = false
                cell.name.text = brandData[indexPath.row+rowCount].name
                cell.desc.text = brandData[indexPath.row+rowCount].descriptionField
                              }
            }
        }else if select == "left"{
            if indexPath.row == index{
                cell.expandView.isHidden = false
                cell.expandImg.image = UIImage(named: "nechaye")
                cell.outer1.layer.cornerRadius = 0
                cell.outer1.layer.borderWidth = 0
                cell.outer1.tintColor = UIColor.clear
                cell.outer1.backgroundColor = UIColor.clear
                cell.operImg1.isHidden = false
                cell.name.text = brandData[indexPath.row].name
                cell.desc.text = brandData[indexPath.row].descriptionField
                }

        }else{


        }
        productTable.layoutIfNeeded()
        return cell
    }
    
    @objc func connected1(sender: UIButton){
        select = "left"
        index = sender.tag
        let indexPath:IndexPath = IndexPath(row: index, section: 0)
        self.productTable.scrollToRow(at: indexPath, at: .none, animated: true)
        productTable.reloadData()
        
        
    }
    @objc func connected2(sender: UIButton){
        
        select = "right"
        index = sender.tag
        let indexPath:IndexPath = IndexPath(row: index, section: 0)
        if indexPath.row == rowCount-1 && brandData.count%2 == 1 {
           
        }else{
            self.productTable.scrollToRow(at: indexPath, at: .none, animated: true)
            productTable.reloadData()
        }
//        self.productTable.scrollToRow(at: indexPath, at: .none, animated: true)
//        productTable.reloadData()
    }
    @objc func close(sender: UIButton){
        select = ""
        productTable.reloadData()
    }
    @objc func move(sender: UIButton){
        
    NotificationCenter.default.post(name: Notification.Name("productDetail"), object: "put")
    }
    
}
class ProductAllCell: UITableViewCell {
    
    @IBOutlet weak var outer1: UIView!
    @IBOutlet weak var outer2: UIView!
    
    @IBOutlet weak var operImg1: UIImageView!
    @IBOutlet weak var operImg2: UIImageView!
    
    @IBOutlet weak var brandImg1: UIImageView!
    @IBOutlet weak var brandImg2: UIImageView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var expandView: UIView!
    @IBOutlet weak var expandImg: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var moveBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
