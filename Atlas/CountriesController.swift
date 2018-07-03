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
    
    private var regionName: String!
    
    override func viewDidLoad() {
        self.tableView.dataSource = nil
        self.tableView.delegate = self
    }
    
    func setRegionName(name: String){
        self.regionName = name
        self.title = self.regionName
        Atlas.shared().countriesByRegion(region: self.regionName).bind(to: self.tableView.rx.items) { tableView, row, country in
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
            cell.setParams(country: country)
            return cell
        }        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        self.showCountryCountroller(country: cell.country)
    }
}


