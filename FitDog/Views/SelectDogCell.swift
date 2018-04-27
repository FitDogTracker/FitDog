//
//  SelectDogCell.swift
//  FitDog
//
//  Created by Coleman on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SelectDogCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var dog: PFObject! {
        didSet {
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.clipsToBounds = true
            self.profileImageView.file = dog["photo"] as? PFFile
            self.profileImageView.loadInBackground()
            self.nameLabel.text = dog["name"] as? String
            checkmarkImage.image = #imageLiteral(resourceName: "check3")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected{
            checkmarkImage.isHidden = false
            nameLabel.textColor = UIColor(hexString: "#b22222ff")
        } else{
            checkmarkImage.isHidden = true
            nameLabel.textColor = UIColor(hexString: "#4d2600ff")
        }
    }
}
