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
    
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = nil
        
        self.tableView.rx.modelSelected(Country.self)
            .subscribe(onNext: { [weak self] item in
                self?.showCountryCountroller(country: item)
            }).disposed(by: disposeBag)
    }
    
    func setRegionName(name: String){
        self.title = name
        Atlas.shared().countriesByRegion(region: name)
            .bind(to: self.tableView.rx.items(dataSource: self.countryDataSource()))
            .disposed(by: disposeBag)
    }

}


