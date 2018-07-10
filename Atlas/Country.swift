//
//  Country.swift
//  Atlas
//
//  Created by Pavel on 6/14/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import MapKit

struct Country: Codable{
    
    let region: String
    let alpha2Code: String
    let alpha3Code: String
    let name: String
    let nativeName: String
    let coord: CLLocationCoordinate2D
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
        case coord
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        region = try values.decode(String.self, forKey: .region)
        name = try values.decode(String.self, forKey: .name)
        nativeName = try values.decode(String.self, forKey: .nativeName)
        alpha2Code = try values.decode(String.self, forKey: .alpha2Code)
        alpha3Code = try values.decode(String.self, forKey: .alpha3Code)
        borders = try values.decode([String].self, forKey: .borders)
        latlng = try values.decode([Double].self, forKey: .latlng)
        if(latlng.count >= 2){
            coord = try values.decode(CLLocationCoordinate2D.self, forKey: .latlng)
        }else{
            coord = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        }
    }
}

extension CLLocationCoordinate2D: Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(longitude)
        try container.encode(latitude)
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        latitude = try container.decode(Double.self)
        longitude = try container.decode(Double.self)
    }
}
