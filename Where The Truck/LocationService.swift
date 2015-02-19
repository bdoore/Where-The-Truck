//
//  LocationService.swift
//  Where The Truck
//
//  Created by Brian Doore on 1/24/15.
//  Copyright (c) 2015 Brian Doore. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    class var sharedInstance: LocationService {
        
        
        struct Static {
            static var instance: LocationService?
            static var token: dispatch_once_t = 0
            }
        
            dispatch_once(&Static.token) {
            Static.instance = LocationService()
            }
        
        return Static.instance!
        }
    
    override init() {
        
        super.init()
        
        self.locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()

        if(CLLocationManager.locationServicesEnabled()) {
            
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 100
            self.locationManager.delegate = self
        }
        
        self.startUpdatingLocation()
        
        
    }
    
    func startUpdatingLocation() {
        
        println("Starting location updates")
        
        self.locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Location service failed with error \(error)")
    
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if let location: CLLocation = locations.last as? CLLocation {
            
            println("Latitude:\(location.coordinate.latitude), Longitude:\(location.coordinate.longitude)")
            
            self.currentLocation = location
            
            self.locationManager.stopUpdatingLocation()
            
            NSNotificationCenter.defaultCenter().postNotificationName("userLocationRecieved", object: nil)

            
        }
        
    }
    
    
    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        var locValue: CLLocationCoordinate2D = manager.location.coordinate
//        var latitudeActual:Double = 0
//        var longitudeActual:Double = 0
//        
//        latitudeActual = locValue.latitude
//        longitudeActual = locValue.longitude
//        
//        locationManager.stopUpdatingLocation()
//        if (latitudeActual != 0 || longitudeActual != 0) {
//            
//        }
//    }
    
    
        
}


