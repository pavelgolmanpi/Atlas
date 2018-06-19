//
//  CountriesTableView.swift
//  Atlas
//
//  Created by Pavel on 6/18/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CountriesTableView: UITableView, UITableViewDelegate{
    
    var list: Observable<[Country]>!
    var parentController: UIViewController!
    
    func setCountries(list: Observable<[Country]>){
        self.dataSource = nil
        self.delegate = self
        self.list = list
        self.list.bind(to: self.rx.items) { tableView, row, country in
            let cell = self.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
                cell.setParams(country: country)
                cell.accessoryType = .disclosureIndicator
                return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        
        let countryView  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CountryController") as! CountryController
        
        countryView.country = cell.country
        
        self.parentController.navigationController?.pushViewController(countryView, animated: true)
    }
    
}
