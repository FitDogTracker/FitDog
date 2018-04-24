//
//  Goal.swift
//  FitDog
//
//  Created by Coleman on 4/2/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import Foundation
import Parse

class Goal: PFObject, PFSubclassing {
    @NSManaged var dog: Dog
    @NSManaged var progress: Double
    @NSManaged var distance: Double
    
    class func parseClassName() -> String {
        return "Goal"
    }
    class func getDefault(dog:Dog) -> Goal{
        let goal = Goal()
        goal.dog = dog
        goal.distance = 3.00 //default should take about a half hour every day
        
        return goal
    }
    
}
