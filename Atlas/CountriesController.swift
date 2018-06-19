//
//  FirstViewController.swift
//  Atlas
//
//  Created by Pavel on 6/12/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class CountriesController: UITableViewController {
    
    private var regionName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.tableView as! CountriesTableView).parentController = self
    }
    
    func setRegionName(name: String){
        self.regionName = name
        self.title = self.regionName
        (self.tableView as! CountriesTableView).setParams(list: Atlas.shared().countriesByRegion(region: self.regionName))
    }
}


