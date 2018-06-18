//
//  CountriesTableView.swift
//  Atlas
//
//  Created by Pavel on 6/18/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import UIKit

class CountriesTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var countries: Array<Country> = []
    var parentController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell;
        cell.setParams(country: self.countries[indexPath.row])
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryView  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CountryController") as! CountryController
        
        countryView.country = self.countries[indexPath.row]
        
        self.parentController.navigationController?.pushViewController(countryView, animated: true)
    }
    
}
