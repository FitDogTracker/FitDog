//
//  SelectDogCell.swift
//  FitDog
//
//  Created by Coleman on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit

class SelectDogCell: UITableViewCell {
    @IBOutlet weak var dogProfileImageView: UIImageView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected {
            checkmarkImage.image = UIImage(named: "check_active")
        } else {
            checkmarkImage.image = UIImage(named: "check_normal")
        }
    }

}
