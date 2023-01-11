//
//  ImageShowVc.swift
//  Wuhu
//
//  Created by Awais on 27/08/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ImageShowVc: BaseVC {

    var imgString = ""
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: imgString)
    image.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
        // Do any additional setup after loading the view.
    }
    

   @IBAction func actionClose(_ sender:UIButton){
    self.moveBack()
   }

}
