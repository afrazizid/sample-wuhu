//
//  TopBarView.swift
//  customView
//
//  Created by Awais on 24/10/2019.
//  Copyright © 2019 Awais. All rights reserved.
//

import UIKit

class TopBarView: UIView {
    @IBOutlet var tabContainer: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var wallet: UIButton!
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commitinit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitinit()
    }
    private func commitinit(){
        Bundle.main.loadNibNamed("TopBar", owner: self, options: nil)
        addSubview(tabContainer)
        tabContainer.frame = self.bounds
        tabContainer.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
}
