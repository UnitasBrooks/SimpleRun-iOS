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
        var distanceInMeters = lastLocation.distanceFromLocation(location)
        distanceInMiles += distanceInMeters * 0.00062137
        lastLocation = location
        return distanceInMiles
    }
    
    public func returnMilesPerMinute(timeInSeconds: Double) -> Double { return distanceInMiles / timeInSeconds * 60 }
}

