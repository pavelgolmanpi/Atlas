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

private var countryDisposeBagKey: UInt8 = 0

extension UIViewController {
    
    var countryDisposeBag: DisposeBag {
        get {
            return associatedObject(base: self, key: &countryDisposeBagKey)
            { return DisposeBag() }
        }
        set { associateObject(base: self, key: &countryDisposeBagKey, value: newValue) }
    }
    
    func bindCountriesToTable(tableView: UITableView, countries: Observable<[SectionOfCountry]>){
        tableView.dataSource = nil
        
        self.countryDisposeBag = DisposeBag()
        tableView.rx.modelSelected(Country.self)
            .subscribe(onNext: { [weak self] item in
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CountryController") as? CountryController
                vc?.country = item
                self?.navigationController?.pushViewController(vc!, animated: true)
            })
            .disposed(by: self.countryDisposeBag)
                
        countries
            .bind(to: tableView.rx.items(dataSource: RxTableViewSectionedReloadDataSource<SectionOfCountry>(configureCell: {
                (ds: TableViewSectionedDataSource<SectionOfCountry>, tableView: UITableView, indexPath: IndexPath, country: Country) -> UITableViewCell in
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
                cell.setParams(country: country)
                return cell
            })))
            .disposed(by: self.countryDisposeBag)
    }
    


}
