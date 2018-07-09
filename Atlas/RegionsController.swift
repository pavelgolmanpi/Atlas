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

import struct Foundation.URL
import class Foundation.URLSession

class RegionsController: UITableViewController {
    
    fileprivate let disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfRegion>(configureCell: {
        (ds: TableViewSectionedDataSource<SectionOfRegion>, tableView: UITableView, indexPath: IndexPath, model: Region) -> UITableViewCell in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell")
        cell?.textLabel!.text = model.name
        return cell!
    })

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Regions"
        
        self.tableView!.dataSource = nil
        
        Atlas.shared().regions()
            .bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(Region.self)
            .subscribe(onNext: { [weak self] item in
                let countriesView  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CountriesController") as! CountriesController
                countriesView.setRegionName(name: item.name)
                self?.navigationController?.pushViewController(countriesView, animated: true)
            }).disposed(by: disposeBag)
    }
}

