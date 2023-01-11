//
//  Stamp2Vc.swift
//  Wuhu
//
//  Created by Awais on 31/08/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import LinearProgressView

class Stamp2Vc: BaseVC {
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var prgImg: UIImageView!
    @IBOutlet weak var refreshR: UIImageView!
    @IBOutlet weak var StampCollection: UICollectionView!
    @IBOutlet var gridCollection: UICollectionView!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet var linearProgressView: LinearProgressView!
    @IBOutlet var badge: UIImageView!
    @IBOutlet var background: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var progress: UILabel!
    @IBOutlet var info: UIButton!
    @IBOutlet var refresh: UIButton!
    @IBOutlet var count: UILabel!
    @IBOutlet weak var NoStamp: UILabel!
    @IBOutlet var stamp: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrool: UIScrollView!
    var refreshControl:UIRefreshControl!

    var myData : [StampCardsData] = []
    var putData: StampCardsData!
    var counter = 0

    var direction:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        let val = 0.4
        print(val.rounded(.up))
        
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        loadTableData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh1), for: .valueChanged)
        scrool.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pts.text = "  "+"\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarMenu(view: topBar)
    }
    @IBAction func btnActionInfo(_ sender: UIButton) {
        if myData.count == 0{
            return
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StampInfo") as! StampInfo
        vc.putData = putData
        self.navigationController?.pushViewController(vc, animated: true)
          
    }
        @objc func refresh1()
        {
            // Code to refresh table view
            refreshControl.endRefreshing()
    //        self.getHomePageApi()
            loadTableData()

        }
    func loadTableData(){
        
        self.showLoader()
        
        UserHandler.getStampData(userID: KC_userID ,success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                if successResponse.data!.count > 0 {
                    self.myData = successResponse.data!
                    
                    var count = Float(self.myData.count)
                    
                    count = count/4
                    
                    self.pageControl.numberOfPages = Int(count.rounded(.up))
                    print(ceil(Float(7/4)))
                    print(self.myData.count)
                    self.StampCollection.reloadData()
                    

                    self.putData = self.myData[0]
                    self.putValues()
                }else{
                    self.NoStamp.isHidden = false
                    self.stamp.isHidden = true
                }
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    func putValues() {
        let url = URL(string: putData.image!)
        badge.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
        name.text = putData.name
        desc.text = putData.description
        count.text = "\(counter+1) / \(myData.count)"
        linearProgressView.setProgress(Float(putData.quantity ?? 0), animated: true)
        linearProgressView.maximumValue = Float(putData.punch_card_count ?? 0)
        progress.text = "\(putData.quantity ?? 0)/\(putData.punch_card_count ?? 0)"
        
        if putData.quantity == putData.punch_card_count{
            background.image = UIImage(named: "bg_y")
        }
        
    }
    @IBAction func flip(_ sender: Any) {

setView()
        
        
    }
    
    func setView(){
        if gridCollection.isHidden {
            background.image = UIImage(named: "flipbg_b")
            gridCollection.delegate = self
            gridCollection.dataSource = self
            gridCollection.reloadData()
            gridCollection.isHidden = false
            refreshR.isHidden = false
            hideVal(set: true)
        }else{
            gridCollection.isHidden = true
            refreshR.isHidden = true
            background.image = UIImage(named: "bg_b")
            hideVal(set: false)
            
        }
    }
    func hideVal(set:Bool) {
        
        badge.isHidden = set
        name.isHidden = set
        desc.isHidden = set
//        count.isHidden = set
        progress.isHidden = set
        linearProgressView.isHidden = set
        info.isHidden = set
        prgImg.isHidden = set
        refresh.isHidden = set
    }
}

extension Stamp2Vc: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == StampCollection{
        return myData.count
        }else{
            return putData.punch_card_count ?? 0 + 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(indexPath.row)
        if collectionView == StampCollection{
        let cell = StampCollection.dequeueReusableCell(withReuseIdentifier: "stamp2Cell", for: indexPath) as! stamp2Cell
        let url = URL(string: myData[indexPath.row].image!)
        cell.card.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
        
//        self.backgroundColor = #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1)
        cell.outer.layer.cornerRadius = 10
        cell.outer.layer.borderWidth = 2
        cell.outer.tintColor = UIColor.white
        if indexPath.row == counter {
            cell.outer.layer.borderColor = #colorLiteral(red: 0.7058823529, green: 0.1176470588, blue: 1, alpha: 1)
        }else{
        cell.outer.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        //            cell.name.text = myData[indexPath.row].name
        //            cell.desc.text = myData[indexPath.row].description
        //            cell.count.text = "\(indexPath.row+1) / \(myData.count)"
        
//        pageControl.currentPage = indexPath.row/4
        self.direction = self.StampCollection.contentOffset.x
        
        return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! gridCell
            
            cell.outer.layer.cornerRadius = 5
            cell.outer.layer.borderWidth = 1
            cell.outer.tintColor = UIColor.white
            cell.outer.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.outer.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            if indexPath.row < putData.quantity!{
                let url = URL(string: putData.image!)
                cell.logo.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
               
//                cell.logo.image = putData.image
            }else{
                cell.logo.image = nil
            }
            cell.count.text = "\(indexPath.row+1)"
            if indexPath.row == putData.punch_card_count ?? 0 {
                cell.outer.backgroundColor = UIColor.clear
                cell.free.isHidden = false
                cell.rs.isHidden = false
                cell.bg.isHidden = false
                cell.rs.text = "R"+"\(getPoints.rs(point: putData.points!))"
            }else{
                cell.outer.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
                cell.free.isHidden = true
                cell.rs.isHidden = true
                cell.bg.isHidden = true
                
            }
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gridCollection.isHidden = true
        refreshR.isHidden = true
        background.image = UIImage(named: "bg_b")
        hideVal(set: false)
        counter = indexPath.row
        putData = myData[indexPath.row]
        putValues()
        StampCollection.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == StampCollection{
        let collectionWidth = collectionView.bounds.width
        let collectioHeight = collectionView.bounds.height
        return CGSize(width: collectionWidth/2, height: collectioHeight/2)
        }else{
            let collectionWidth = collectionView.bounds.width
            let collectioHeight = collectionView.bounds.height
            
            //            let size = collectionWidth/CGFloat(myCount+1)
            if putData.punch_card_count ?? 0 >= 20{
                return CGSize(width: collectionWidth/5, height: collectioHeight/6.2)
            }else{
                return CGSize(width: collectionWidth/4, height: collectioHeight/6)
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == self.StampCollection {
             print(scrollView.contentOffset.x)
//            if direction > scrollView.contentOffset.x{
//                print("right")
//            }else{
//                print("left")
//            }
            // do something with collectionViewA
//        } else if scrollView == self.collectionViewB {
//            // do something with collectionViewB
//        } else {
            // unknown collectionView
        }
    }
}

class stamp2Cell: UICollectionViewCell {
    
    @IBOutlet var card: UIImageView!
    @IBOutlet var outer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

