//
//  StampInfo.swift
//  Wuhu
//
//  Created by Awais on 10/09/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class StampInfo: BaseVC {
    
    @IBOutlet weak var table: UITableView!
    
    var putData: StampCardsData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
extension StampInfo:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            
            return putData.proData.count
        }else{
            return 1
        }
        //        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "omoUpperCell", for: indexPath) as! omoUpperCell
            let url = URL(string: putData.image!)
            cell.banner.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
            cell.name.text = putData.name
            cell.destail.text = putData.description
            cell.backBtn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
            cell.backBtn.tag = indexPath.row
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "stampListing", for: indexPath) as! stampListing
            cell.name.text = putData.proData[indexPath.row].name?.uppercased()
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "omoBottomCell", for: indexPath) as! omoBottomCell
            return cell
        }
    }
    
        @objc func connected(sender: UIButton){
            
//            let buttonTag = sender.tag
            
            self.moveBack()
           }
}
class omoUpperCell: UITableViewCell {
    
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var destail: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class stampListing: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class omoBottomCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
