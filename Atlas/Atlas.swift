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
    
    private var regs: BehaviorRelay<[SectionOfRegion]> = BehaviorRelay(value: [])
    private var regsObservable: Observable<[SectionOfRegion]> = Observable.from([])
    
    public var ctrs: BehaviorRelay<[SectionOfCountry]> = BehaviorRelay(value: [])
    public var ctrsObservable: Observable<[SectionOfCountry]> = Observable.from([])
    
    private var allCountries: [Country] = []
    
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
        
        self.regsObservable = self.regs.asObservable()
        self.ctrsObservable = self.ctrs.asObservable()
        
        guard let gitUrl = URL(string: "https://restcountries.eu/rest/v2/all") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([Country].self, from: data)
                
                self.allCountries = items.filter { $0.region != "" }
                
                self.countries.accept(self.allCountries)
                self.ctrs.accept([SectionOfCountry(header: "", items: self.allCountries)])
                self.regs.accept([SectionOfRegion(header: "", items: NSSet(array: self.allCountries.map{ $0.region }).map{ region in Region(name: region as! String) })])
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    func regions() -> Observable<[SectionOfRegion]>{
        return self.regsObservable
    }
    
    func countriesByRegion(region: String) -> Observable<[SectionOfCountry]>{
        return Observable.from(optional: [SectionOfCountry(header: "", items: self.allCountries.filter{ $0.region == region } )])
    }
    
    func countriesByName(name: String) -> Observable<[SectionOfCountry]>{
        return Observable.from(optional: [SectionOfCountry(header: "", items: self.allCountries.filter{ $0.name.range(of: name) != nil } )])
    }
    
    func countryByAlpha3Code(codes: [String]) -> Observable<[SectionOfCountry]>{
        return Observable.from(optional: [SectionOfCountry(header: "", items: self.allCountries.filter{ codes.contains($0.alpha3Code) } )])        
    }
}

