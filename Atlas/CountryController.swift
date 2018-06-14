//
//  CountryController.swift
//  Atlas
//
//  Created by Pavel on 6/12/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountryController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var country: Dictionary <String, Any>!
    var borders: Array<Dictionary <String, Any>>!
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var nativeName: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.country["name"] as? String
        self.name.text = self.country["name"] as? String
        self.nativeName.text = self.country["nativeName"] as? String
        
        self.tableView!.rowHeight = UITableViewAutomaticDimension;
        self.tableView!.estimatedRowHeight = 70.0;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.borders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell;
        cell.setParams(params: self.borders[indexPath.row])
        return cell;
    }
}



