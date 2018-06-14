//
//  CountryFlag.swift
//  Atlas
//
//  Created by Pavel on 6/14/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class CountryFlag: UIImageView{
    
    func setFlag(country: Country){
        self.sd_setImage(with: URL(string: "http://flags.fmcdn.net/data/flags/h40/" + (country.code.lowercased()) + ".png"), placeholderImage: UIImage(named: "placeholder_flag.png"))
    }
}
