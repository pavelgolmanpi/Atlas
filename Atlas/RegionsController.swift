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

import struct Foundation.URL
import class Foundation.URLSession

class RegionsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.dataSource = nil
        self.navigationController?.navigationBar.topItem?.title = "Regions"
        
        Atlas.shared()
            .regions()
            .bind(to: self.tableView.rx.items) { tableView, row, region in
                let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell")!
                cell.textLabel!.text = region
                cell.accessoryType = .disclosureIndicator
                return cell
            }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! UITableViewCell

        let countriesView  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CountriesController") as! CountriesController
        
        countriesView.setRegionName(name: (currentCell.textLabel?.text)!)
        
        self.navigationController?.pushViewController(countriesView, animated: true)
    }


}

