//
//  ScanForm.swift
//  Wuhu
//
//  Created by Awais on 16/09/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import UIKit

class ScanForm: BaseVC,CountryListDelegate {
    @IBOutlet weak var countryLbl: UILabel!
    
    var countryList = CountryList()
    var countryCode = ""
    var countriesList = [CountryModel]()
    
    
    func selectedCountry(country: CountryModel) {
        countryLbl.text = country.flag! + " +" + country.phoneExtension
        countryCode = ("+\(country.phoneExtension ?? "0")")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        countryList.delegate = self
        getCountries()
        // Do any additional setup after loading the view.
    }
     func getCountries(){
                self.showLoader()
                UserHandler.getCountries(endPoint: "get-countries", success: { (successResponse) in
                    self.stopAnimating()
                    if successResponse.status == true {
                        self.countriesList = successResponse.data
                        for i in self.countriesList{
                            if i.isDefault{
                                self.countryLbl.text = (i.flag!) + " +" + i.phoneExtension
                                
                                self.countryCode =  "+"+"\(i.phoneExtension ?? "")"
                               
        //                        self.getCountryWithCode(code: "+"+"\(i.phoneExtension ?? "")")
                                break
    //                        }else{
    //                            self.tempPhoneBtn.isHidden = false
                            }
                        }
                        
                    }else  {
                        self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message, type: "error")
                    }
                }) { (error) in
                    self.stopAnimating()
                    self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
                }
            }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    @IBAction func actionCancel(_ sender:UIButton){
        
        backTwo()
    }
    @IBAction func actionCountry(_ sender:UIButton){
        
        CountryList.endpoint = "get-countries"
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }

}
