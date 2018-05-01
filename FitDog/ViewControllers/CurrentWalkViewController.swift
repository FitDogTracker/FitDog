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
    @IBOutlet weak var walkImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var endWalkButton: UIButton!
    
    var dogs: [SelectDogCell]!
    var currentDogs: [Dog] = []
    var currentGoals: [Goal] = []
    var currentWalks: [Walk] = []
    var currentDistance = Measurement(value: 0, unit: UnitLength.kilometers)
    var selectedDogIndex: Int!{
        didSet{
            let dog = currentDogs[selectedDogIndex]
            nameLabel.text = dog.name + " has completed"
            if(currentGoals.count > selectedDogIndex){
                let goal = currentGoals[selectedDogIndex]
                foregroundProgressView.backgroundColor = UIColor(hexString:currentDogs[selectedDogIndex].color + "FF")
                updateProgressBar()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foregroundProgressView.frame = CGRect(x: foregroundProgressView.frame.minX, y: foregroundProgressView.frame.minY, width:0, height: foregroundProgressView.frame.height)
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#b22222ff")
        self.view.backgroundColor = UIColor(hexString: "#fffaf0ff")
        currentWalkersCollectionView.backgroundColor = UIColor(hexString: "#fffaf0ff")
        backgroundProgressView.layer.borderWidth = 2
        backgroundProgressView.layer.masksToBounds = false
        backgroundProgressView.layer.borderColor = UIColor(hexString: "#4d2600ff")?.cgColor
        backgroundProgressView.layer.cornerRadius = backgroundProgressView.frame.height/4
        backgroundProgressView.clipsToBounds = true
        
        foregroundProgressView.frame.size.width = 0
        foregroundProgressView.layer.borderWidth = 2
        foregroundProgressView.layer.masksToBounds = false
        foregroundProgressView.layer.borderColor = UIColor(hexString: "#4d2600ff")?.cgColor
        foregroundProgressView.layer.cornerRadius = foregroundProgressView.frame.height/4
        foregroundProgressView.clipsToBounds = true
        
        endWalkButton.backgroundColor = UIColor(hexString: "#fffaf0ff")
        endWalkButton.layer.borderWidth = 2
        endWalkButton.layer.masksToBounds = false
        endWalkButton.layer.borderColor = UIColor(hexString: "#4d2600ff")?.cgColor
        endWalkButton.layer.cornerRadius = endWalkButton.frame.height/2
        endWalkButton.clipsToBounds = true
        endWalkButton.backgroundColor = UIColor(hexString: "#b22222ff")
        endWalkButton.setTitleColor(UIColor.white, for: .normal)
        
        // Do any additional setup after loading the view.
        fetchGoals()
        setupWalks()
        NotificationCenter.default.addObserver(self, selector: #selector(onDistanceUpdate(notification:)), name: .distanceChanged, object: nil)
        DistanceTracker.shared.startTracking()
        currentWalkersCollectionView.delegate = self
        currentWalkersCollectionView.dataSource = self

        currentWalkersCollectionView.allowsSelection = true
        self.selectedDogIndex = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .distanceChanged, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func onDistanceUpdate(notification: Notification){
        self.currentDistance = notification.object as! Measurement
        var labelText = ((self.currentDistance.value * 100).rounded() / 100).description
        if(self.currentGoals.count > self.selectedDogIndex){
            labelText += "/" + self.currentGoals[self.selectedDogIndex].distance.description
        }
        labelText += " km"
        DispatchQueue.main.async {
            self.updateProgressBar()//TODO: check if this is the correct place for this method
            self.goalLabel.text = labelText
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = currentWalkersCollectionView.dequeueReusableCell(withReuseIdentifier: "CurrentDogCell", for: indexPath) as! CurrentDogCell
        cell.dog = currentDogs[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDogIndex = indexPath.row
    }
    
    @IBAction func didTapEndWalk(_ sender: Any) {
        saveWalks()
        DistanceTracker.shared.endTracking()
    }
    
    func fetchGoals(){
        for dog in currentDogs{
            let query = Goal.query()
            query?.whereKey("dog", equalTo: dog)
            query?.limit = 1
            query?.findObjectsInBackground(block: { (goals, err) in
                if let goals = goals{
                    self.currentGoals.append(goals[0] as! Goal)
                    self.selectedDogIndex = 0 //reset to 0 after goals are fetched to load goals
                }
            })
        }
    }
    
    func setupWalks(){
        for dog in currentDogs{
            let walk = Walk()
            walk.startTime = Date()
            walk.dog = dog
            currentWalks.append(walk)
        }
    }
    
    func saveWalks(){
        for walk in currentWalks{
            walk.endTime = Date()
            walk.distance = currentDistance.value
            walk.saveInBackground()
        }
    }
    
    func updateProgressBar(){
        if(currentGoals.count > selectedDogIndex){
            let goal = currentGoals[selectedDogIndex]
            var progressWidth = backgroundProgressView.frame.width * CGFloat(currentDistance.value / goal.distance)
            if(progressWidth > backgroundProgressView.frame.width){// make sure not to go oversized
                progressWidth = backgroundProgressView.frame.width
            }
            foregroundProgressView.frame = CGRect(x: foregroundProgressView.frame.minX, y: foregroundProgressView.frame.minY, width: progressWidth, height: foregroundProgressView.frame.height)
            walkImageViewLeadingConstraint.constant = foregroundProgressView.frame.minX + foregroundProgressView.frame.width + 21
        }
    }
    
}
