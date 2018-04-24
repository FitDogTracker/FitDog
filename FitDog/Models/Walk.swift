//
//  Walk.swift
//  FitDog
//
//  Created by Coleman on 4/18/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import Foundation
import Parse

class Walk: PFObject, PFSubclassing{
    @NSManaged var dog: Dog
    @NSManaged var distance: Double
    @NSManaged var startTime: Date
    @NSManaged var endTime: Date
    
    class func parseClassName() -> String {
        return "Walk"
    }

}
