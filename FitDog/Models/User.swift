//
//  User.swift
//  FitDog
//
//  Created by Coleman on 4/2/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import Foundation
import Parse

class User: PFObject, PFSubclassing {
    @NSManaged var dog: [Dog]
    
    class func parseClassName() -> String {
        return "UserDog"
    }
}
