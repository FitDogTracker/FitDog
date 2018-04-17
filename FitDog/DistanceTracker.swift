//
//  DistanceTracker.swift
//  FitDog
//
//  Created by Kristine Laranjo on 4/11/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class DistanceTracker: NSObject, CLLocationManagerDelegate{
    
    static let shared: DistanceTracker = {
        let instance = DistanceTracker()
        instance.locationManager.delegate = instance
        instance.locationManager.activityType = .fitness
        instance.locationManager.distanceFilter = 10
        return instance
    }()
    
    var distance = Measurement(value: 0, unit: UnitLength.kilometers)
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    var isUpdatingLocation = false
    
    func startTracking(){
        locationManager.startUpdatingLocation()
        isUpdatingLocation = true
    }
    
    func pauseTracking(){
        locationManager.stopUpdatingLocation()
        lastLocation = nil
        isUpdatingLocation = false
    }
    
    func endTracking(){
        locationManager.stopUpdatingLocation()
        lastLocation = nil
        distance = Measurement(value: 0, unit: UnitLength.kilometers)
        isUpdatingLocation = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location update happened")
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = lastLocation {
                let delta = newLocation.distance(from: lastLocation)
                
                //convert from meters to kilometers
                distance = distance + Measurement(value: delta / 1000, unit: UnitLength.kilometers)
                print("distance" + distance.description)
                DispatchQueue.global(qos: .background).async {
                    NotificationCenter.default.post(name: .distanceChanged, object: self.distance)
                }
            }
            
            lastLocation = newLocation
        }
    }
}

extension Notification.Name {
    static let distanceChanged = Notification.Name("DistanceChanged")
}
