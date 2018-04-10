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
    @NSManaged var frequency: String
    @NSManaged var startDate: Date
    @NSManaged var endDate: Date
    
    class func parseClassName() -> String {
        return "Goal"
    }
    class func getDefault(dog:Dog) -> Goal{
        let goal = Goal()
        goal.dog = dog
        goal.progress = 0.0
        goal.distance = 21.00 //default should take about a half hour every day
        goal.frequency = "Monday Tuesday Wednesday Thursday Friday Saturday Sunday"
        goal.startDate = Date.today().previous(.monday,considerToday: true)
        goal.endDate = Date.today().next(.monday)
        
        return goal
    }
    
}
