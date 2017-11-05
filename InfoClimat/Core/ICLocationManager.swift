//
//  ICLocationManager.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import Foundation
import CoreLocation

class ICLocationManager : NSObject, CLLocationManagerDelegate {
    static let sharedInstance = ICLocationManager()
    
    /**
     Current longitude of the device with 100m precision
     */
    var latitude : Double
    
    /**
     Current longitude of the device with 100m precision
     */
    var longitude : Double
    
    let locationManager = CLLocationManager()
    
    override init() {
        // default Paris coordinate for testing
        latitude = 48.85341
        longitude = 2.3488
        super.init()
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
       
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let position = manager.location?.coordinate {
            latitude  = position.latitude
            longitude = position.longitude
        }
    }
}
