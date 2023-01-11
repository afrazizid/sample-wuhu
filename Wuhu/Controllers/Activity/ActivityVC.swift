//
//  ActivityVC.swift
//  Wuhu
//
//  Created by afrazali on 05/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import AAFragmentManager
import Koyomi
import FSCalendar

class ActivityVC: BaseVC {
    
    @IBOutlet weak var childView: AAFragmentManager!
    @IBOutlet var btnAll: UIButton!
    @IBOutlet var btnPoints: UIButton!
    @IBOutlet var btnVoucher: UIButton!
    @IBOutlet var btnStemp: UIButton!
    
    
    @IBOutlet var lblMonth: UILabel!
    @IBOutlet var lblYear: UILabel!
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bgTopView: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var btnCalender: UIButton!
    
    @IBOutlet weak var monthCollection: UICollectionView!
    
    fileprivate let invalidPeriodLength = 90
    let df = DateFormatter()
    
    @IBOutlet fileprivate weak var koyomi: Koyomi!
    var indx :Int = 0
    var monthIndex = 0
    
    // FSCalender
    @IBOutlet weak var fscalender: FSCalendar!
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    var scrollVal:Float = 480.0
    fileprivate weak var eventLabel: UILabel!
    
    var monthArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthArr = ["January","February","March","April","May","June","July", "August", "September", "October", "November", "December",""]
        self.dateViewSetup()
        scrollViewHeight.constant = CGFloat(scrollVal)
        self.setTab()
        
        setUpFSCalender()
        Applicationevents.postInfo(string: "my_activity")
//        setUpKoyomi()
        
    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationImage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedHeight(notification:)), name: Notification.Name("scroll"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("Value of notification : ", notification.object ?? "")
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageShowVc") as! ImageShowVc
        //        vc.imgString = notification.object as! String
        
        let storyboard = UIStoryboard(name: "Scan", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SubmittedTillSlip2") as! SubmittedTillSlip
        vc.board = 2
        vc.receiptId = notification.object as? Int
        self.navigationController?.pushViewController(vc, animated: true)
        //                (MainTabBarVC.currentInstance?.selectedViewController as? UINavigationController)?.pushViewController(vc, animated: true)
    }
    @objc func methodOfReceivedHeight(notification: Notification) {
        print("Value of height : ", notification.object ?? "")
        let val = notification.object as! NSNumber
        scrollViewHeight.constant = CGFloat(scrollVal) + CGFloat(truncating: val)
    }
    
    // MARK: - Custom Functions
    
    func scrollHeight() {
        
        if indx == 0{
            
        }
    }
    
    // MARK: - Utility -
    
    fileprivate func date(_ date: Date, later: Int) -> Date {
        var components = DateComponents()
        components.day = later
        return (Calendar.current as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options(rawValue: 0)) ?? date
    }
    
    func configureStyle(_ style: KoyomiStyle) {
        koyomi.style = style
        koyomi.reloadData()
    }
    func dateViewSetup() {
        
        self.topViewHeight.constant = 285
        self.bgTopView.image = UIImage(named: "bg-editProfile")
        self.imgArrow.transform = .identity
        
        let currentDate = Date()
        
        var currentMonth = "January"
        if currentDate.month == 1{
            currentMonth = "January"
        }else if currentDate.month == 2{
            currentMonth = "February"
        }else if currentDate.month == 3{
            currentMonth = "March"
        }else if currentDate.month == 4{
            currentMonth = "April"
        }else if currentDate.month == 5{
            currentMonth = "May"
        }else if currentDate.month == 6{
            currentMonth = "June"
        }else if currentDate.month == 7{
            currentMonth = "July"
        }else if currentDate.month == 8{
            currentMonth = "August"
        }else if currentDate.month == 9{
            currentMonth = "September"
        }else if currentDate.month == 10{
            currentMonth = "October"
        }else if currentDate.month == 11{
            currentMonth = "November"
        }else  {
            currentMonth = "December"
        }
        
        monthIndex = currentDate.month
        monthCollection.delegate = self
        monthCollection.reloadData()
        monthCollection.layoutIfNeeded()
        self.monthCollection.scrollToItem(at:IndexPath(item: monthIndex, section: 0), at: .right, animated: false)
        self.lblMonth.text = currentMonth
        self.lblYear.text = "\(currentDate.year)"
    }
    
    func setTab(){
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let identifiers: [String] = ["AllActivityVC", "PointsActivityVC", "VoucherActivityVC", "StampActivityVC"]
        let arrayVC = getViewControllers(identifiers)
        
        
        childView.initManager(viewControllers: arrayVC)
        
        childView.transition.type = .fade
        
        self.btnAll.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
        self.btnAll.setTitleColor(UIColor.white, for: .normal)
        
        self.btnPoints.backgroundColor = UIColor.clear
        self.btnPoints.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
        
        self.btnVoucher.backgroundColor = UIColor.clear
        self.btnVoucher.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
        
        self.btnStemp.backgroundColor = UIColor.clear
        self.btnStemp.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
        
        self.btnAll.layer.cornerRadius = 20
        self.btnPoints.layer.cornerRadius = 20
        self.btnVoucher.layer.cornerRadius = 20
        self.btnStemp.layer.cornerRadius = 20
        
    }
    
    func getViewControllers(_ identifiers: [String]) -> [UIViewController] {
        var viewControllers = [UIViewController]()
        identifiers.forEach { (id) in
            let storyboard: UIStoryboard = UIStoryboard(name: "Activity", bundle: nil)
            viewControllers.append(storyboard.instantiateViewController(withIdentifier: id))
        }
        return viewControllers
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizer.Direction.right:
//                print(indx)
                if self.indx > 0 {
                    childView.previous()
                    self.indx = indx - 1
//                    print(self.indx)

                    self.callBtnWithSlide(indexValue: self.indx)
                }
                
            case UISwipeGestureRecognizer.Direction.left:
//                print(indx)
                
                if (self.indx < 3){
                    childView.next()
                    self.indx = indx + 1
//                    print(self.indx)
                    self.callBtnWithSlide(indexValue: self.indx)
                }
            default:
                break
            }
        }
        print(indx)
    }
    
    func callBtnWithSlide(indexValue: Int){
        
        let index = indexValue
        self.indx = index
        if index == 0 {
            
            self.btnAll.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnAll.setTitleColor(UIColor.white, for: .normal)
            
            self.btnPoints.backgroundColor = UIColor.clear
            self.btnPoints.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnVoucher.backgroundColor = UIColor.clear
            self.btnVoucher.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnStemp.backgroundColor = UIColor.clear
            self.btnStemp.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 1 {
            
            self.btnAll.backgroundColor = UIColor.clear
            self.btnAll.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnPoints.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnPoints.setTitleColor(UIColor.white, for: .normal)
            
            self.btnVoucher.backgroundColor = UIColor.clear
            self.btnVoucher.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnStemp.backgroundColor = UIColor.clear
            self.btnStemp.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 2 {
            
            self.btnAll.backgroundColor = UIColor.clear
            self.btnAll.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnPoints.backgroundColor = UIColor.clear
            self.btnPoints.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnVoucher.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnVoucher.setTitleColor(UIColor.white, for: .normal)
            
            self.btnStemp.backgroundColor = UIColor.clear
            self.btnStemp.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 3 {
            
            self.btnAll.backgroundColor = UIColor.clear
            self.btnAll.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnPoints.backgroundColor = UIColor.clear
            self.btnPoints.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnVoucher.backgroundColor = UIColor.clear
            self.btnVoucher.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnStemp.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnStemp.setTitleColor(UIColor.white, for: .normal)
            
        }
    }
    
    // MARK: - Calender Works
    
    func setUpFSCalender() {
        
//        fscalender.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        fscalender.delegate = self
//        fscalender.dataSource = self
        fscalender.allowsMultipleSelection = true
    }
    
    
    func setupMonthLabel(date: Date) {
        df.dateFormat = "MMM"
        lblMonth.text = df.string(from: date)
    }
    
    func setUpKoyomi(){
        
        koyomi.circularViewDiameter = 0.2
        koyomi.backgroundColor = .clear
        koyomi.calendarDelegate = self
        koyomi.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        koyomi.weeks = ("S", "M", "T", "W", "T", "F", "S")
        koyomi.style = .standard
        koyomi.dayPosition = .center
        koyomi.selectionMode = .sequence(style: .semicircleEdge)
        koyomi.selectedStyleColor = #colorLiteral(red: 0.275936842, green: 0.1149172261, blue: 0.4860839248, alpha: 1)
        koyomi.setDayFont(fontName: General.fontName, size: 15).setWeekFont(fontName: General.fontName, size: 15)
        
    }
    
    
    
    
    // MARK: - IBActions
    
    
    @IBAction func actionBtnBack(_ sender: Any) {
//        AppDelegate.moveToHome()
        self.popVC()
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        
    }
    
    @IBAction func actionShowCalender(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            scrollVal+=250
            UIView.animate(withDuration: 0.3) {
                //                self.setUpCalender()
                self.koyomi.isHidden = true // to be false
                //                self.setUpKoyomi()
                self.fscalender.isHidden = false
                self.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(.pi * -0.999))
                self.topViewHeight.constant = 587
                self.bgTopView.image = UIImage(named: "bgExpend")
                self.view.layoutIfNeeded()
                
            }
        }else {
            scrollVal-=250
            UIView.animate(withDuration: 0.3) {
                self.imgArrow.transform = .identity
                self.topViewHeight.constant = 285
                self.bgTopView.image = UIImage(named: "bg-editProfile")
                self.koyomi.isHidden = true
                self.fscalender.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
        scrollViewHeight.constant = CGFloat(scrollVal)
    }
    
    
    @IBAction func pressedBtn(_ sender: UIButton) {
        let index = sender.tag
        self.indx = index
        print(index)
        childView.replace(withIndex: index)
        if index == 0 {
            
            self.btnAll.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnAll.setTitleColor(UIColor.white, for: .normal)
            
            self.btnPoints.backgroundColor = UIColor.clear
            self.btnPoints.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnVoucher.backgroundColor = UIColor.clear
            self.btnVoucher.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnStemp.backgroundColor = UIColor.clear
            self.btnStemp.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 1 {
            
            self.btnAll.backgroundColor = UIColor.clear
            self.btnAll.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnPoints.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnPoints.setTitleColor(UIColor.white, for: .normal)
            
            self.btnVoucher.backgroundColor = UIColor.clear
            self.btnVoucher.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnStemp.backgroundColor = UIColor.clear
            self.btnStemp.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 2 {
            
            self.btnAll.backgroundColor = UIColor.clear
            self.btnAll.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnPoints.backgroundColor = UIColor.clear
            self.btnPoints.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnVoucher.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnVoucher.setTitleColor(UIColor.white, for: .normal)
            
            self.btnStemp.backgroundColor = UIColor.clear
            self.btnStemp.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
        }else if index == 3 {
            
            self.btnAll.backgroundColor = UIColor.clear
            self.btnAll.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnPoints.backgroundColor = UIColor.clear
            self.btnPoints.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnVoucher.backgroundColor = UIColor.clear
            self.btnVoucher.setTitleColor(#colorLiteral(red: 0.4542183876, green: 0, blue: 0.8132248521, alpha: 1), for: .normal)
            
            self.btnStemp.backgroundColor = #colorLiteral(red: 0.767175138, green: 0.1698025465, blue: 1, alpha: 1)
            self.btnStemp.setTitleColor(UIColor.white, for: .normal)
            
        }
    }
    
}

extension ActivityVC: KoyomiDelegate {
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        print("You Selected: \(String(describing: date))")
    }
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        //        currentDateLabel.text = dateString
        print(dateString)
    }
    
    @objc(koyomi:shouldSelectDates:to:withPeriodLength:)
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        if length > invalidPeriodLength {
            print("More than \(invalidPeriodLength) days are invalid period.")
            return false
        }
        return true
    }
}

extension ActivityVC : FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]

            print("datesRange contains: \(datesRange!)")


            return
        }

        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]

                print("datesRange contains: \(datesRange!)")

                return
            }

            let range = datesRange(from: firstDate!, to: date)

            lastDate = range.last

            for d in range {
                calendar.select(d)
            }

            datesRange = range

            print("datesRange contains: \(datesRange!)")

            return
        }

        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                //                calendar.deselect(d)
                calendar.select(d)
            }

            //            lastDate = nil
            //            firstDate = nil
            //
            //            datesRange = []

            print("datesRange contains: \(datesRange!)")
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:

        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }

            lastDate = nil
            firstDate = nil

            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
//        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        //           if self.gregorian.isDateInToday(date) {
        //               return "今"
        //           }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    // MARK:- FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        //           self.calendar.frame.size.height = bounds.height
        //           self.eventLabel.frame.origin.y = calendar.frame.maxY + 10
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
       func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
           return monthPosition == .current
       }

//       func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//           print("did select date \(self.formatter.string(from: date))")
////               self.configureVisibleCells()
//       }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.formatter.string(from: date))")
//        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.gregorian.isDateInToday(date) {
            return [UIColor.orange]
        }
        return [appearance.eventDefaultColor]
    }
    
    // MARK: - Private functions
    
    private func configureVisibleCells() {
        fscalender.visibleCells().forEach { (cell) in
            let date = fscalender.date(for: cell)
            let position = fscalender.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }

    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {

        let diyCell = (cell as! DIYCalendarCell)
        // Custom today circle
        diyCell.circleImageView.isHidden = !self.gregorian.isDateInToday(date)
        // Configure selection layer
        if position == .current {

            var selectionType = SelectionType.rightBorder

            if fscalender.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if fscalender.selectedDates.contains(date) {
                    if fscalender.selectedDates.contains(previousDate) && fscalender.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if fscalender.selectedDates.contains(previousDate) && fscalender.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    }
                    else if fscalender.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType

        } else {
            diyCell.circleImageView.isHidden = true
            diyCell.selectionLayer.isHidden = true
        }
    }

    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
}
class monthCell: UICollectionViewCell {
     @IBOutlet weak var titile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension ActivityVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        monthArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as! monthCell
        if indexPath.row == monthIndex-1{
            cell.titile.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }else{
            cell.titile.textColor = #colorLiteral(red: 0.9719446301, green: 0.9719673991, blue: 0.9719551206, alpha: 0.5)
        }
        cell.titile.text = monthArr[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AllActivityVC.mymonth = monthArr[indexPath.row]
        monthIndex = indexPath.row+1
        monthCollection.reloadData()
        setTab()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

             let collectionWidth = collectionView.bounds.width
             let collectioHeight = collectionView.bounds.height
//        let collectionWidth =  monthArr[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36)])
        return CGSize(width: collectionWidth/2+10, height: collectioHeight)
//        return collectionWidth
         
//           return monthArr[indexPath.row].size(withAttributes: nil)
           
       }
       
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 5
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
}
