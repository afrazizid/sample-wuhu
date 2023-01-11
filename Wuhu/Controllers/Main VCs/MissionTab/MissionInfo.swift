//
//  MissionInfo.swift
//  Wuhu
//
//  Created by Awais on 04/06/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MissionInfo: BaseVC {
    @IBOutlet var badge: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var rs: UILabel!
    @IBOutlet var dlgView: pointDialouge!
    @IBOutlet weak var dlgRs: UILabel!
    @IBOutlet weak var dlgPts: UILabel!
    @IBOutlet weak var start: UIButton!
    
    
    
    var outcome:Mission!
    var is_completed = false
    static var missionVc = false
    let vc = AVPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        if outcome.mission_type.contains("signup") || outcome.mission_type.contains("walk") || outcome.mission_type == ""{
            
            start.isHidden = true
        }
        let url = URL(string: outcome.outcomes.badgeImage)
        badge.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
        name.text = outcome.missionName
        desc.text = outcome.longDesc
        points.text = "\(outcome.outcomes.points ?? 0)"+" pts"
        rs.text = "R"+"\(getPoints.rs(point: outcome.outcomes.points))"
        
        // Do any additional setup after loading the view.
        checkNotificaion(view: dlgView)
        
    }
    override func dialougeAction() {
        NotificationCenter.default.post(name: Notification.Name("GoToMission"), object: "")
        self.popVC()
    }
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: vc.player?.currentItem)
        
        
        vc.player = player
        vc.showsPlaybackControls = false
        
        self.present(vc, animated: true) { self.vc.player?.play() }
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.vc.dismiss(animated: true)
        is_completed = true
        sendId(id: outcome.video?.videoId ?? 0)
        
    }
    
    @IBAction func close(_ sender:UIButton){
        NotificationCenter.default.post(name: Notification.Name("GoToMission"), object: "")
        self.moveBack()
        
    }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
//    @IBAction func actionDlgCont(_ sender: Any) {
//        NotificationCenter.default.post(name: Notification.Name("GoToMission"), object: "")
//        self.moveBack()
//    }
    @IBAction func survayDlgstart(_ sender: Any) {
        
        if outcome.mission_type.contains("survey"){
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Initial", bundle: Bundle.main)
            let activityVC = storyboard.instantiateViewController(withIdentifier: "MyWebViewViewController") as! MyWebViewViewController
            activityVC.html = GlobalURL.quizBaseUrl+"survey-form?id="+outcome.survey_id+"&user_id="+"\(self.Shared.userInfo?.user_id ?? 0)"
            self.navigationController?.pushViewController(activityVC, animated: true)
            
        }else if outcome.mission_type.contains("video"){
            
            if outcome.video?.vedioUrl == ""{
                self.showSwiftMessage(title: AlertTitle.warning, message: "Please add Vedio URL", type: "error")
               //
            }else{
            let url = URL(string: outcome.video?.vedioUrl ?? "")!
            is_completed = false
            sendId(id: outcome.video?.videoId ?? 0)
            playVideo(url: url)
            }
        }else if outcome.mission_type.contains("profile"){
            MissionInfo.missionVc = true
            let storyboard: UIStoryboard = UIStoryboard(name: "MyProfile", bundle: Bundle.main)
            let activityVC = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
            self.navigationController?.pushViewController(activityVC, animated: true)
            
        }else if outcome.mission_type.contains("scann"){
            MissionInfo.missionVc = true
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScanTabVC") as! ScanTabVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    func sendId(id:Int){
        
        var parameters : [String: Any]
        parameters = [
            "video_id"              : id,
            "is_completed"          : is_completed
        ]
        
        print(parameters)
        self.showLoader()
        UserHandler.VideoEvent(params: parameters as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                if self.is_completed  {
                    
                    
                    self.Shared.userInfo?.totalPoint = (self.Shared.userInfo?.totalPoint)! + successResponse.points
                    self.Shared.userInfo?.rs = (self.Shared.userInfo?.rs)! + getPoints.rs(point: successResponse.points)
//                    self.dlgPts.text = "\(successResponse.points ?? 0)" + " pts"
//                    self.dlgRs.text = "R"+"\(getPoints.rs(point: successResponse.points))"
//                    self.view.bringSubviewToFront(self.dlgView)
//                    self.dlgView.isHidden = false
                }
            }else  {
                
                self.showSwiftMessage(title: AlertTitle.warning, message:successResponse.message, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
}
