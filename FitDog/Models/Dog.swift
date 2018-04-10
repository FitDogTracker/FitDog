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
        var dog = Dog()
        print("id")
        print(dog.objectId)
        // Add relevant fields to the object
        dog.photo = getPFFileFromImage(image: image)! // PFFile column type
        dog.color = color!
        dog.name = name!
        
        dog.saveInBackground { (isComplete, err) in
            if(isComplete){
                dog.fetchInBackground(block: { (dbDog, err) in
                    if(err == nil){
                        dog = dbDog as! Dog
                        let usr = PFUser.current()!
                        usr.add(dog, forKey: "dogs")
                        usr.saveInBackground()
                        let goal = Goal.getDefault(dog: dog)
                        goal.saveInBackground()
                        completion?(true,nil);
                    }
                    else{
                        print(err?.localizedDescription)
                        completion?(true,err);
                    }
                })
            }
            else{
                print(err?.localizedDescription)
                completion?(false,err);
            }
        }
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
