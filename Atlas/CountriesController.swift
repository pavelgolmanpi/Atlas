//
//  FirstViewController.swift
//  Atlas
//
//  Created by Pavel on 6/12/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class CountriesController: UITableViewController {
    
    var regionName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.regionName
        self.tableView!.rowHeight = UITableViewAutomaticDimension;
        self.tableView!.estimatedRowHeight = 70.0;
    
        //(self.tableView as! CountriesTableView).countries = Atlas.shared().countriesByRegion(region:
        //    self.regionName)
        (self.tableView as! CountriesTableView).parentController = self
    }
}


