//
//  Atlas.swift
//  Atlas
//
//  Created by Pavel on 6/14/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Atlas{
    
    var countries: Array<Country>!
    
    static let sharedAtlas = Atlas()
    
    private init() {}
    
    class func shared() -> Atlas {
        return sharedAtlas
    }
    
    func load() -> RxSwift.Observable<[String]>{
        return URLSession.shared.rx.json(url: URL(string: "https://restcountries.eu/rest/v2/all")!)
            .catchErrorJustReturn([])
            .map { json -> [String] in
                guard let items = json as? [[String: Any]] else {
                    return []
                }
                
                self.countries = items.filter { !($0["region"] as? String == "") }.map{ (params) in return Country(params: params) }
                
                return NSSet(array: self.countries.map{ (country) in return country.region }).flatMap { $0 as? String }
        }
    }
    
    func countriesByRegion(region: String) -> Array<Country>{
        return self.countries.filter{ $0.region == region }
    }
    
    func countryByAlpha3Code(alpha3Code: String) -> Country{
        return self.countries.first(where: { $0.alpha3Code == alpha3Code })!
    }
}

