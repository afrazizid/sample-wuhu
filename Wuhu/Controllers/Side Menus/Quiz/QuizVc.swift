//
//  QuizVc.swift
//  Wuhu
//
//  Created by Awais on 02/07/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import DropDown

class QuizVc: BaseVC,SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var chk1: CustomCheckBox!
    @IBOutlet weak var chk2: CustomCheckBox!
    @IBOutlet weak var chk3: CustomCheckBox!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var select: UIButton!
    let provincesDD = DropDown()
    
    var myIndex:Int!
    
    var radioButtonController: SSRadioButtonsController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = SSRadioButtonsController(buttons: button1,button2,button3)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        setProvinceDD()
        UIView.setAnimationsEnabled(false)
        //         self.chk1.isChecked = false
        
        
        
    }
    func setProvinceDD() {
        
        self.provincesDD.anchorView = select
        self.provincesDD.bottomOffset = CGPoint(x: 0, y: self.select.bounds.height)
        self.provincesDD.dataSource = General.QuizArray
        self.provincesDD.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.provincesDD.direction = .any
        //        self.provincesDD.
        self.provincesDD.selectionAction = { [weak self] (index, value) in
            self?.select.setTitle(value, for: .normal)
            self?.select.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//            self?.select.titleLabel = value
//            self?.imgDrop.image = UIImage(imageLiteralResourceName: "down_arrow")
        }
        provincesDD.cancelAction = { [unowned self] in}
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        print(selectedButton?.tag ?? 0)
        ////        var currentButton = radioButtonController?.selectedButton()
        
    }
    @IBAction func actionChck(_ sender: AnyObject) {
        if sender.tag == 0 {
            if chk1.isChecked{
                
            }else{
                
            }
        }else if sender.tag == 1 {
            if chk2.isChecked{
                
            }else{
                
            }
            
        }else if sender.tag == 2 {
            if chk3.isChecked{
                
            }else{
                
            }
            
        }
    }
    
    @IBAction func actionSelect(_ sender: UIButton) {

        provincesDD.show()
    }
    
}
extension QuizVc: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCell1", for: indexPath) as! QuizCell1
        
        if indexPath.row == myIndex {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = #colorLiteral(red: 0.7076432705, green: 0.1170439497, blue: 0.9990732074, alpha: 1)
            
            collectionView.scrollToItem(at: IndexPath(row: myIndex, section: indexPath.section), at:.right, animated: false)
        }else{
            cell.layer.borderWidth = 2
            cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        collectionView.reloadData()


    }
    
    
}
class QuizCell1: UICollectionViewCell {
    
    @IBOutlet var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
