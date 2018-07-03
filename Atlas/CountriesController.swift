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
    
    override func viewDidLoad() {
        self.tableView.delegate = self
    }
    
    func setRegionName(name: String){
        self.title = name
        self.tableView.setCountries(countries: Atlas.shared().countriesByRegion(region: self.title!))        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectCountry(tableView: tableView, indexPath: indexPath)
    }
    
}


