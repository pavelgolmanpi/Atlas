//
//  Country.swift
//  Atlas
//
//  Created by Pavel on 6/14/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation

struct Country: Codable{
    
    let region: String
    let alpha2Code: String
    let alpha3Code: String
    let name: String
    let nativeName: String
    let latlng: [Double]
    let borders: [String]
    
    private enum CodingKeys: String, CodingKey {
        case region
        case name
        case nativeName
        case alpha2Code
        case alpha3Code
        case borders
        case latlng
    }
    
    func lat() -> Double {
        if(self.latlng.count != 2){
            return 0.0
        }
        return self.latlng[0]
    }
    
    func lng() -> Double {
        if(self.latlng.count != 2){
            return 0.0
        }
        return self.latlng[1]
    }

}
