//
//  CountryCell.swift
//  Atlas
//
//  Created by Pavel on 6/13/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var nativeName: UILabel!
    
    func setParams(params: Dictionary<String, Any>){
        self.name.text = params["name"] as? String
        self.nativeName.text = params["nativeName"] as? String
        
        let code = params["alpha2Code"] as? String
        
        self.flag.sd_setImage(with: URL(string: "http://flags.fmcdn.net/data/flags/h40/" + (code?.lowercased())! + ".png"), placeholderImage: UIImage(named: "placeholder_flag.png"))
        
    }
}
