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
        annotation.coordinate = country.coord
        self.mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: country.coord, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        self.mapView.setRegion(region, animated: true)
        
        self.bindCountriesToTable(tableView: self.tableView, countries: Atlas.shared().countryByAlpha3Code(codes: country.borders))
    }

}



