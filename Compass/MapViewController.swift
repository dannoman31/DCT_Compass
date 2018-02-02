//
//  MapViewController.swift
//  compass
//
//  Created by Dan Taylor on 8/5/17.
//  Copyright © 2017 Favorshot. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var delegate: MapViewControllerDelegate!

    let manager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
  
    @IBAction func setDestination(_ sender: UIButton) {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let yourLocation = locations[0]

            let coordinate = CLLocationCoordinate2D(latitude: yourLocation.coordinate.latitude, longitude: yourLocation.coordinate.longitude)
        
            delegate.update(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
        
        performSegue(withIdentifier: "MAP_TO_COMPASS", sender: self)
    }
  
    @IBAction func cancelTap(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func resetTap(_ sender: UIBarButtonItem) {
        delegate.update(location: CLLocation(latitude: 90, longitude: 0))
        self.dismiss(animated: true, completion: nil)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        mapView.showsUserLocation = true
        if #available(iOS 9, *) {
            mapView.showsScale = true
            mapView.showsCompass = true
            
        }
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
 
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.didTap(_:)))
        mapView.mapType = MKMapType.satellite
        mapView.addGestureRecognizer(gestureRecognizer)
    }

    public func didTap(_ gestureRecognizer: UIGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
    
        delegate.update(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        self.dismiss(animated: true, completion: nil)
    }
}


