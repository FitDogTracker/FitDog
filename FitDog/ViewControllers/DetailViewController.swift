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

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBarBackgroundView: UIView!
    @IBOutlet weak var weeklyProgressLabel: UILabel!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    @IBOutlet weak var sundayView: UIView!
    @IBOutlet weak var weeklyTableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var goalButton: UIButton!
    
    var dog: Dog!
    var photoImage: UIImage!
    var goal : Goal!
    var walks : [Walk]!
    var distanceWalked : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dog.name
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "ChalkboardSE-Bold", size: 25)!]
        view.backgroundColor = UIColor(hexString: "#fffaf0ff")
        weeklyTableView.backgroundColor = UIColor(hexString: "#fffaf0ff")
        
        // Do any additional setup after loading the view.
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.image = photoImage
        completionLabel.text = makeCompletionLabelText()
        let frame = progressBarView.frame
        progressBarView.frame = CGRect(x: frame.minX, y: frame.minY, width: makeProgressWidth(), height: frame.height)
        progressBarView.backgroundColor = UIColor(hexString: dog.color + "ff")
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor(hexString: "#fffaf0ff")?.cgColor
        
        backgroundImageView.image = photoImage
        let blur = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurView)
        
        goalButton.setTitle("View " + dog.name + "'s Goals", for: .normal)
        goalButton.sizeToFit()
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
    
    func makeProgressWidth() -> CGFloat{
        let backgroundWidth = progressBarBackgroundView.frame.width
        let weeklyGoal = goal.distance * 7
        if(distanceWalked >= weeklyGoal){
            return backgroundWidth
        }
        return backgroundWidth * CGFloat(distanceWalked / weeklyGoal)
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
