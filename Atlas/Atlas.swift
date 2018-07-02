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
    
    private var countries: BehaviorRelay<[Country]> = BehaviorRelay(value: [])
    private var countriesObservable: Observable<[Country]> = Observable.from([])
    
    static let sharedAtlas = Atlas()
    fileprivate let disposeBag = DisposeBag()
    
    private init() {
        
        self.load()
    }
    
    class func shared() -> Atlas {
        return sharedAtlas
    }
    
    func load(){
        self.countriesObservable = self.countries.asObservable()
        
        guard let gitUrl = URL(string: "https://restcountries.eu/rest/v2/all") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([Country].self, from: data)
                
                self.countries.accept(items.filter { $0.region != "" })
            } catch let err {
                //print("Err", err)
            }
            }.resume()
    }
    
    func regions() -> Observable<[String]>{
        return self.countriesObservable.map{ countries in NSSet(array: countries.map{ (country) in return country.region }).flatMap { $0 as? String } }
    }
    
    func countriesByRegion(region: String) -> Observable<[Country]>{
        return self.countriesObservable.map { countries in countries.filter{ $0.region == region } }
    }
    
    func countriesByName(name: String) -> Observable<[Country]>{
        return self.countriesObservable.map { countries in countries.filter{ $0.name.range(of: name) != nil } }
    }
    
    func countryByAlpha3Code(codes: [String]) -> Observable<[Country]>{
        return self.countriesObservable.map { countries in countries.filter{codes.contains($0.alpha3Code)  } }
    }
}

