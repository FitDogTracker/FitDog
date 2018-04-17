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
    var dogs: [Dog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDistanceUpdate(notification:)), name: .distanceChanged, object: nil)
        DistanceTracker.shared.startTracking()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .distanceChanged, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onDistanceUpdate(notification: Notification){
        let distance = notification.object as! Measurement
        let labelText = ((distance.value * 100).rounded() / 100).description + " km"
        DispatchQueue.main.async {
            self.goalLabel.text = labelText
        }
    }
    
    @IBAction func didTapEndWalk(_ sender: Any) {
        DistanceTracker.shared.endTracking()
    }
}
