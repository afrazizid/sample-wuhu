//
//  CountryListTableViewController.swift
//  CountryListExample
//
//  Created by Juan Pablo on 9/8/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

public protocol CountryListDelegate: class {
    func selectedCountry(country: CountryModel)
}

class CountryList: BaseVC, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var tableView: UITableView!
    var searchController: UISearchController?
    var resultsController = UITableViewController()
    var filteredCountries = [CountryModel]()
    
    static var endpoint:String!
    
    
    open weak var delegate: CountryListDelegate?
    
    private var countryList = [CountryModel]()
//    {
//        let countries = Countries()
//        let countryList = countries.countries
//        return countryList
//    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = .white
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationCountry"), object: nil)
        
        tableView = UITableView(frame: view.frame)
        tableView.register(CountryCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        
        self.view.addSubview(tableView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(handleCancel))
        self.setUpSearchBar()
//        CountryList.endpoint = "get-countries"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        countryList.removeAll()
        tableView.reloadData()
        if CountryList.endpoint.contains("get-countries"){
            self.title = "Country List"
        }else if CountryList.endpoint.contains("get-states") {
            self.title = "Province List"
        }else if CountryList.endpoint.contains("get-cities") {
            self.title = "City List"
        }
        getCountries()
    }
//        @objc func methodOfReceivedNotification(notification: Notification) {
//    //        label.isHidden = true
//            endpoint = notification.object as! String
//              print("Value of notification : ", notification.object ?? "")
//
//          }
    func getCountries(){
        self.showLoader()
        UserHandler.getCountries(endPoint: CountryList.endpoint, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status == true {
                self.countryList = successResponse.data
            
                self.tableView.reloadData()
                
            }else  {
                self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message, type: "error")
            }
        }) { (error) in
            self.stopAnimating()
            self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
        }
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        
        filteredCountries.removeAll()
        
        let text = searchController.searchBar.text!.lowercased()
        
        for country in countryList {
            guard let name = country.name else { return }
            if name.lowercased().contains(text) {
                
                filteredCountries.append(country)
            }
        }
        
        tableView.reloadData()
    }
    
    func setUpSearchBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = searchController?.searchBar
        self.searchController?.hidesNavigationBarDuringPresentation = false
        
//        self.searchController?.searchBar.backgroundImage = UIImage()
        self.searchController?.dimsBackgroundDuringPresentation = false
//        self.searchController?.searchBar.barTintColor = UIColor.white
        self.searchController?.searchBar.placeholder = "Search"
//        self.searchController?.searchBar.tintColor = Constants.Colors.mainColor
//        self.searchController?.searchBar.backgroundColor = UIColor.white
        self.searchController?.searchResultsUpdater = self
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        let country = cell.country!
        
        self.searchController?.isActive = false
        self.delegate?.selectedCountry(country: country)
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
//        countryList.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController!.isActive && searchController!.searchBar.text != "" {
            return filteredCountries.count
        }
        
        return countryList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! CountryCell
        
        if searchController!.isActive && searchController!.searchBar.text != "" {
            cell.country = filteredCountries[indexPath.row]
            return cell
        }
        
        cell.country = countryList[indexPath.row]
        return cell
    }
    
    @objc func handleCancel() {
        self.searchController?.isActive = false
        if searchController!.searchBar.text != ""{
            searchController?.searchBar.text = ""
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
