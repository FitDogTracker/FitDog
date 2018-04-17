//
//  CurrentDogCell.swift
//  FitDog
//
//  Created by Kristine Laranjo on 4/16/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CurrentDogCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: PFImageView!
    
    var dog: PFObject! {
        didSet {
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.clipsToBounds = true
            self.profileImageView.file = dog["photo"] as? PFFile
            self.profileImageView.loadInBackground()
            self.nameLabel.text = dog["name"] as? String
        }
    }
    
}
