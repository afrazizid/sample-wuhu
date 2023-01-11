//
//  Retailers.swift
//  Wuhu
//
//  Created by Awais on 30/04/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class Retailers: BaseVC {
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var table: UITableView!
    var array = [retailerDatum]()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        Applicationevents.postInfo(string: "selected_retailers")
        getRetailer()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
    }
    func getRetailer(){
        self.showLoader()
        UserHandler.getRetailer(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.array = successResponse.data
                self.table.reloadData()
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: "No Retailer found", type: "error")
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
extension Retailers:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetailerCell", for: indexPath) as! RetailerCell
        let url = URL(string: GlobalURL.quizBaseUrl + array[indexPath.row].image)
        print(url)
        cell.img.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if array[indexPath.row].website == ""{
            
        }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Initial", bundle: Bundle.main)
            let activityVC = storyboard.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
            activityVC.html = array[indexPath.row].website!
            self.navigationController?.pushViewController(activityVC, animated: true)
        }
    }
    
}
class RetailerCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
    }
    
}
