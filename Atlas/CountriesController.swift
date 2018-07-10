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
import RxDataSources

class CountriesController: UITableViewController {
    
    func setRegion(region: Region){
        self.title = region.name
        self.bindCountriesToTable(tableView: self.tableView, countries: Atlas.shared().countriesByRegion(region: region.name))
    }

}


