//
//  StampCellBody.swift
//  Wuhu
//
//  Created by Ahmed Durrani on 18/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class StampCellBody: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
}
