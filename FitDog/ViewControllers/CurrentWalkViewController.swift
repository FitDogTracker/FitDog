//
//  CurrentWalkViewController.swift
//  FitDog
//
//  Created by Coleman on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit

class CurrentWalkViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var walkImageView: UIImageView!
    @IBOutlet weak var backgroundProgressView: UIView!
    @IBOutlet weak var foregroundProgressView: UIView!
    @IBOutlet weak var currentWalkersCollectionView: UICollectionView!
    var dogs: [SelectDogCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapEndWalk(_ sender: Any) {
        
    }
}
