//
//  MissionCompletVC.swift
//  Wuhu
//
//  Created by afrazali on 14/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class MissionCompletVC: BaseVC {
    
    @IBOutlet weak var collection: UICollectionView!
    var missiondata = [MissionDatum]()
var refreshControl:UIRefreshControl!
    @IBOutlet var noMission:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Applicationevents.postInfo(string: "completed_missions")
//        getMissions()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh1), for: .valueChanged)
        collection.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }
        @objc func refresh1()
        {
            refreshControl.endRefreshing()
            getMissions()

        }
    override func viewDidAppear(_ animated: Bool) {
        getMissions()
    }
        func getMissions(){
//            missiondata.removeAll()
             self.showLoader()
             UserHandler.getMissions(success: { (successResponse) in
                 self.stopAnimating()
                self.missiondata.removeAll()
                 if successResponse.status == true {
                    for i in successResponse.data.indices{
                        if successResponse.data[i].missions.count > 0{
                        if successResponse.data[i].missions[0].completed{
                            self.missiondata.append(successResponse.data[i])
                        }
                        }
                    }
                    if self.missiondata.count > 0{
                     self.collection.reloadData()
                        self.noMission.isHidden = true

                    }else{
                        self.noMission.isHidden = false
                    }
                 }else  {
                     self.showSwiftMessage(title: AlertTitle.warning, message: "", type: "error")
                 }
             }) { (error) in
                 self.stopAnimating()
                 self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
             }
         }
    


}
extension MissionCompletVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missiondata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MissionCompleteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MissionCompleteCell", for: indexPath) as! MissionCompleteCell
        
         let url = URL(string: missiondata[indexPath.row].missions[0].outcomes.badgeImage)
                    cell.img.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
                    cell.prdName.text = missiondata[indexPath.row].gameName
                   
                    cell.points.text = "\(missiondata[indexPath.row].missions[0].outcomes.points ?? 0)"+" pts"
                    cell.rs.text = "R"+"\(getPoints.rs(point: missiondata[indexPath.row].missions[0].outcomes.points))"
        
         return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let collectionWidth = collectionView.bounds.width
    //        let collectioHeight = collectionView.bounds.height
            return CGSize(width: collectionWidth/2, height:270)
            
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
}
