//
//  HomeTabVC.swift
//  Wuhu
//
//  Created by afrazali on 28/01/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import LinearProgressView
import AVKit
import AVFoundation

class HomeTabVC: BaseVC {
        
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageControl1: UIPageControl!

    @IBOutlet weak var missionCollection: UICollectionView!
    @IBOutlet weak var promoCollection: UICollectionView!

    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var noMission: UILabel!
    
    @IBOutlet weak var dlgRs: UILabel!
    @IBOutlet weak var dlgPts: UILabel!
    @IBOutlet weak var dlgView: UIView!
    var currentItem = 0
    
    var promoCollectionMargin = CGFloat(10)
    var promoItemSpacing = CGFloat(10)
    var promoItemHeight = CGFloat(220)
    var promoItemWidth = CGFloat(0)
    
    
    var missionCollectionMargin = CGFloat(45)
    var missionItemSpacing = CGFloat(-10)
    var missionItemHeight = CGFloat(440)
    var missionItemWidth = CGFloat(0)
    var missiondata = [MissionDatum]()
    var data: ReceiptDataModel!
    
    let vc = AVPlayerViewController()
    var VideoId = 0
    var survayId = ""
    
    @IBOutlet weak var survayDlg: UIView!
    @IBOutlet weak var survaylogo: UIImageView!
    @IBOutlet weak var survaydlgTitle: UILabel!
    @IBOutlet weak var survaydlgdesc: UILabel!
    @IBOutlet weak var survaydlgRs: UILabel!
    @IBOutlet weak var survaydlgPts: UILabel!
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
                btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
                self.setUpCustomCollections()
        //        pageControl.itemSpacing = 1.0 + CGFloat(0.48*8.0)
                pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                Applicationevents.postInfo(string: "home")
                getMissions()
        
        if AppDelegate.IsNotification {
//            self.view.isHidden = true
            AppDelegate.IsNotification = false
            let storyboard: UIStoryboard = UIStoryboard(name: "Scan", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "ScanResult") as! ScanResult
            homeVC.data = AppDelegate.data
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        else{

        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
        rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
    }
    override func viewDidAppear(_ animated: Bool) {
//        callScan()
    }
    // MARK: - Custom Functions

    func setUpCustomCollections(){
        
        setUpMissionCollection()
        setUpPromoCollection()
    }
    func callScan() {
        if AppDelegate.IsNotification {
            self.view.isHidden = true
            AppDelegate.IsNotification = false
            let storyboard: UIStoryboard = UIStoryboard(name: "Scan", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "ScanResult") as! ScanResult
            homeVC.data = AppDelegate.data
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    func getMissions(){
                self.showLoader()
                UserHandler.getMissions(success: { (successResponse) in
                    self.stopAnimating()
                    if successResponse.status == true {
                       for i in successResponse.data.indices{
                        if successResponse.data[i].missions.count > 0{
                           if !successResponse.data[i].missions[0].completed{
                               self.missiondata.append(successResponse.data[i])
                           }
                        }
                       }
                        if self.missiondata.count == 0 {
                            self.noMission.isHidden = false
                        }else{
                            self.noMission.isHidden = true
                        self.missionCollection.reloadData()
                        }
//                        self.callScan()
                    }else  {
                        self.showSwiftMessage(title: AlertTitle.warning, message: "", type: "error")
                    }
                }) { (error) in
                    self.stopAnimating()
                    self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
                }
            }
    func setUpMissionCollection() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        missionItemWidth =  UIScreen.main.bounds.width - missionCollectionMargin * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: missionItemWidth, height: missionItemHeight)
        layout.headerReferenceSize = CGSize(width: missionCollectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: missionCollectionMargin, height: 0)
        
        layout.minimumLineSpacing = missionItemSpacing
        layout.scrollDirection = .horizontal
        missionCollection!.collectionViewLayout = layout
        missionCollection?.decelerationRate = UIScrollView.DecelerationRate.fast
        
    }
    
    func setUpPromoCollection() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        promoItemWidth =  UIScreen.main.bounds.width - promoCollectionMargin * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: promoItemWidth, height: promoItemHeight)
        layout.headerReferenceSize = CGSize(width: promoCollectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: promoCollectionMargin, height: 0)
        
        layout.minimumLineSpacing = promoItemSpacing
        layout.scrollDirection = .horizontal
        promoCollection!.collectionViewLayout = layout
        promoCollection?.decelerationRate = UIScrollView.DecelerationRate.fast
        
    }
    func playVideo(url: URL, id: Int) {
        let player = AVPlayer(url: url)
        VideoId = id
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: vc.player?.currentItem)
        
        
        vc.player = player
        vc.showsPlaybackControls = false
        
        self.present(vc, animated: true) { self.vc.player?.play() }
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
     self.vc.dismiss(animated: true)
        sendId(id: VideoId)
        
    }
    func sendId(id:Int){
        
        var parameters : [String: Any]
        parameters = [
            "video_id"              : id,
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.VideoEvent(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.Shared.userInfo?.totalPoint = (self.Shared.userInfo?.totalPoint)! + successResponse.points
                self.Shared.userInfo?.rs = (self.Shared.userInfo?.rs)! + getPoints.rs(point: successResponse.points)
                self.dlgPts.text = "\(successResponse.points ?? 0)" + " pts"
                self.dlgRs.text = "R"+"\(getPoints.rs(point: successResponse.points))"
                self.view.bringSubviewToFront(self.dlgView)
                self.dlgView.isHidden = false
            }else  {
                
                self.showSwiftMessage(title: AlertTitle.warning, message:successResponse.message, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    @IBAction func actionRewardStore(_ sender: Any) {
        let rs = self.storyboard?.instantiateViewController(identifier: "RewardStoreVC") as! RewardStoreVC
        rs.comesFrom = "wallet"
        self.navigationController?.pushViewController(rs, animated: true)
        
        
//        self.pushController(name: "RewardStoreVC")
    }
        @IBAction func actionDlgCont(_ sender: Any) {

            AppDelegate.moveToHome()
        }

    @IBAction func survayDlgCancel(_ sender: Any) {
    
        survayDlg.isHidden = true
        
    }
    @IBAction func survayDlgstart(_ sender: Any) {
        survayDlg.isHidden = true
        let storyboard: UIStoryboard = UIStoryboard(name: "Initial", bundle: Bundle.main)
        let activityVC = storyboard.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
        activityVC.html = GlobalURL.quizBaseUrl+"survey-form?id="+survayId+"&user_id="+"\(self.Shared.userInfo?.user_id ?? 0)"
        self.navigationController?.pushViewController(activityVC, animated: true)
           
       }
    @IBAction func scanActionTop(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScanTabVC") as! ScanTabVC
        self.navigationController?.pushViewController(vc, animated: true)
       }
    
}

extension HomeTabVC : UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == missionCollection {
            self.pageControl.numberOfPages = missiondata.count
            return missiondata.count
        }else  {
            self.pageControl1.numberOfPages = 8
            return 8
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == missionCollection {
            
            let cell1 = missionCollection.dequeueReusableCell(withReuseIdentifier: "MissionCell", for: indexPath) as! MissionCell
            let url = URL(string: missiondata[indexPath.row].missions[0].outcomes.badgeImage)
            cell1.badge.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
            cell1.name.text = missiondata[indexPath.row].gameName
            cell1.desc.text = missiondata[indexPath.row].missions[0].missionDesc
            cell1.points.text = "\(missiondata[indexPath.row].missions[0].outcomes.points ?? 0)"+" pts"
            cell1.rs.text = "R"+"\(getPoints.rs(point: missiondata[indexPath.row].missions[0].outcomes.points))"
            cell1.linearProgressView.setProgress(Float(missiondata[indexPath.row].missions[0].outcomes.percentage), animated: true)
            cell1.progress.text = "\(missiondata[indexPath.row].missions[0].outcomes.percentage ?? 0)"+"%"
            return cell1
        }else  {
            let cell = promoCollection.dequeueReusableCell(withReuseIdentifier: "PromoCell", for: indexPath) as! PromoCell

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if collectionView == missionCollection {
            print(missiondata[indexPath.row].missions[0].survey_id ?? "")
            let id = missiondata[indexPath.row].missions[0].survey_id ?? ""
            
            
            let video = missiondata[indexPath.row].missions[0].video
            if (video != nil) {
                print(video?.vedioUrl ?? "")
                let url = URL(string: video?.vedioUrl ?? "")!

                playVideo(url: url, id: video?.videoId ?? 0)
            }else{
                
            }
            if id == ""{
                
            }else{
                let url = URL(string: missiondata[indexPath.row].missions[0].outcomes.badgeImage)
                survaylogo.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
                survaydlgTitle.text = missiondata[indexPath.row].gameName
                survaydlgdesc.text = missiondata[indexPath.row].missions[0].outcomes.stateName
                survaydlgPts.text = "\(missiondata[indexPath.row].missions[0].outcomes.points ?? 0)"+" pts"
                survaydlgRs.text = "R"+"\(getPoints.rs(point: missiondata[indexPath.row].missions[0].outcomes.points))"
                
                self.view.bringSubviewToFront(survayDlg)
                survayDlg.isHidden = false
                survayId = id
            }
            
        }
    }
}

extension HomeTabVC : UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView.tag == 0 {
            
            let missionPageWidth = Float(UIScreen.main.bounds.width - missionCollectionMargin * 2.0)//Float(missionItemWidth + missionItemSpacing)
            let targetXContentOffset = Float(targetContentOffset.pointee.x)
            let missionContentWidth = Float(missionCollection!.contentSize.width)
            var missionNewPage = Float(self.pageControl.currentPage)

            if velocity.x == 0 {
                missionNewPage = floor( (targetXContentOffset - Float(missionPageWidth) / 2) / Float(missionPageWidth)) + 1.0
            } else {
                missionNewPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
                if missionNewPage < 0 {
                    missionNewPage = 0
                }
                if (missionNewPage > missionContentWidth / missionPageWidth) {
                    missionNewPage = ceil(missionContentWidth / missionPageWidth) - 1.0
                }
            }

            self.pageControl.currentPage = Int(missionNewPage)
            let point = CGPoint (x: CGFloat(missionNewPage * missionPageWidth), y: targetContentOffset.pointee.y)
            targetContentOffset.pointee = point

        }else if scrollView.tag == 1{
            
            let promoPageWidth = Float(promoItemWidth + promoItemSpacing)
            let targetXContentOffset = Float(targetContentOffset.pointee.x)
            let promoContentWidth = Float(promoCollection!.contentSize.width)
            var promoNewPage = Float(self.pageControl1.currentPage)

            if velocity.x == 0 {
                promoNewPage = floor( (targetXContentOffset - Float(promoPageWidth) / 2) / Float(promoPageWidth)) + 1.0
            } else {
                promoNewPage = Float(velocity.x > 0 ? self.pageControl1.currentPage + 1 : self.pageControl1.currentPage - 1)
                if promoNewPage < 0 {
                    promoNewPage = 0
                }
                if (promoNewPage > promoContentWidth / promoPageWidth) {
                    promoNewPage = ceil(promoContentWidth / promoPageWidth) - 1.0
                }
            }

            self.pageControl1.currentPage = Int(promoNewPage)
            let point = CGPoint (x: CGFloat(promoNewPage * promoPageWidth), y: targetContentOffset.pointee.y)
            targetContentOffset.pointee = point

        }
    }
}

// Mission Collection Cell

class MissionCell: UICollectionViewCell {

    

    @IBOutlet var linearProgressView: LinearProgressView!
    @IBOutlet var badge: UIImageView!
    @IBOutlet var progressBg: UIImageView!
    @IBOutlet var swap: UIImageView!
    @IBOutlet var swapFlip: UIImageView!
    @IBOutlet var background: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var rs: UILabel!
    @IBOutlet var progress: UILabel!
    @IBOutlet var info: UIButton!
    @IBOutlet var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}


// Promo Collection Cell

class PromoCell: UICollectionViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var logo: UIImageView!

    @IBOutlet weak var lblPromo: UILabel!{
        didSet {
            self.lblPromo.setBorderWidth(borderWidth: 0, cornerRadius: 15, borderColor: #colorLiteral(red: 1, green: 0.9747149348, blue: 0.4545389414, alpha: 1))
        }
    }
    
    @IBOutlet weak var contentview: UIView!{
        didSet{
            self.layer.cornerRadius = 8
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
