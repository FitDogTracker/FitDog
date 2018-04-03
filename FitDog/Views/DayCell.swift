//
//  DayCell.swift
//  FitDog
//
//  Created by Kristine Laranjo on 4/2/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell {

    @IBOutlet weak var completedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
