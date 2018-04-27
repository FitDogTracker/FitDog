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
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.clipsToBounds = true
            self.profileImageView.file = dog["photo"] as? PFFile
            self.profileImageView.loadInBackground()
            self.nameLabel.text = dog["name"] as? String
            self.progressBackgroundView.backgroundColor = UIColor .gray
            let color = dog["color"] as! String
            self.progressForegroundView.backgroundColor = UIColor(hexString: color + "ff")
        }
    }
    
    var goal: Goal? {
        didSet {
            showProgress()
        }
    }
    
    var distanceWalked: Double?{
        didSet{
            showProgress()
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
    
    func showProgress() {
        if let distanceWalked = distanceWalked{
            var labelText = ((distanceWalked * 100).rounded() / 100).description
            if let goal = goal{
                let weeklyDistanceGoal = goal.distance * 7
                labelText += "/" + weeklyDistanceGoal.description
                var progressWidth = progressBackgroundView.frame.width * CGFloat(distanceWalked / weeklyDistanceGoal)
                if(progressWidth > progressBackgroundView.frame.width){// make sure not to go oversized
                    progressWidth = progressBackgroundView.frame.width
                }
                print("progress Width" + progressWidth.description)
                progressForegroundView.frame = CGRect(x: progressForegroundView.frame.minX, y: progressForegroundView.frame.minY, width: progressWidth, height: progressForegroundView.frame.height)
            }
            labelText += " km"
            completionLabel.text = labelText
        }
    }

}
