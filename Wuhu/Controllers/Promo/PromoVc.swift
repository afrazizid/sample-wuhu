//
//  PromoVc.swift
//  Wuhu
//
//  Created by Awais on 06/01/2021.
//  Copyright © 2021 Afraz Ali. All rights reserved.
//

import UIKit

class PromoVc: BaseVC {
    
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    var promoData = [PromoDatum]()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        getPromo()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        pts.text = "  "+"\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarBack(view: topBar)
    }
    func getPromo(){
        
        self.showLoader()
        
        UserHandler.getpromo(success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                self.promoData = successResponse.data
                self.productTable.reloadData()
                
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }

}
extension PromoVc: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        promoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "PromoComp", for: indexPath) as! PromoComp
        
        let url = URL(string: promoData[indexPath.row].image!)
        cell.logo.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
        
        cell.title.text = promoData[indexPath.row].title
        cell.desc.text = promoData[indexPath.row].descriptionField
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if promoData[indexPath.row].url == "" {
            
        }else{
        let storyboard: UIStoryboard = UIStoryboard(name: "Initial", bundle: Bundle.main)
        let activityVC = storyboard.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
        activityVC.html = promoData[indexPath.row].url!
        self.navigationController?.pushViewController(activityVC, animated: true)
        }
    }
    
}
class PromoComp: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var logo: UIImageView!

    @IBOutlet weak var lblPromo: UILabel!{
        didSet {
            self.lblPromo.setBorderWidth(borderWidth: 0, cornerRadius: 15, borderColor: #colorLiteral(red: 1, green: 0.9747149348, blue: 0.4545389414, alpha: 1))
        }
    }
    
    @IBOutlet weak var contentview: UIView!{
        didSet{
            self.layer.cornerRadius = 8
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
