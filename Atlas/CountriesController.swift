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
    
    var countries: Array<Dictionary <String, Any>>!
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
        cell.setParams(params: self.countries[indexPath.row])
        return cell;
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let countryView  = sampleStoryBoard.instantiateViewController(withIdentifier: "CountryController") as! CountryController
        
        countryView.country = self.countries[indexPath.row]
        
        let borders = countryView.country["borders"] as? Array<String>
        countryView.borders = self.countries.filter { (borders?.contains($0["alpha3Code"] as! String))! }
        
        self.navigationController?.pushViewController(countryView, animated: true)
    }
}


