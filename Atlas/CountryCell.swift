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
    
    public var country: Country!
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var nativeName: UILabel!
    
    func setParams(country: Country){
        self.country = country
        self.name.text = country.name
        self.nativeName.text = country.nativeName
        self.flag.setCountry(country: country)
    }
}
