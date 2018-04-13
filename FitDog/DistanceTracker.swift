//
//  DistanceTracker.swift
//  FitDog
//
//  Created by Kristine Laranjo on 4/11/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import Foundation
import CoreLocation

class DistanceTracker {
    
    // MARK: - Properties
    
    private static var distance: DistanceTracker = {
        let distanceTracker = DistanceTracker()
        
        // Configuration
        // ...
        
        return distanceTracker
    }()
    
    // MARK: -
    
    let distance: CLLocationDistance
    
    // Initialization
    
    private init() {
        self.distance = 0
    }
    
    // MARK: - Accessors
    
    class func shared() -> DistanceTracker {
        return distance
    }
}
