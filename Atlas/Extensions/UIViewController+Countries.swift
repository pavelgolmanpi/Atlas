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
import RxDataSources

extension UIViewController {

    func countryDataSource() -> RxTableViewSectionedReloadDataSource<SectionOfCountry>{
        return RxTableViewSectionedReloadDataSource<SectionOfCountry>(configureCell: {
            (ds: TableViewSectionedDataSource<SectionOfCountry>, tableView: UITableView, indexPath: IndexPath, country: Country) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
            cell.setParams(country: country)
            return cell
        })
    }
    
    func showCountryCountroller(country: Country){
        let countryVC  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CountryController") as! CountryController
        countryVC.country = country
        self.navigationController?.pushViewController(countryVC, animated: true)
    }
}
