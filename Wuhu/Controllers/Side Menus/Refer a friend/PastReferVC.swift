
//
//  PastReferVC.swift
//  Wuhu
//
//  Created by afrazali on 03/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class PastReferVC: BaseVC {
    
    @IBOutlet weak var noFriendReferelView: UIView!
    @IBOutlet weak var tble: UITableView!

    var myData : [PastDatum] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableViewSetup()
        getBrand()
    }
    func getBrand(){
        
        self.showLoader()
        
        UserHandler.getRefrel(success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                self.myData = successResponse.data
                if self.myData.count > 0{
                    self.noFriendReferelView.isHidden = true
                    self.tble.isHidden = false
                self.tble.reloadData()
                }else{
                    self.tble.isHidden = true
                    self.noFriendReferelView.isHidden = false
                }
                
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: "", type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
//        loadPastReferFriends()
    }
    
//    override func viewDidLayoutSubviews() {
//
//        self.tble.roundCorners(corners: [.topLeft, .topRight], radius: 8)
//    }
//
    // API Call
    
    /*func loadPastReferFriends(){
        
        self.showLoader()
    
        UserHandler.pastFriend(success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                
                if successResponse.data != nil {
                    self.myData = successResponse.data!
                    if self.myData.count > 0 {
                        self.tble.isHidden = false
                        self.noFriendReferelView.isHidden = true
                        self.tble.reloadData()
                    }else {
                        self.tble.isHidden = true
                        self.noFriendReferelView.isHidden = false
                    }
                }
                
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }*/
}

extension PastReferVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableViewSetup()  {
        
        noFriendReferelView.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.myData.count
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : PastReferCell = tableView.dequeueReusableCell(withIdentifier: String(describing : PastReferCell.self)) as! PastReferCell
//        cell.populateData(obj: myData[indexPath.row], index: indexPath.row)
        cell.lblName.text = myData[indexPath.row].name
        cell.lblPhone.text = myData[indexPath.row].phone
        cell.lblEmail.text = myData[indexPath.row].email
        cell.pts.text = "\(myData[indexPath.row].points as? Int ?? 0)" + " pts"
        cell.rs.text = "R" + "\(getPoints.rs(point: myData[indexPath.row].points as? Int ?? 0))"
        cell.lblCount.text = "\(indexPath.row+1)"
        if myData[indexPath.row].isSignup == 1{
            cell.pts.isHidden = false
            cell.rs.isHidden = false
            cell.img.image = UIImage(named: "w")
        }else{
            cell.pts.isHidden = true
            cell.rs.isHidden = true
            cell.img.image = UIImage(named: "clock")
        }
        return cell
    }
}


class PastReferCell: UITableViewCell {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func populateData(obj:PastReferFriendData, index: Int) {
//
//        self.lblName.text = obj.user_name
//        self.lblPhone.text = obj.phone
//        self.lblEmail.text = obj.email
//        self.lblCount.text = "\(index + 1)"
//
//        if obj.user_avatar != nil {
//            let imgUrl = GlobalURL.imgPath + obj.user_avatar!
//            self.img.sd_setImage(with: URL(string: imgUrl), placeholderImage:UIImage(named: "placeholder"))
//            self.img.roundSquareImage()
//        }
//    }
}
