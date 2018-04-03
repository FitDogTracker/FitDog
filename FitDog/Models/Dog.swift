//
//  Dog.swift
//  FitDog
//
//  Created by Coleman on 4/2/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import Foundation
//import Parse

class Dog/*: PFObject, PFSubclassing*/ {
    @NSManaged var name: String
    @NSManaged var color: String
    @NSManaged var photo: URL //PFFile
    
    
    class func parseClassName() -> String {
        return "Dog"
    }
}
