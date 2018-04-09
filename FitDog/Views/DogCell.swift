//
//  DogTableViewCell.swift
//  FitDog
//
//  Created by Kristine Laranjo on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DogCell: UITableViewCell {

    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressBackgroundView: UIView!
    @IBOutlet weak var progressForegroundView: UIView!
    @IBOutlet weak var completionLabel: UILabel!
    
    var dog: PFObject! {
        didSet {
            self.profileImageView.file = dog["photo"] as? PFFile
            self.profileImageView.loadInBackground()
            self.nameLabel.text = dog["name"] as? String
            self.progressBackgroundView.backgroundColor = UIColor .gray
            self.progressForegroundView.backgroundColor = dog["color"] as? UIColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
