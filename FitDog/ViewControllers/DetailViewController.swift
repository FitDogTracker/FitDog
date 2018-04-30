//
//  DetailViewController.swift
//  FitDog
//
//  Created by Kristine Laranjo on 4/2/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    @IBOutlet weak var DogNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBackgroundView: UIView!
    @IBOutlet weak var weeklyProgressLabel: UILabel!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    @IBOutlet weak var sundayView: UIView!
    @IBOutlet weak var weeklyTableView: UITableView!
    
    var dog: Dog!
    var photoImage: UIImage!
    var goal : Goal!
    var walks : [Walk]!
    var distanceWalked : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.image = photoImage
        completionLabel.text = makeCompletionLabelText()
        progressBarView.frame = CGRect(x: progressBarView.frame.minX, y: progressBarView.frame.minY, width: calculateProgressWidth(), height: progressBarView.frame.height)
        DogNameLabel.text = dog.name
    }
    
    func makeCompletionLabelText() -> String{
        let weeklyGoal = goal.distance * 7
        if(distanceWalked <= weeklyGoal){
                var distUntilComplete = weeklyGoal - distanceWalked
                distUntilComplete = (distUntilComplete * 100).rounded() / 100
                return distUntilComplete.description + "km until goal"
        }
        var distOverGoal = distanceWalked - weeklyGoal
        distOverGoal = (distOverGoal * 100).rounded() / 100
        return distOverGoal.description + "km over goal"
    }
    
    func calculateProgressWidth() -> CGFloat{
        let weeklyGoal = CGFloat(goal.distance * 7)
        let width = progressBackgroundView.frame.width * (CGFloat(distanceWalked) / weeklyGoal)
        if(width >= progressBackgroundView.frame.width){
            return progressBackgroundView.frame.width
        }
        return width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
