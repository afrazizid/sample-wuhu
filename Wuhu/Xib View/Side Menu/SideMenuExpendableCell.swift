//
//  SideMenuExpendableCell.swift
//  Wuhu
//
//  Created by afrazali on 29/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class SideMenuExpendableCell: UITableViewCell {

//    @IBOutlet weak var icon: UIImageView!
//    @IBOutlet weak var imgExpnd: UIImageView!
      @IBOutlet weak var lbl: UILabel!
//    @IBOutlet weak var heightExpended: NSLayoutConstraint!
//    @IBOutlet weak var btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }


//    @IBAction func actionBtn(_ sender: Any) {
//        print("here is",btn.tag)
//    }
    
//    func configContainer(isExpend : Bool) {
//        if isExpend == true {
//            self.heightExpended.priority = UILayoutPriority(rawValue: 250.0)
//        }else {
//            self.heightExpended.priority = UILayoutPriority(rawValue: 999.0)
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
