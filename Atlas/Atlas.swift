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
    
    var countries: Observable<[Country]>!
    
    static let sharedAtlas = Atlas()
    fileprivate let disposeBag = DisposeBag()
    
    private init() {
        
        self.load()
    }
    
    class func shared() -> Atlas {
        return sharedAtlas
    }
    
    func load(){
        self.countries = URLSession.shared.rx.json(url: URL(string: "https://restcountries.eu/rest/v2/all")!)
            .catchErrorJustReturn([])
            .map { json -> [Country] in
                guard let items = json as? [[String: Any]] else {
                    return []
                }
                
                return items.filter { !($0["region"] as? String == "") }.map{ (params) in return Country(params: params)}
            }
    }
    
    func regions() -> Observable<[String]>{
        return self.countries.map{ countries in NSSet(array: countries.map{ (country) in return country.region }).flatMap { $0 as? String } }
    }
    
    func countriesByRegion(region: String) -> Observable<[Country]>{
        return self.countries.map { countries in countries.filter{ $0.region == region } }
    }
    
    func countriesByName(name: String) -> Observable<[Country]>{
        return self.countries.map { countries in countries.filter{ $0.name.range(of: name) != nil } }
    }
    
    func countryByAlpha3Code(codes: [String]) -> Observable<[Country]>{
        return self.countries.map { countries in countries.filter{codes.contains($0.alpha3Code)  } }
    }
}

