//
//  CountryCell.swift
//  Atlas
//
//  Created by Pavel on 6/13/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import UIKit

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var flag: CountryFlag!
    @IBOutlet var name: UILabel!
    @IBOutlet var nativeName: UILabel!
    
    func setParams(country: Country){
        self.name.text = country.name
        self.nativeName.text = country.nativeName
        self.flag.setFlag(country: country)
    }
}
