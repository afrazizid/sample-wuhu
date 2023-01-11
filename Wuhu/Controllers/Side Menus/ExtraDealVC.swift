//
//  ExtraDealVC.swift
//  Wuhu
//
//  Created by afrazali on 14/02/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit
import DropDown
import WebKit

class ExtraDealVC: BaseVC,WKUIDelegate, WKNavigationDelegate, UIWebViewDelegate  {

    @IBOutlet weak var viewRetailer: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnRetailer: UIButton!
    @IBOutlet weak var lblRetailer: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var topBar: TopBarView!
    let retailerDD = DropDown()
    
    var stepWebView: WKWebView!
    var html:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        Applicationevents.postInfo(string: "extra_deals")
        self.setUIElements()
        
        html = GlobalURL.baseUrl + "get-page-info?page_name=extra-deals"
        if verifyUrl(urlString: html){
            self.showLoader()
            webView.load(URLRequest(url: URL(string: html)!))
        }
//        getHelp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        pts.text = "\(self.Shared.userInfo?.totalPoint ?? 0)"+" pts"
              rs.text = "R"+"\(self.Shared.userInfo?.rs ?? 0)"
        self.TopBarMenu(view: topBar)
    }
    
    override func viewDidLayoutSubviews() {
        
        self.bgView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
    }
     func getHelp(){
               
               var parameters : [String: Any]
               parameters = [
                   "type"              :  "extra-deals"
               ]
               
               print(parameters)
               self.showLoader()
               UserHandler.getHelp(params: parameters as NSDictionary, success: { (successResponse) in
                   
                   if successResponse.status == true {
    //                   self.title = successResponse.data[0].title.capitalizingFirstLetter()
                    print(successResponse.data[0].descriptionField)
                       let fontSize = 20
                       let fontSetting = "<span style=\"font-size: \(fontSize)\"</span>"
                       self.webView.loadHTMLString(successResponse.data[0].descriptionField, baseURL: nil)
                   }else  {
                       self.showSwiftMessage(title: AlertTitle.warning, message:"Error", type: "error")
                   }
               }) { (error) in
                   self.stopAnimating()
                   self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
               }
           
           }
    
    func setUIElements() {
        
        self.setRetailerDD()
        viewRetailer.setWhiteGrayView()
        setUpCollection()
        
    }


    func setRetailerDD() {
        
        self.retailerDD.dataSource = ["Pick n Pay", "Pick n Pay", "Pick n Pay"]
        self.retailerDD.anchorView = btnRetailer
        self.retailerDD.bottomOffset = CGPoint(x: 0, y: btnRetailer.bounds.height)
        self.retailerDD.direction = .any
        
        // Action triggered on selection
        self.retailerDD.selectionAction = { [unowned self] (index, item) in
            let index = self.retailerDD.indexForSelectedRow
            print(index!)
            self.lblRetailer.text = item
            self.viewRetailer.setNormalTxtView()
        }
    }
    
    func setUpCollection() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: collection.frame.width/2.0, height: 240)
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        layout.footerReferenceSize = CGSize(width: 0, height: 0)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        collection!.collectionViewLayout = layout
        
    }
    
    // MARK: - IBActions
    
    @IBAction func actionDD(_ sender: Any) {
        self.retailerDD.show()
    }
    
    @IBAction func actionBtnBack(_ sender: Any) {
//        AppDelegate.moveToHome()
        self.popVC()
    }
}

extension ExtraDealVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       let cell = collection.dequeueReusableCell(withReuseIdentifier: "ExtraDealCell", for: indexPath) as! ExtraDealCell
        if indexPath.row == 0{
            cell.logo.image = UIImage(imageLiteralResourceName: "pro")
        }else if indexPath.row == 1{
            cell.logo.image = UIImage(imageLiteralResourceName: "shampo")
        }else if indexPath.row == 2{
            cell.logo.image = UIImage(imageLiteralResourceName: "lux")
        }else if indexPath.row == 3{
            cell.logo.image = UIImage(imageLiteralResourceName: "lipton")
        }else if indexPath.row == 4{
            cell.logo.image = UIImage(imageLiteralResourceName: "corneto")
        }else if indexPath.row == 5{
            cell.logo.image = UIImage(imageLiteralResourceName: "helman")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
extension ExtraDealVC{
    func webView(_ webView: WKWebView,
                     didFinish navigation: WKNavigation!){
            print("loaded")
        self.stopAnimating()
    }
}
extension ExtraDealVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let numberofItem: CGFloat = 2
        
        let collectionViewWidth = self.collection.bounds.width
        
        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
        
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        
        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
        
        print(width)
        
        return CGSize(width: width, height: 240)
    }
    
    
}

class ExtraDealCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var logo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.setWhiteGrayView()
    }
}


