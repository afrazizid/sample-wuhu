//
//  HomeTabVC1.swift
//  Wuhu
//
//  Created by afrazali on 04/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//
/*
import UIKit

class HomeTabVC1: BaseVC {
    
    @IBOutlet weak var baseCollection: UICollectionView!
    @IBOutlet weak var btnMenu: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        
    }
            
    func reloadData(){
        
        baseCollection.reloadData()
    }
}

extension HomeTabVC1 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell1 = baseCollection.dequeueReusableCell(withReuseIdentifier: "BaseCell1", for: indexPath) as! BaseCell1
            return cell1
        }else if indexPath.row == 1 {
            let cell2 = baseCollection.dequeueReusableCell(withReuseIdentifier: "BaseCell2", for: indexPath) as! BaseCell2
            return cell2
            
        }else  {
            let cell3 = baseCollection.dequeueReusableCell(withReuseIdentifier: "BaseCell3", for: indexPath) as! BaseCell3
            return cell3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
        
    
    // FlowLayout Collection
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: self.baseCollection.frame.width, height: 520)
        }else if indexPath.row == 1{
            return CGSize(width: self.baseCollection.frame.width, height: 300)
        }else {
            return CGSize(width: self.baseCollection.frame.width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


class BaseCell1: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var missionCollection: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // Mission Collection Delegates and FlowLayouts
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = missionCollection.dequeueReusableCell(withReuseIdentifier: "MissionCell", for: indexPath) as! MissionCell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    // FlowLayout Collection
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: self.missionCollection.frame.width - 70 , height: self.missionCollection.frame.height)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

class BaseCell2: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var promoCollection: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // Mission Collection Delegates and FlowLayouts
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = promoCollection.dequeueReusableCell(withReuseIdentifier: "PromoCell", for: indexPath) as! PromoCell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    // FlowLayout Collection
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.promoCollection.frame.width - 30 , height: self.promoCollection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

class BaseCell3: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


// Mission Collection Cell

class MissionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

// Promo Collection Cell

class PromoCell: UICollectionViewCell {

    @IBOutlet weak var lblPromo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblPromo.setBorderWidth(borderWidth: 0, cornerRadius: 10, borderColor: #colorLiteral(red: 1, green: 0.9747149348, blue: 0.4545389414, alpha: 1))

    }

}


*/
