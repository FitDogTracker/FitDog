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
    
    var dog: Dog!
    var photoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dog.name
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "ChalkboardSE-Bold", size: 25)!]
        view.backgroundColor = UIColor(hexString: "#fffaf0ff")
        weeklyTableView.backgroundColor = UIColor(hexString: "f0f8ffff")
        
        // Do any additional setup after loading the view.
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.image = photoImage
        
        backgroundImageView.image = photoImage
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurView)
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
