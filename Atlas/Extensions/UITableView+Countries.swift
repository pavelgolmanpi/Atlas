//
//  UIViewController+Country.swift
//  Atlas
//
//  Created by Pavel on 7/3/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UITableView{
    
    func setCountries(countries: Observable<[Country]>){
        self.dataSource = nil
        countries.bind(to: self.rx.items) { tableView, row, country in
            let cell = self.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
            cell.setParams(country: country)
            return cell
        }
    }
    
}

