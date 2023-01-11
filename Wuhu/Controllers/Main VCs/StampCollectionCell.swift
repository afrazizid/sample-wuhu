//
//  StampCollectionCell.swift
//  Wuhu
//
//  Created by Awais on 18/09/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import LinearProgressView

class StampCollectionCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var punchCardCount:Int = 0
    var pointsCount:Int!
    
    
    
    @IBOutlet var gridCollection: UICollectionView!
    @IBOutlet var linearProgressView: LinearProgressView!
    @IBOutlet var badge: UIImageView!
    @IBOutlet var progressBg: UIImageView!
    @IBOutlet var swap: UIImageView!
    @IBOutlet var swapFlip: UIImageView!
    @IBOutlet var background: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var terms: UILabel!
    @IBOutlet var progress: UILabel!
    @IBOutlet var info: UIButton!
    @IBOutlet var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        print(punchCardCount)
//        if punchCardCount > 0{
            gridCollection.delegate = self
            gridCollection.dataSource = self
            gridCollection.reloadData()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return punchCardCount+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gridCollection.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! gridCell
        
        cell.outer.layer.cornerRadius = 3
        cell.outer.layer.borderWidth = 1
        cell.outer.tintColor = UIColor.white
        cell.outer.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.outer.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        cell.logo.image = nil
        cell.count.text = "\(indexPath.row+1)"
        if indexPath.row == punchCardCount {
            cell.outer.backgroundColor = UIColor.clear
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
                           let collectionWidth = collectionView.bounds.width
                            let collectioHeight = collectionView.bounds.height
                    
        //            let size = collectionWidth/CGFloat(myCount+1)
                    if punchCardCount >= 20{
                       return CGSize(width: collectionWidth/5, height: collectioHeight/5)
                    }else{
                    return CGSize(width: collectionWidth/4, height: collectioHeight/5)
                    }

        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
class gridCell: UICollectionViewCell{
    @IBOutlet var bg: UIImageView!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var outer: UIView!
    @IBOutlet var count: UILabel!
    @IBOutlet var rs: UILabel!
    @IBOutlet var free: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}
