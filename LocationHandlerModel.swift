//
//  LocationHandlerModel.swift
//  SimpleRun
//
//  Created by Joe Yuhas on 5/24/15.
//  Copyright (c) 2015 Joe Yuhas. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationHandlerModel : NSObject, CLLocationManagerDelegate {
    
    // Location object interfaces with GPS to get coordinates
    private var location = CLLocation()
    // Longitude string, returned to views
    private var longitude: String = ""
    // Latitude string, returned to views
    private var latitude: String = ""
    // Handles permissions to use GPS/location
    private var locationManager = CLLocationManager()
    // Holds a list of recent distances and calculates the total
    
    
    // Constructor
    override init() {
        super.init()
        self.locationManager.delegate = self // Delegates this class as the location manager
        self.locationManager.requestAlwaysAuthorization() // Request access to GPS from now until forever
    }
    
    // Get for longitude
    func getLong() -> String {
        return self.longitude
    }
    
    // Get for latitude
    func getLat() -> String {
        return self.latitude
    }
    
    // This function updates the latitude and longitude as well as the location object periodically
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.location = locations.last as! CLLocation
        self.longitude = location.coordinate.longitude.description
        self.latitude = location.coordinate.latitude.description
        println("latitude: " + self.latitude)
        println("longitude: " + self.longitude)
        
    }
    
    // This function handles authorization requests
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorizationStatus")
        
        switch status {
        case .NotDetermined:
            println(".NotDetermined")
            break
            
        case .AuthorizedAlways:
            println(".Authorized")
            self.locationManager.startUpdatingLocation()
            break
            
        case .Denied:
            println(".Denied")
            break
            
        default:
            println("Unhandled authorization status")
            break
            
        }
    }
}