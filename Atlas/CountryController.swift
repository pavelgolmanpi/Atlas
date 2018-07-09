//
//  CountryController.swift
//  Atlas
//
//  Created by Pavel on 6/12/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

class CountryController: UIViewController, UITableViewDelegate{
    
    var country: Country!
    fileprivate let disposeBag = DisposeBag()
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nativeName: UILabel!
    @IBOutlet weak var labelBordersWith: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.country.name
        self.navigationController?.isNavigationBarHidden = false
        
        self.name.text = self.country.name
        self.nativeName.text = self.country.nativeName
        self.flag.setCountry(country: self.country)
        self.tableView.delegate = self
        
        self.labelBordersWith.isHidden = self.country.borders.count < 1
        self.tableView.isHidden = self.labelBordersWith.isHidden
        
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(country.lat()), longitude: CLLocationDegrees(country.lng()))
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        self.mapView.setRegion(region, animated: true)
        
        Atlas.shared().countryByAlpha3Code(codes: country.borders)
            .bind(to: self.tableView.rx.items(dataSource: self.countryDataSource()))
            .disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(Country.self)
            .subscribe(onNext: { [weak self] item in
                self?.showCountryCountroller(country: item)
            }).disposed(by: disposeBag)
    }

}



