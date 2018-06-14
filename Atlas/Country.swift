//
//  Country.swift
//  Atlas
//
//  Created by Pavel on 6/14/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation

class Country{
    var code: String = ""
    var name: String = ""
    var nativeName: String = ""
    var lat: Float = 0.0
    var lng: Float = 0.0
    
    var borders: Array<Country>
    
    init(params: Dictionary<String, Any>, allCountries: Array<Dictionary<String, Any>>!){
        self.name = params["name"] as! String
        self.nativeName = params["nativeName"] as! String
        self.code = params["alpha2Code"] as! String
        
        self.borders = allCountries.filter { ((params["borders"] as! Array<String>).contains($0["alpha3Code"] as! String)) }.map{ (params) in return Country(params: params, allCountries: []) }
        
        let latlng = params["latlng"] as! Array<Float?>
        guard let lat = latlng[0], let lng = latlng[1] else {
            return
        }
        self.lat = lat
        self.lng = lng
    }
    
    
}
