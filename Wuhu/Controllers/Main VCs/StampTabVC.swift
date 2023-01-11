//
//  StampTabVC.swift
//  Wuhu
//
//  Created by afrazali on 28/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit


class StampTabVC: BaseVC {
    
    
    
    
    @IBOutlet weak var promoCollection: UICollectionView!
    @IBOutlet weak var promoCollection2: UICollectionView!
    @IBOutlet weak var StampCollection: UICollectionView!
    @IBOutlet weak var bottomCollection: UICollectionView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var NoStamp: UILabel!
    @IBOutlet weak var scrool: UIScrollView!
    
    @IBOutlet weak var dlgRs: UILabel!
    @IBOutlet weak var dlgPts: UILabel!
    @IBOutlet weak var dlgView: pointDialouge!
    
    @IBOutlet weak var topBar: TopBarView!
    
    var refreshControl:UIRefreshControl!
    var myData : [StampCardsData] = []
    var promoData = [PromoDatum]()
    var brandData = [Brand]()
    var myCollectionCount = 0
    var arry = [21, 5]
    
    var buttonTag:Int!
    var myCount = 0
    var myPoints = 0
    var myQuantity = 0
    var myImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        AppDelegate.IsNotification = true
//        playSound()
        Applicationevents.postInfo(string: "Stamps")
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrool.refreshControl = refreshControl
        loadTableData()
        getPromo()
        getBrand()
       /* if AppDelegate.IsNotification {
            //            self.view.isHidden = true
            
            if AppDelegate.data.receiptId != 0 {
                AppDelegate.IsNotification = false
                let storyboard: UIStoryboard = UIStoryboard(name: "Scan", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "ScanResult") as! ScanResult
                homeVC.data = AppDelegate.data
                self.navigationController?.pushViewController(homeVC, animated: true)
            }else{
                self.view.bringSubviewToFront(dlgView)
                dlgView.isHidden = false
                dlgPts.text = "\(AppDelegate.data.points ?? 0)" + " pts"
                dlgRs.text = "R"+"\(getPoints.rs(point: AppDelegate.data.points))"
                
            }
        }*/
        self.checkNotificaion(view: dlgView)
//        self.points(view: dlgView)
//        if AppDelegate.IsNotification{
//            points(view: dlgView)
//            AppDelegate.IsNotification = false
//        }
        topBar.logo.isHidden = false
    }
    
    @objc func refresh()
    {
        // Code to refresh table view
        refreshControl.endRefreshing()
        //        self.getHomePageApi()
        loadTableData()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        pts.text = "  "+"\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        //        pts.text = "3000 pts"
        //        rs.text = "R300"
        
        self.TopBarMenu(view: topBar)
        
        if AppDelegate.IsScanned == false && pointsView.isHidden == false{
            pointsView.isHidden = true
        }
    }
    @IBAction func scanActionTop(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScanTabVC") as! ScanTabVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
   /* @IBAction func dlgClose(_ sender: Any) {
        dlgView.isHidden = true
        updatePoints(val: AppDelegate.data.points)
        
        
    }*/
//    func updatePoints(val:Int) {
//        let total = (self.Shared.userInfo?.totalPoint ?? 0) + val
//        self.Shared.userInfo?.totalPoint = total
//        self.Shared.userInfo?.rs = getPoints.rs(point: total)
//        pts.text = "\(total)"+" pts"
//        rs.text = "R"+"\(getPoints.rs(point: total))"
//    }
    func loadTableData(){
        
        self.showLoader()
        
        UserHandler.getStampData(userID: KC_userID ,success: { (successResponse) in
            self.stopAnimating()
            
            if successResponse.status == true {
                if successResponse.data!.count > 0 {
                    self.myData = successResponse.data!
                    
                    self.StampCollection.reloadData()
                }else{
                    self.NoStamp.isHidden = false
                }
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func getPromo(){
        
        self.showLoader()
        
        UserHandler.getpromo(success: { (successResponse) in
//            self.stopAnimating()
            
            if successResponse.status == true {
                self.promoData = successResponse.data
                self.promoCollection2.reloadData()
                
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    func getBrand(){
        
        self.showLoader()
        
        UserHandler.getbrands(success: { (successResponse) in
//            self.stopAnimating()
            
            if successResponse.status == true {
                self.brandData = successResponse.data.brands
                self.bottomCollection.reloadData()
                
            }else {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
            }
            
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
}

extension StampTabVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == promoCollection {
            return 3
        }else if collectionView == StampCollection{
            return myData.count
        }else if collectionView == promoCollection2{
            return promoData.count
        }else if collectionView == bottomCollection{
            return brandData.count
        }else{
            return myCount+1
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == promoCollection {
            let cell = promoCollection.dequeueReusableCell(withReuseIdentifier: "promoCell", for: indexPath) as! promoCell
            cell.btn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
            cell.btn.tag = indexPath.row
            
            if indexPath.row == 0 {
                cell.btn.setTitle("OPEN SCANNER", for: .normal)
                cell.btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                cell.btnImg.image = UIImage(named: "stampblue_btn")
                cell.card.image = UIImage(named: "stampiimg")
            }else if indexPath.row == 1 {
                cell.btn.setTitle("CLICK TO MISSIONS", for: .normal)
                cell.btnImg.image = UIImage(named: "stampyellow_btn")
                cell.card.image = UIImage(named: "stamp3img")
            }else if indexPath.row == 2{
                cell.btn.setTitle("VIEW STAMP CARDS", for: .normal)
                cell.btnImg.image = UIImage(named: "stampyellow_btn")
                cell.card.image = UIImage(named: "stampimg1")
            }
            return cell
        }else if collectionView == StampCollection{
            let cell = StampCollection.dequeueReusableCell(withReuseIdentifier: "StampCollectionCell", for: indexPath) as! StampCollectionCell
            let url = URL(string: myData[indexPath.row].image!)
            cell.badge.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
            
            cell.info.addTarget(self, action: #selector(flipCard(sender:)), for: .touchUpInside)
            cell.info.tag = indexPath.row
            
            cell.name.text = myData[indexPath.row].name
            cell.desc.text = myData[indexPath.row].description
            cell.count.text = "\(indexPath.row+1) / \(myData.count)"
            if myData[indexPath.row].quantity == myData[indexPath.row].punch_card_count{
                cell.background.image = UIImage(named: "bg_y")
            }
            cell.linearProgressView.setProgress(Float(myData[indexPath.row].quantity ?? 0), animated: true)
            cell.linearProgressView.maximumValue = Float(myData[indexPath.row].punch_card_count ?? 0)
            cell.progress.text = "\(myData[indexPath.row].quantity ?? 0)/\(myData[indexPath.row].punch_card_count ?? 0)"
            if buttonTag == indexPath.row{
                cell.background.image = UIImage(named: "flipbg_b")
                cell.gridCollection.delegate = self
                cell.gridCollection.dataSource = self
                
                myCount = myData[indexPath.row].punch_card_count ?? 0
                cell.punchCardCount = myData[indexPath.row].punch_card_count ?? 0
                cell.pointsCount = myData[indexPath.row].points
                myPoints = myData[indexPath.row].points ?? 0
                myImage = cell.badge.image
                myQuantity = myData[indexPath.row].quantity ?? 0
                
                cell.count.isHidden = true
                cell.badge.isHidden = true
                cell.name.isHidden = true
                cell.desc.isHidden = true
                cell.progressBg.isHidden = true
                cell.linearProgressView.isHidden = true
                cell.progress.isHidden = true
                cell.swap.isHidden = true
                
                cell.swapFlip.isHidden = false
                cell.terms.isHidden = false
                
                cell.gridCollection.isHidden = false
                cell.gridCollection.reloadData()
            }else{
                cell.background.image = UIImage(named: "bg_b")
                //                cell.grid.delegate = nil
                //                cell.grid.dataSource = nil
                
                cell.count.isHidden = true
                cell.badge.isHidden = false
                cell.name.isHidden = false
                cell.desc.isHidden = false
                cell.progressBg.isHidden = false
                cell.linearProgressView.isHidden = false
                cell.progress.isHidden = false
                cell.swap.isHidden = false
                cell.swapFlip.isHidden = true
                cell.terms.isHidden = true
                cell.gridCollection.isHidden = true
            }
            return cell
        }else if collectionView == promoCollection2{
            let cell = promoCollection2.dequeueReusableCell(withReuseIdentifier: "PromoCell", for: indexPath) as! PromoCell
            
            let url = URL(string: promoData[indexPath.row].image!)
            cell.logo.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
            
            cell.title.text = promoData[indexPath.row].title
            cell.desc.text = promoData[indexPath.row].descriptionField
            
            
            return cell
        }else if collectionView == bottomCollection{
            let cell = bottomCollection.dequeueReusableCell(withReuseIdentifier: "stamp2Cell", for: indexPath) as! stamp2Cell
            let url = URL(string: brandData[indexPath.row].image!)
            cell.card.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
            //            if indexPath.row%2 == 0{
            //                cell.card.image = UIImage(named: "brand1")
            //            }else{
            //                cell.card.image = UIImage(named: "brand2")
            //            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! gridCell
            
            cell.outer.layer.cornerRadius = 5
            cell.outer.layer.borderWidth = 1
            cell.outer.tintColor = UIColor.white
            cell.outer.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.outer.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            if indexPath.row < myQuantity{
                cell.logo.image = myImage
            }else{
                cell.logo.image = nil
            }
            cell.count.text = "\(indexPath.row+1)"
            if indexPath.row == myCount {
                cell.outer.backgroundColor = UIColor.clear
                cell.free.isHidden = false
                cell.rs.isHidden = false
                cell.bg.isHidden = false
                cell.rs.text = "R"+"\(getPoints.rs(point: myPoints))"
            }else{
                cell.outer.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
                cell.free.isHidden = true
                cell.rs.isHidden = true
                cell.bg.isHidden = true
                
            }
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bottomCollection {
            
            
            let collectionWidth = collectionView.bounds.width
            let collectioHeight = collectionView.bounds.height
            return CGSize(width: collectionWidth/2, height: collectioHeight/4)
        } else if collectionView == StampCollection{
            let collectionWidth = collectionView.bounds.width
            let collectioHeight = collectionView.bounds.height
            return CGSize(width: collectionWidth/1.2, height: collectioHeight)
        }else if collectionView == promoCollection{
            let collectionWidth = collectionView.bounds.width
            let collectioHeight = collectionView.bounds.height
            return CGSize(width: collectionWidth/1.18, height: collectioHeight)
        }else if collectionView == promoCollection2{
            let collectionWidth = collectionView.bounds.width
            let collectioHeight = collectionView.bounds.height
            return CGSize(width: collectionWidth/1.2, height: collectioHeight)
        }else{
            let collectionWidth = collectionView.bounds.width
            let collectioHeight = collectionView.bounds.height
            
            //            let size = collectionWidth/CGFloat(myCount+1)
            if myCount >= 20{
                return CGSize(width: collectionWidth/5, height: collectioHeight/5.2)
            }else{
                return CGSize(width: collectionWidth/4, height: collectioHeight/5)
            }
        }
        
        
    }
    
    
    //      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //          return 0
    //      }
    //      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //          return 0
    //      }
    @objc func connected(sender: UIButton){
        
        let buttonTag = sender.tag
        if buttonTag == 2{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Stamp2Vc") as! Stamp2Vc
            self.navigationController?.pushViewController(vc, animated: true)
        }else if buttonTag == 1{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MissionsTabVC") as! MissionsTabVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if buttonTag == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScanTabVC") as! ScanTabVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //        let objToBeSent = missiondata[buttonTag].missions[0].outcomes
        //           NotificationCenter.default.post(name: Notification.Name("GoToMissionInfo"), object: objToBeSent)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bottomCollection{
            let storyboard: UIStoryboard = UIStoryboard(name: "PoliciesAndHowTo", bundle: Bundle.main)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ParticipatingProducts") as! ParticipatingProducts
            ProductAll.selectedVal = indexPath.row
            print(indexPath.row)
            self.navigationController?.pushViewController(profileVC, animated: true)
        }else if collectionView == promoCollection2{
            print(promoData[indexPath.row].url!)
//            guard let url = URL(string: promoData[indexPath.row].url!) else { return }
//            UIApplication.shared.open(url)
           
            if promoData[indexPath.row].url == "" {
                
            }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Initial", bundle: Bundle.main)
            let activityVC = storyboard.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
            activityVC.html = promoData[indexPath.row].url!
            self.navigationController?.pushViewController(activityVC, animated: true)
            }
        }
    }
    @objc func flipCard(sender: UIButton){
        
        if sender.tag == buttonTag{
            buttonTag = 20000
        }else{
            
            buttonTag = sender.tag
        }
        
        //        if buttonTag.contains(sender.tag){
        //            buttonTag.remove(object: sender.tag)
        //        }else{
        //        buttonTag.append(sender.tag)
        //        }
        StampCollection.reloadData()
        StampCollection.delegate = self
        StampCollection.dataSource = self
        
        
    }
    
}
class promoCell: UICollectionViewCell {
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btnImg: UIImageView!
    @IBOutlet weak var card: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

/*extension StampTabVC: UITableViewDelegate, UITableViewDataSource {
 
 
 func numberOfSections(in tableView: UITableView) -> Int {
 return 1
 }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 //  return myData.count
 return 3
 
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
 {
 
 //        let numOfRows = ceil(CGFloat(myData[indexPath.row].punch_card_count!) / 5)
 //        print(numOfRows)
 //
 //        let extraSpace = numOfRows * 20 + 20
 //
 //        let rowHeigt = CGFloat(numOfRows * 50 + extraSpace + 100)
 //        return rowHeigt
 
 return UITableView.automaticDimension
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
 let cell : DynamicTableCell = tableView.dequeueReusableCell(withIdentifier: String(describing : DynamicTableCell.self)) as! DynamicTableCell
 
 //cell.populateData(obj: self.myData[indexPath.row], cnt: self.arry[indexPath.row])
 if indexPath.row == 0 {
 cell.imgMid.image = #imageLiteral(resourceName: "dr_blue")
 cell.imgBottom.image = #imageLiteral(resourceName: "dr_blue_d")
 }else if indexPath.row == 1 {
 cell.imgMid.image = #imageLiteral(resourceName: "blue")
 cell.imgBottom.image = #imageLiteral(resourceName: "blue_d")
 }else {
 cell.imgMid.image = #imageLiteral(resourceName: "green")
 cell.imgBottom.image = #imageLiteral(resourceName: "green_d")
 }
 return cell
 }
 }*/


/*class DynamicTableCell: UITableViewCell {
 
 @IBOutlet weak var collection: UICollectionView!
 @IBOutlet weak var collectionHeight: NSLayoutConstraint!
 
 @IBOutlet weak var baseView: CardView!
 
 @IBOutlet weak var img: UIImageView!
 @IBOutlet weak var tit: UILabel!
 @IBOutlet weak var imgMid: UIImageView!
 @IBOutlet weak var imgBottom: UIImageView!
 
 var collectionCount = 0
 
 override func awakeFromNib() {
 super.awakeFromNib()
 }
 
 override func setSelected(_ selected: Bool, animated: Bool) {
 super.setSelected(selected, animated: animated)
 
 }
 
 override func layoutSubviews() {
 super.layoutSubviews()
 //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
 self.collection.layer.masksToBounds = true
 self.collection.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
 }
 
 
 func populateData(obj: StampCardsData, cnt: Int){
 
 self.collectionCount = obj.punch_card_count! //cnt
 self.baseView.drawBorder(width: 0.5, color:  #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9058823529, alpha: 1))
 
 self.tit.text = obj.name
 if obj.image != nil {
 let imgUrl = GlobalURL.imgPath + obj.image!
 self.img.sd_setImage(with: URL(string: imgUrl), placeholderImage:UIImage(named: "placeholder"))
 }
 
 let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
 layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
 let widthh = self.collection.frame.width/6.0
 layout.itemSize = CGSize(width: widthh, height: widthh)
 layout.minimumInteritemSpacing = 8
 layout.scrollDirection = .vertical
 self.collection.isScrollEnabled = false
 
 self.collection.collectionViewLayout = layout
 self.collection.delegate = self
 self.collection.dataSource = self
 let numOfRows = ceil(CGFloat(self.collectionCount) / 5)
 print(numOfRows)
 let extraSpace = numOfRows * 14 + 14
 print(numOfRows * 50 + extraSpace)
 self.collectionHeight.constant = CGFloat(numOfRows * 50 + extraSpace)
 
 self.collection.reloadData()
 
 }
 }
 
 extension DynamicTableCell : UICollectionViewDelegate, UICollectionViewDataSource {
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
 return self.collectionCount
 }
 
 func numberOfSections(in collectionView: UICollectionView) -> Int {
 return 1
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 let cell = collection.dequeueReusableCell(withReuseIdentifier: "StampCell", for: indexPath) as! StampCell
 
 return cell
 }
 
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 }
 
 }
 
 extension DynamicTableCell: UICollectionViewDelegateFlowLayout {
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
 let myWidth = self.collection.frame.width/6.0
 return CGSize(width: (myWidth), height: (myWidth))
 }
 
 /// Formats the insets for the various headers and sections.
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
 return UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10)
 }
 }*/


