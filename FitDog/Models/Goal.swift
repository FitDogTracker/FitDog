//
//  Goal.swift
//  FitDog
//
//  Created by Coleman on 4/2/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import Foundation
//import Parse

class Goal/*: PFObject, PFSubclassing*/ {
    //@NSManaged var dog : Dog
    @NSManaged var progress: Double
    @NSManaged var distance: URL //PFFile
    @NSManaged var frequency: String
    @NSManaged var startDate: Date
    @NSManaged var endDate: Date
    
    
    class func parseClassName() -> String {
        var col = 
        return "Goal"
    }
}