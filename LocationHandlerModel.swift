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
    // Helper class to crunch distance calculations
    private var distanceCalculator = DistanceCalculator()
    // Distance in miles
    private var distanceInMiles: Double = 0.0
    // Bool for whether we should track average speed and distance
    private var running: Bool = false
    private var time: Int = 0
    
    
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
    
    // Return the distance in string format
    func getDistance() -> String {
        var distString: String = String(format:"%f", self.distanceInMiles)
        return distString
    }
    
    // Turn tracking on and off
    func toggleTracking() {
        self.running = !self.running
    }
    
    func incrementTime() {
        if(self.running) {
            time++
        }
    }
    
    
    // This function updates the latitude and longitude as well as the location object periodically
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.location = locations.last as! CLLocation
        self.longitude = location.coordinate.longitude.description
        self.latitude = location.coordinate.latitude.description
        if(self.running) {
            self.distanceInMiles = distanceCalculator.returnTotalDistance(self.location)
            distanceCalculator.returnMilesPerMinute(self.time)
        }
        
        /* 
        // for debugging
        println("latitude: " + self.latitude)
        println("longitude: " + self.longitude)
        println(distanceInMiles)
        */
    }
    
    // This function handles authorization requests
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorizationStatus")
        
        switch status {
        case .NotDetermined:
            println("NotDetermined")
            break
            
        case .AuthorizedAlways:
            println("Authorized GPS")
            self.locationManager.startUpdatingLocation()
            break
            
        case .Denied:
            println("Denied")
            break
            
        default:
            println("Unhandled authorization status")
            break
            
        }
    }
}