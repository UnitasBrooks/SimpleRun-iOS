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
    // Elapsed time
    private var time: Int = 0
    // Minutes per mile, only tracked while running is true
    private var minutesPerMile: Double = 0.0

    
    
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
    
    // Returns average speed in string format
    func getAvgSpeed() -> String {
        var mmString: String = String(format:"%f", self.minutesPerMile)
        return mmString
    }
    
    // Turn tracking on and off
    func toggleTracking() -> Bool {
        self.running = !self.running
        if(self.running) {
            println("Started tracking run")
            distanceCalculator.setLastLocation(location)
            self.locationManager.startUpdatingLocation()
        } else {
            println("Stopped tracking run")
            self.locationManager.stopUpdatingLocation()
        }
        
        return self.running
    }
    
    
    // A second has passed, record it if we are actively running
    func incrementTime() {
        if(self.running) {
            self.time++
        }
    }
    
    // This function updates the latitude and longitude as well as the location object periodically
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if(self.running) {
            self.location = locations.last as! CLLocation
            self.longitude = self.location.coordinate.longitude.description
            self.latitude = self.location.coordinate.latitude.description
            self.distanceInMiles = distanceCalculator.returnTotalDistance(self.location)
            self.minutesPerMile = distanceCalculator.returnMilesPerMinute(self.time)
        }
    }
    
    // This function handles authorization requests
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("Changed Auth Status")
        
        switch status {
        case .NotDetermined:
            println("Not Determined")
            break
            
        case .AuthorizedAlways:
            println("Authorized GPS")
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