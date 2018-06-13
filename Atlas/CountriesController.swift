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
    
    var countries: Array<Any>!
    var regionName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.dataSource = nil
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")

    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}


