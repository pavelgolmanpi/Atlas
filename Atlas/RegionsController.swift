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
    
    var groupedRegions: Dictionary<String, Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.dataSource = nil
        self.navigationController?.navigationBar.topItem?.title = "Regions"
        URLSession.shared.rx.json(url: URL(string: "https://restcountries.eu/rest/v2/all")!)
            .catchErrorJustReturn([])
            .map { json -> [Region] in
                guard let items = json as? [[String: Any]] else {
                    return []
                }
                self.groupedRegions = Dictionary(grouping: items.filter { !($0["region"] as? String == "") }, by: {$0["region"] as? String ?? ""}) as Dictionary<String, Any>
                return Array(self.groupedRegions.keys).flatMap(Region.init)
            }
            .bind(to: self.tableView.rx.items) { tableView, row, region in
                let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell")!
                cell.textLabel!.text = region.name
                cell.accessoryType = .disclosureIndicator
                return cell
            }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! UITableViewCell

        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let countriesView  = sampleStoryBoard.instantiateViewController(withIdentifier: "CountriesController") as! CountriesController
        
        let region = currentCell.textLabel?.text
        
        countriesView.regionName = region
        let allCountries = self.groupedRegions[region!] as! Array<Dictionary<String, Any>>
        countriesView.countries = allCountries.map{ (params) in return Country(params: params, allCountries: allCountries) }
        self.navigationController?.pushViewController(countriesView, animated: true)
    }


}

