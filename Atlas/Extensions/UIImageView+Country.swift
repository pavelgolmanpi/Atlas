//
//  UIImageView+Country.swift
//  Atlas
//
//  Created by Pavel on 7/2/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {

    func setCountry(country: Country){
        self.sd_setImage(with: URL(string: "http://flags.fmcdn.net/data/flags/h40/" + country.alpha2Code.lowercased() + ".png"), placeholderImage: UIImage(named: "placeholder_flag.png"))
    }
}
