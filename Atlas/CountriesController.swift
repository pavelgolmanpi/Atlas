//
//  FirstViewController.swift
//  Atlas
//
//  Created by Pavel on 6/12/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountriesController: UITableViewController {
    
    var countries: Array<Country>!
    var regionName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.dataSource = self
        
        self.title = self.regionName
        self.tableView!.rowHeight = UITableViewAutomaticDimension;
        self.tableView!.estimatedRowHeight = 70.0;
    
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell;
        cell.setParams(country: self.countries[indexPath.row])
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let countryView  = sampleStoryBoard.instantiateViewController(withIdentifier: "CountryController") as! CountryController
        
        countryView.country = self.countries[indexPath.row]
        
        self.navigationController?.pushViewController(countryView, animated: true)
    }
}


