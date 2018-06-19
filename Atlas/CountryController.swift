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

class CountryController: UIViewController{
    
    var country: Country!
    
    @IBOutlet weak var flag: CountryFlag!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nativeName: UILabel!
    @IBOutlet weak var labelBordersWith: UILabel!
    @IBOutlet weak var tableView: CountriesTableView!
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.country.name
        self.navigationController?.isNavigationBarHidden = false
        
        self.name.text = self.country.name
        self.nativeName.text = self.country.nativeName
        self.flag.setFlag(country: self.country)
        
        self.tableView!.rowHeight = UITableViewAutomaticDimension
        self.tableView!.estimatedRowHeight = 70.0
        
        self.labelBordersWith.isHidden = self.country.borders.count < 1
        self.tableView.isHidden = self.labelBordersWith.isHidden
        
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(country.lat), longitude: CLLocationDegrees(country.lng))
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        
        self.mapView.setRegion(region, animated: true)
        
        self.tableView.parentController = self
        self.tableView.setParams(list: Atlas.shared().countryByAlpha3Code(codes: country.borders))
    }
}



