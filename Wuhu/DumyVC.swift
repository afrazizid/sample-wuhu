//
//  ViewController.swift
//  Fucking
//
//  Created by afrazali on 18/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

//class DumyVC: BaseVC {
    
//    @IBOutlet weak var tble: UITableView!
//
//    var myData : [StampCardsData] = []
//    var myCollectionCount = 0
//    var arry = [21, 5]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.tble.estimatedRowHeight = 2000.0
//        self.tble.rowHeight = UITableView.automaticDimension
//        loadTableData()
//    }
//
//    func loadTableData(){
//
//        self.showLoader()
//
//        UserHandler.getStampData(userID: KC_userID ,success: { (successResponse) in
//            self.stopAnimating()
//
//            if successResponse.status == true {
//                if successResponse.data!.count > 0 {
//                    self.myData = successResponse.data!
//                    self.tble.reloadData()
//                }
//            }else {
//                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
//            }
//
//        }) { (error) in
//            self.stopAnimating()
//            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
//        }
//    }
//}
//
//extension DumyVC: UITableViewDelegate, UITableViewDataSource {
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myData.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//
//        //        let numOfRows = ceil(CGFloat(myData[indexPath.row].punch_card_count!) / 5)
//        //        print(numOfRows)
//        //
//        //        let extraSpace = numOfRows * 20 + 20
//        //
//        //        let rowHeigt = CGFloat(numOfRows * 50 + extraSpace + 100)
//        //        return rowHeigt
//
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell : DynamicTableCell = tableView.dequeueReusableCell(withIdentifier: String(describing : DynamicTableCell.self)) as! DynamicTableCell
//
//        cell.populateData(obj: self.myData[indexPath.row], cnt: self.arry[indexPath.row])
//        if indexPath.row == 0 {
//            cell.collection.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.1137254902, blue: 0.4862745098, alpha: 1)
//        }else if indexPath.row == 1 {
//            cell.collection.backgroundColor = #colorLiteral(red: 0.1091324016, green: 0.4614989161, blue: 0.7148715258, alpha: 1)
//        }else {
//            cell.collection.backgroundColor = #colorLiteral(red: 0.5804906487, green: 0.7514672875, blue: 0.1322936118, alpha: 1)
//        }
//        return cell
//    }
//}
//
//
//class DynamicTableCell: UITableViewCell {
//
//    @IBOutlet weak var collection: UICollectionView!
//    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
//
//    @IBOutlet weak var baseView: CardView!
//
//    @IBOutlet weak var img: UIImageView!
//    @IBOutlet weak var tit: UILabel!
//
//    var collectionCount = 0
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
//        self.collection.layer.masksToBounds = true
//        self.collection.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
//    }
//
//
//    func populateData(obj: StampCardsData, cnt: Int){
//
//        self.collectionCount = cnt//obj.punch_card_count!
//        self.baseView.drawBorder(width: 0.5, color:  #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9058823529, alpha: 1))
//
//        self.tit.text = obj.name
//        if obj.image != nil {
//            let imgUrl = GlobalURL.imgPath + obj.image!
//            self.img.sd_setImage(with: URL(string: imgUrl), placeholderImage:UIImage(named: "placeholder"))
//        }
//
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        let widthh = self.collection.frame.width/6.0
//        layout.itemSize = CGSize(width: widthh, height: widthh)
//        layout.minimumInteritemSpacing = 8
//        layout.scrollDirection = .vertical
//        self.collection.isScrollEnabled = false
//
//        self.collection.collectionViewLayout = layout
//        self.collection.delegate = self
//        self.collection.dataSource = self
//        let numOfRows = ceil(CGFloat(self.collectionCount) / 5)
//        print(numOfRows)
//        let extraSpace = numOfRows * 14 + 14
//        print(numOfRows * 50 + extraSpace)
//        self.collectionHeight.constant = CGFloat(numOfRows * 50 + extraSpace)
//
//        self.collection.reloadData()
//
//    }
//}
//
//extension DynamicTableCell : UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return self.collectionCount
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collection.dequeueReusableCell(withReuseIdentifier: "StampCell", for: indexPath) as! StampCell
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
//
//}
//
//extension DynamicTableCell: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let myWidth = self.collection.frame.width/6.0
//        return CGSize(width: (myWidth), height: (myWidth))
//    }
//
//    /// Formats the insets for the various headers and sections.
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10)
//    }
//}
//
//class StampCell: UICollectionViewCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
//}
