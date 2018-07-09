//
//  SecondViewController.swift
//  Atlas
//
//  Created by Pavel on 6/12/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchController: UIViewController, UITableViewDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    fileprivate let disposeBag = DisposeBag()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = "Search"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
                
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.rx.modelSelected(Country.self)
            .subscribe(onNext: { [weak self] item in
                self?.showCountryCountroller(country: item)
            }).disposed(by: disposeBag)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        self.tableView.dataSource = nil
        Atlas.shared().countriesByName(name: searchText)
            .bind(to: self.tableView.rx.items(dataSource: self.countryDataSource()))
            .disposed(by: disposeBag)
        
        self.tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}


extension SearchController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension SearchController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: "")
    }
}

