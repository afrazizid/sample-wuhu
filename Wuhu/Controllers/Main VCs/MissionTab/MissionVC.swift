//
//  MissionVC.swift
//  Wuhu
//
//  Created by afrazali on 14/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import LinearProgressView


class MissionVC: BaseVC {
    
    @IBOutlet weak var missionTble: UITableView!
    var refreshControl:UIRefreshControl!
    
    var missions: MissionsModel!
    var missiondata = [MissionDatum]()
    var upcomingMission: UpcomingMission!
    
    var timer = Timer()

    var minutes = 0
    var second = 0
    var hours = 0
    var counter = 60
    var check = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionTble.isHidden = true
        Applicationevents.postInfo(string: "missions")
        getMissions()
//        startTimer()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh1), for: .valueChanged)
        missionTble.refreshControl = refreshControl
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("GoToMission"), object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func refresh1()
    {
        refreshControl.endRefreshing()
        getMissions()
        
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        
        getMissions()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
                getMissions()
    }
    override func viewDidAppear(_ animated: Bool) {
        //        getMissions()
    }
    
    func getMissions(){
        
        self.showLoader()
        UserHandler.getMissions(success: { (successResponse) in
            self.missiondata.removeAll()
            self.stopAnimating()
            if successResponse.status == true {
                self.upcomingMission = successResponse.upcoming
                for i in successResponse.data.indices{
                    if successResponse.data[i].missions.count > 0{
                        
                        if !successResponse.data[i].missions[0].completed{
                            //                self.missiondata = successResponse.data[i]
                            self.missiondata.append(successResponse.data[i])
                        }
                    }
                }
               /* if !self.check {
                    
                
                self.upcomingMission.startDate = "2021-01-19 12:11:10"
                }*/
                if self.upcomingMission.timeSecond != 0{
//                    self.myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
                    
                    let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds: self.upcomingMission.timeSecond)
                    self.hours = h
                    self.minutes = m
//                    self.second = s
                    self.counter = s
                    self.startTimer()
                }else{
                    self.endTimer()
                }
                    self.missionTble.isHidden = false
                self.missionTble.delegate = self
                self.missionTble.dataSource = self
                self.missionTble.reloadData()
            }else  {
                self.missionTble.isHidden = false
                self.showSwiftMessage(title: AlertTitle.warning, message: "", type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.missionTble.isHidden = false
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

//    @objc func updateTime() {
//
//
//
//         if counter != 0 {
//            counter -= 1
//            print(counter)
//         } else {
//            endTimer()
//         }
//     }

     func endTimer() {
         timer.invalidate()
//         timer = nil
     }

    @objc func updateCounter() {
//        counter = second
        missionTble.reloadData()
//        print(counter)
        
        if counter > 0{
            print("\(counter) seconds to the end of the world")
            counter -= 1
            return
        }
        
        if minutes > 0{
            minutes-=1
            counter = 60
            return
        }
        if hours > 0{
            hours-=1
            counter = 60
            return
        }
        if hours == 0 && minutes == 0 && counter == 0{
            getMissions()
            endTimer()
            return
        }
        
        return
    }
}

extension MissionVC: UITableViewDelegate, UITableViewDataSource {

    
   /* func dateCalculation(){
        let cal = Calendar.current
        let d1 = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let d2 = dateFormatter.date(from: upcomingMission.startDate)

//            let d2 = dateFormatter.date(from: "2021-01-19 10:10:10")
        let components2: Set<Calendar.Component> = [.second, .minute, .hour]
        let difference = cal.dateComponents(components2, from: d1, to: d2!)
        print(difference)

        diff = difference.hour ?? 0
        minutes = difference.minute ?? 0
        counter = difference.second ?? 0
    }*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if upcomingMission.timeSecond != 0{
            return 2
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 && upcomingMission.timeSecond != 0{
           return 1
        }
        if missiondata.count == 0 {
            return 1
        }else{
            return missiondata.count
        }
        

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 && upcomingMission.timeSecond != 0{
           
            let cell = missionTble.dequeueReusableCell(withIdentifier: "MissionCell4", for: indexPath) as! MissionCell4
        
//            dateCalculation()
            cell.hr.text = "\(hours)"
            if minutes < 0{
                cell.min.text = "0"
            }else{
            cell.min.text = "\(minutes)"
            }
            if counter < 0{
                cell.sec.text = "0"
            }else{
            cell.sec.text = "\(counter)"
            }
            
            return cell
        }
        if missiondata.count == 0{
            let cell4 = missionTble.dequeueReusableCell(withIdentifier: "MissionCell1", for: indexPath) as! MissionCell1
            return cell4
        }else {
            
            let cell1 = missionTble.dequeueReusableCell(withIdentifier: "MissionCell2", for: indexPath) as! MissionCell2
            //            if missiondata[indexPath.row].missions[0].completed == false{
            let url = URL(string: missiondata[indexPath.row].missions[0].outcomes.badgeImage)
            cell1.badge.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
            cell1.name.text = missiondata[indexPath.row].gameName
            cell1.desc.text = missiondata[indexPath.row].missions[0].missionDesc
            cell1.points.text = "\(missiondata[indexPath.row].missions[0].outcomes.points ?? 0)"+" pts"
            cell1.rs.text = "R"+"\(getPoints.rs(point: missiondata[indexPath.row].missions[0].outcomes.points))"
            cell1.linearProgressView.setProgress(Float(missiondata[indexPath.row].missions[0].outcomes.percentage), animated: true)
            cell1.progress.text = "\(missiondata[indexPath.row].missions[0].outcomes.percentage ?? 0)"+"%"
            cell1.info.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
            cell1.info.tag = indexPath.row
            //            }
            return cell1
            /*    }else if missiondata[indexPath.row].missions[0].completed == true {
             
             let cell1 = missionTble.dequeueReusableCell(withIdentifier: "MissionCell3", for: indexPath) as! MissionCell3
             let url = URL(string: missiondata[indexPath.row].missions[0].outcomes.badgeImage)
             cell1.badge.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
             cell1.name.text = missiondata[indexPath.row].missions[0].outcomes.badgeName
             cell1.desc.text = missiondata[indexPath.row].missions[0].outcomes.stateName
             cell1.points.text = "\(missiondata[indexPath.row].missions[0].outcomes.points ?? 0)"+" pts"
             cell1.rs.text = "R"+"\(getPoints.rs(point: missiondata[indexPath.row].missions[0].outcomes.points))"
             cell1.linearProgressView.setProgress(Float(missiondata[indexPath.row].missions[0].outcomes.percentage), animated: true)
             //            cell1.progress.text = "\(missiondata[indexPath.row].missions[0].outcomes.percentage ?? 0)"
             //            cell1.info.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
             //            cell1.info.tag = indexPath.row
             return cell1
             }else{
             let cell1 = missionTble.dequeueReusableCell(withIdentifier: "MissionCell2", for: indexPath) as! MissionCell2
             return cell1*/
        }
        //        }else if indexPath.row == 1 {
        //            let cell2 = missionTble.dequeueReusableCell(withIdentifier: "MissionCell2", for: indexPath) as! MissionCell2
        //            return cell2
        //        }else if indexPath.row == 1{
        //            let cell3 = missionTble.dequeueReusableCell(withIdentifier: "MissionCell3", for: indexPath) as! MissionCell3
        //            return cell3
        //        }else {
        //            let cell4 = missionTble.dequeueReusableCell(withIdentifier: "MissionCell4", for: indexPath) as! MissionCell4
        //            return cell4
        //        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buttonTag = indexPath.row
        let objToBeSent = missiondata[buttonTag].missions[0]
        NotificationCenter.default.post(name: Notification.Name("GoToMissionInfo"), object: objToBeSent)
        
    }
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        let objToBeSent = missiondata[buttonTag].missions[0]
        NotificationCenter.default.post(name: Notification.Name("GoToMissionInfo"), object: objToBeSent)
        
    }
    
}


class MissionCell1: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
    }
    
}

class MissionCell2: UITableViewCell {
    
    @IBOutlet var linearProgressView: LinearProgressView!
    @IBOutlet var badge: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var rs: UILabel!
    @IBOutlet var progress: UILabel!
    @IBOutlet var info: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
    }
    
}

class MissionCell3: UITableViewCell {
    
    @IBOutlet var linearProgressView: LinearProgressView!
    @IBOutlet var badge: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var rs: UILabel!
    @IBOutlet var progress: UILabel!
    @IBOutlet var info: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
    }
    
}

class MissionCell4: UITableViewCell {
    
    @IBOutlet var hr: UILabel!
    @IBOutlet var min: UILabel!
    @IBOutlet var sec: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0))
    }
    
}
