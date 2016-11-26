//
//  TockLocationManager.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import CoreLocation

class TockLocationManager: NSObject, CLLocationManagerDelegate {
    fileprivate var locationManger:CLLocationManager
    fileprivate var coder: CLGeocoder
    fileprivate var placemark: CLPlacemark!
    internal var delegate: TockLocationManagerDelegate!
    
    
    override init(){
        locationManger = CLLocationManager()
        coder = CLGeocoder()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManger.requestWhenInUseAuthorization()
        }
        
        
        
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
        
        super.init()
        
        locationManger.delegate = self
        
        
    }
    
    func startLocating(){
        if CLLocationManager.locationServicesEnabled() {
            self.locationManger.startUpdatingLocation()
        }
    }
    
    func stopLocating(){
        self.locationManger.stopUpdatingLocation()
    }
    
    
    
    
    @objc(locationManager:didUpdateLocations:) func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        if let currentLocation = location {
            self.coder.reverseGeocodeLocation(currentLocation, completionHandler: {(placemarks, error) in
                if error == nil {
                    
                     let lat = placemarks?.last?.location?.coordinate.latitude
                    let long = placemarks?.last?.location?.coordinate.longitude
                    if lat != nil && long != nil {
                     let coordinate = Location(lat: lat!, long: long!)
                        print("the lat found is: \(lat), the long found is \(long)")
                        self.delegate.locationFound(coordinate, inCity: placemarks?.last?.locality!)
                    } else {
                        self.delegate.latlongFailed()
                    }
                } else {
                    self.delegate.locationFailed(error! as NSError)
                }
            })
        }
    }
    
}
