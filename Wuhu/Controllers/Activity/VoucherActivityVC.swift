//
//  VoucherActivityVC.swift
//  Wuhu
//
//  Created by afrazali on 05/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class VoucherActivityVC:BaseVC {
    
    @IBOutlet weak var tble: UITableView!
    
    var data = [ActivityData]()
    
    
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
            "filter"              : "voucher"
            
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.getActivity(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                
                self.data = successResponse.data
                self.tble.reloadData()
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

extension VoucherActivityVC: UITableViewDelegate, UITableViewDataSource {
    
    
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
            cell.img.image = UIImage(imageLiteralResourceName: "actmission")
        }else{
            if data[indexPath.row].assignThrough == "redeemed" {
                cell.lblName.text = "VOUCHER REDEEMED"
                cell.img.image = UIImage(imageLiteralResourceName: "actvoucher")
            }else{
                
            }
        }
        
        let valueInPoint = self.convertPointsToFloat(val: data[indexPath.row].points)
        cell.lblDesc.text = data[indexPath.row].descriptionField
        if data[indexPath.row].pointType == "credit" {
            cell.lblPoints.text = "+" + "\(data[indexPath.row].points ?? 0)" + " pts"
            cell.lblRs.text = "+R" + valueInPoint
                //"\(getPoints.rs(point: data[indexPath.row].points))"
        }else{
            cell.lblPoints.text = "-" + "\(data[indexPath.row].points ?? 0)" + " pts"
            cell.lblRs.text = "-R" + valueInPoint
                //"\(getPoints.rs(point: data[indexPath.row].points))"
        }
        /* if indexPath.row == 2 {
         
         cell.lblDay.isHidden = true
         cell.lblDate.isHidden = true
         }*/
        let mydate = data[indexPath.row].createdAt!
        let date = mydate.split(separator: " ")
        
          let val = getDayOfWeek(String(date[0]))!
        cell.lblDay.text = dayOfTheWeek(index: val)
        
        
        let myDay = date[0].split(separator: "-")
        print(myDay[2])
        cell.lblDate.text = String(myDay[2])
        return cell
    }
}


