//
//  UITableViewDelegate+Countries.swift
//  Atlas
//
//  Created by Pavel on 7/3/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

extension UITableViewDelegate where Self: UIViewController {
    
    func didSelectCountry(tableView: UITableView, indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        self.showCountryCountroller(country: cell.country)
    }
}

