//
//  Country.swift
//  Atlas
//
//  Created by Pavel on 6/14/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Country{    
    
    var region: String = ""
    var alpha2Code: String = ""
    var alpha3Code: String = ""
    var name: String = ""
    var nativeName: String = ""
    var lat: Float = 0.0
    var lng: Float = 0.0
    
    var borders: Array<String>
    
    init(params: Dictionary<String, Any>){
        self.region = params["region"] as! String
        self.name = params["name"] as! String
        self.nativeName = params["nativeName"] as! String
        self.alpha2Code = params["alpha2Code"] as! String
        self.alpha3Code = params["alpha3Code"] as! String
        
        //self.borders = allCountries.filter { ((params["borders"] as! Array<String>).contains($0["alpha3Code"] as! String)) }.map{ (params) in return Country(params: params, allCountries: []) }
        
        self.borders = params["borders"] as! Array<String>
        
        let latlng = params["latlng"] as! Array<Float?>
        if(latlng.count == 2){
            self.lat = latlng[0]!
            self.lng = latlng[1]!
        }
    }
    
    
}
