//
//  CurrentWalkViewController.swift
//  FitDog
//
//  Created by Coleman on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit

class CurrentWalkViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var walkImageView: UIImageView!
    @IBOutlet weak var backgroundProgressView: UIView!
    @IBOutlet weak var foregroundProgressView: UIView!
    @IBOutlet weak var currentWalkersCollectionView: UICollectionView!
    var dogs: [SelectDogCell]!
    var currentDogs: [Dog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(onDistanceUpdate(notification:)), name: .distanceChanged, object: nil)
        DistanceTracker.shared.startTracking()

        currentWalkersCollectionView.delegate = self
        currentWalkersCollectionView.dataSource = self
        
        foregroundProgressView.backgroundColor = UIColor(hexString:currentDogs[0].color)
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = currentWalkersCollectionView.dequeueReusableCell(withReuseIdentifier: "CurrentDogCell", for: indexPath) as! CurrentDogCell
        cell.dog = currentDogs[indexPath.row]
        
        return cell
    }
    
    @IBAction func didTapEndWalk(_ sender: Any) {
        DistanceTracker.shared.endTracking()
    }
}
