//
//  Food&DrinkVC.swift
//  Wuhu
//
//  Created by afrazali on 11/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class Food_DrinkVC: BaseVC {

    @IBOutlet weak var foodTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewSetup()
    }
    
    @IBAction func btnActionback(_ sender: UIButton) {
           
           self.moveBack()
    }
}

extension Food_DrinkVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableViewSetup()  {
        foodTable.dataSource = self
        foodTable.delegate = self
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
        
        let cell = foodTable.dequeueReusableCell(withIdentifier: "FoodDrinkCell", for: indexPath) as! FoodDrinkCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "RedeemVC") as? RedeemVC
        vc!.modalPresentationStyle = .popover
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}





class FoodDrinkCell: UITableViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
