//
//  Dog.swift
//  FitDog
//
//  Created by Coleman on 4/2/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import Foundation
import Parse

class Dog: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var color: String
    @NSManaged var photo: PFFile
    
    class func parseClassName() -> String {
        return "Dog"
    }
    
    class func SaveDog(image: UIImage?, name: String?, color: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let dog = Dog()
        print("id")
        print(dog.objectId)
        // Add relevant fields to the object
        dog.photo = getPFFileFromImage(image: image)! // PFFile column type
        dog.color = color!
        dog.name = name!
        // Save object (following function will save the object in Parse asynchronously)
        //dog.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
