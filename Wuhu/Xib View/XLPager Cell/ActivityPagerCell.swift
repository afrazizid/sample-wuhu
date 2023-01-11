//
//  ActivityPagerCell.swift
//  Wuhu
//
//  Created by afrazali on 05/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ActivityPagerCell: UICollectionViewCell {

    @IBOutlet weak var lbl: UILabel!{
        didSet{
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lbl.layer.cornerRadius = 10
        
    }
}
