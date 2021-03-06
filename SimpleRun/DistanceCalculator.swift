//
//  DistanceCalculator.swift
//  SimpleRun
//
//  Created by Joe Yuhas on 5/30/15.
//  Copyright (c) 2015 Joe Yuhas. All rights reserved.
//

import Foundation
import CoreLocation

public class DistanceCalculator {
    
    private var lastLocation = CLLocation()
    private var distanceInMiles: Double = 0.0
    
    init() {}
    
    public func returnTotalDistance(location: CLLocation) -> Double {
        if(lastLocation.coordinate.latitude != 0){
            var distanceInMeters = self.lastLocation.distanceFromLocation(location)
            self.distanceInMiles += distanceInMeters * 0.00062137
        }
        
        self.lastLocation = location
        return self.distanceInMiles
    }
    
    public func setLastLocation(location:CLLocation) {
        self.lastLocation = location
    }
    
    public func returnMilesPerMinute(timeInSeconds: Int) -> Double {
        var avgSpeed = (Double(timeInSeconds) / 60)  / distanceInMiles
        return avgSpeed
    }
}

