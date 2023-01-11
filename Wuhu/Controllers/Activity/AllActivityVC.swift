//
//  AllActivityVC.swift
//  Wuhu
//
//  Created by afrazali on 05/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit


class AllActivityVC: BaseVC {
    
    @IBOutlet weak var tble: UITableView!
    @IBOutlet weak var noact: UILabel!
    
    var data = [ActivityData]()
    
    static var mymonth = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tble.dataSource = self
        tble.delegate = self
        // Do any additional setup after loading the view.
        getActivity()
        tble.isScrollEnabled = false
    }
    
    func getActivity(){
        
        var parameters : [String: Any]
        parameters = [
            "user_id"              : self.Shared.userInfo?.user_id ?? 0,
            "filter"              : "All",
            "month"               : AllActivityVC.mymonth
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.getActivity(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                
                self.data = successResponse.data
                if self.data.count == 0 {
                    self.noact.isHidden = false
                    self.tble.isHidden = true
                }else{
                    self.noact.isHidden = true
                    self.tble.isHidden = false
                self.tble.reloadData()
                print(self.tble.contentSize.height)
                }
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: "", type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    func populateData() {
        
    }
    func dayOfTheWeek(index:Int) -> String? {
        let weekdays = [
            "SUN",
            "MON",
            "TUE",
            "WED",
            "THU",
            "FRI",
            "SAT"
        ]
        
        return weekdays[index-1]
    }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
}

extension AllActivityVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
     {
     return 100
     }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : AllActivityCell = tableView.dequeueReusableCell(withIdentifier: String(describing : AllActivityCell.self)) as! AllActivityCell
        
        if data[indexPath.row].displayType == "mission"{
            cell.lblName.text = data[indexPath.row].name
            cell.lblDesc.text = data[indexPath.row].descriptionField
            cell.img.image = UIImage(imageLiteralResourceName: "actmission")
        }else if data[indexPath.row].displayType == "voucher"{
            if data[indexPath.row].assignThrough == "redeemed" {
                cell.lblDesc.text = data[indexPath.row].descriptionField
                cell.lblName.text = "VOUCHER REDEEMED"
                cell.img.image = UIImage(imageLiteralResourceName: "actvoucher")
            }else{
                cell.lblName.text = "GIFT A FRIEND"
                cell.img.image = UIImage(imageLiteralResourceName: "actvoucher")
                
            }
        }else if data[indexPath.row].displayType == "receipt"{
            cell.lblName.text = "SCAN TILL SLIP"
            cell.lblDesc.text = data[indexPath.row].name
            cell.img.image = UIImage(imageLiteralResourceName: "actscan")
        }
        
      //  let pointval = getPoints.rs(point: data[indexPath.row].points)
        let valueInPoint = self.convertPointsToFloat(val: data[indexPath.row].points)
        
        if data[indexPath.row].pointType == "credit" {
            cell.lblPoints.text = "+" + "\(data[indexPath.row].points ?? 0)" + " pts"
            cell.lblRs.text = "+R" + "\(valueInPoint)"
//            cell.lblRs.text = "+R" + "\(getPoints.rs(point: data[indexPath.row].points))"
        }else{
            cell.lblPoints.text = "-" + "\(data[indexPath.row].points ?? 0)" + " pts"
            cell.lblRs.text = "-R" + "\(valueInPoint)"
        }
        
    
        let mydate = data[indexPath.row].createdAt!
        let date = mydate.split(separator: " ")
        
          let val = getDayOfWeek(String(date[0]))!
        cell.lblDay.text = dayOfTheWeek(index: val)
        
        
        let myDay = date[0].split(separator: "-")
        print(myDay[2])
        cell.lblDate.text = String(myDay[2])
    
        /* if indexPath.row == 2 {
         
         cell.lblDay.isHidden = true
         cell.lblDate.isHidden = true
         }*/
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if data[indexPath.row].displayType == "receipt"{
            
            let objToBeSent = data[indexPath.row].receiptId
            NotificationCenter.default.post(name: Notification.Name("NotificationImage"), object: objToBeSent)
           
            
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                // do here...
                print(tble.contentSize.height)
                NotificationCenter.default.post(name: Notification.Name("scroll"), object: tble.contentSize.height)
                
            }
        }
    }
}


class AllActivityCell: UITableViewCell {
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblNum: UILabel!
    @IBOutlet weak var lblRs: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
    //    }
    
}
