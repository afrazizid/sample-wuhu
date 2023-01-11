//
//  GiftsVC.swift
//  Wuhu
//
//  Created by afrazali on 11/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class GiftsVC: BaseVC {

    @IBOutlet weak var giftTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewSetup()
    }
    
    @IBAction func btnActionback(_ sender: UIButton) {
           
           self.moveBack()
    }
}

extension GiftsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableViewSetup()  {
        giftTable.dataSource = self
        giftTable.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = giftTable.dequeueReusableCell(withIdentifier: "GiftCell", for: indexPath) as! GiftCell
        return cell
    }
}





class GiftCell: UITableViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
