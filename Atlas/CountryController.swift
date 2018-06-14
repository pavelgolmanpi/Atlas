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

class CountryController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var country: Country!
    
    @IBOutlet weak var flag: CountryFlag!
    @IBOutlet var name: UILabel!
    @IBOutlet var nativeName: UILabel!
    @IBOutlet var labelBordersWith: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.country.name
        self.name.text = self.country.name
        self.nativeName.text = self.country.nativeName
        self.flag.setFlag(country: self.country)
        
        self.tableView!.rowHeight = UITableViewAutomaticDimension
        self.tableView!.estimatedRowHeight = 70.0
        
        if(self.country.borders.count < 1){
            self.labelBordersWith.isHidden = true
        }
        
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(country.lat), longitude: CLLocationDegrees(country.lng))
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.country.borders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell;
        cell.setParams(country: self.country.borders[indexPath.row])
        return cell;
    }
}



