//
//  UIViewController+Country.swift
//  Atlas
//
//  Created by Pavel on 7/3/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showCountryCountroller(country: Country){
        let countryVC  = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CountryController") as! CountryController
        countryVC.country = country
        self.navigationController?.pushViewController(countryVC, animated: true)
    }
}
