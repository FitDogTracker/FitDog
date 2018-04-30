//
//  HomeViewController.swift
//  FitDog
//
//  Created by Kristine Laranjo on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dogTableView: UITableView!
    @IBOutlet weak var startWalkButton: UIButton!
    
    var dogs: [Dog] = []
    var goals: [Goal] = []
    var dogsToWalks = [String:[Walk]]()//walks that the user has taken this week keyed by the dog
    var dogsToDistance = [String:Double]()//dogs mapped to the distance they have walked this week
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "ChalkboardSE-Bold", size: 25)!]
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#b22222ff")
        self.view.backgroundColor = UIColor(hexString: "#fffaf0ff")
        dogTableView.backgroundColor = UIColor(hexString: "#fffaf0ff")
        
        startWalkButton.tintColor = UINavigationBar.appearance().tintColor
        startWalkButton.layer.borderWidth = 2
        startWalkButton.layer.masksToBounds = false
        startWalkButton.layer.borderColor = UIColor(hexString: "#4d2600ff")?.cgColor
        startWalkButton.layer.cornerRadius = startWalkButton.frame.height/2
        startWalkButton.clipsToBounds = true
        startWalkButton.backgroundColor = UIColor(hexString: "#b22222ff")

        // Do any additional setup after loading the view.
        dogTableView.delegate = self
        dogTableView.dataSource = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        dogTableView.insertSubview(refreshControl, at: 0)
        dogTableView.tableFooterView = makeFooterAddDogButton()
        fetchPosts(refresh: refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapStartWalk(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if (dogs.count > 1) {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SelectDogViewController") as! SelectDogViewController
            self.performSegue(withIdentifier: "SelectDogSegue", sender: nextViewController)
        } else {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CurrentWalkViewController") as! CurrentWalkViewController
            nextViewController.currentDogs = dogs
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PFUser.current()?.remove(dogs[indexPath.row], forKey: "dogs")
            PFUser.current()?.saveInBackground()
            self.dogs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogCell
        if(goals.count > indexPath.row){
            cell.goal = goals[indexPath.row]
        }
        if let dist = dogsToDistance[dogs[indexPath.row].objectId!]{
            print("dist: " + dist.description)
            cell.distanceWalked = dist
        }
        
        cell.dog = dogs[indexPath.row]
        cell.backgroundColor = UIColor(hexString: "#fffaf0ff")
        
        return cell
    }
    
    @objc func fetchPosts(refresh: UIRefreshControl){
        let dogPointers = PFUser.current()?.value(forKey: "dogs") as! [Dog]
        
        //load dog data from pointers within the user object
        for dog in dogPointers{
            dog.fetchInBackground { (pFObj, err) in
                if let dog = pFObj as? Dog{
                    if let dogIndex = self.dogs.index(of: dog){
                        self.dogs[dogIndex] = dog
                    }
                    else{
                        self.dogs.append(dog)
                    }
                    let walkQuery = Walk.query()
                    walkQuery?.whereKey("createdAt", greaterThanOrEqualTo: Date().previous(Date.Weekday.monday,considerToday: true))
                    walkQuery?.whereKey("dog", equalTo: dog)
                    walkQuery?.findObjectsInBackground { (objArr, err) in
                        let walkArr = objArr as! [Walk]
                        self.dogsToWalks[dog.objectId!] = walkArr
                        var distance = 0.0
                        for walk in walkArr{
                            distance += walk.distance
                        }
                        self.dogsToDistance[dog.objectId!] = distance
                        self.dogTableView.reloadData()//reload data
                    }
                    let goalQuery = Goal.query()
                    goalQuery?.whereKey("dog", equalTo: dog)
                    goalQuery?.limit = 1
                    goalQuery?.findObjectsInBackground { (goals, err) in
                        if let goals = goals{
                            print("goals array: " + goals.description)
                            self.goals.append(goals[0] as! Goal)
                            self.dogTableView.reloadData()
                        }
                        if let err = err{
                            print(err.localizedDescription)
                        }
                    }
                }
            }
        }
        dogTableView.reloadData()
        refresh.endRefreshing()
    }
    
    @IBAction func didTapAddDog(sender:UIButton){
        print("user tapped add dog button!")
        self.performSegue(withIdentifier: "HomeViewToDogInfoSegue", sender: nil)
    }
    
    func makeFooterAddDogButton() -> UIButton{
        //TODO: set colors for font and background to the same as the start walk button
        let result = UIButton(type: UIButtonType.system)
        result.frame = CGRect(x: 0, y: 0, width: 0, height: 45)
        result.setTitle("+  Add Dog", for: .normal)
        result.titleLabel!.font = UIFont(name: "ChalkboardSE-Regular", size: 25)
        result.setTitleColor(UIColor(hexString: "#4d2600ff"), for: .normal)
        result.addTarget(self, action: #selector(didTapAddDog), for: UIControlEvents.touchUpInside)
        return result;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let cell = sender as! DogCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let image = cell.profileImageView.image
            destination.photoImage = image
            destination.dog = cell.dog as! Dog
        } else if let destination = segue.destination as? SelectDogViewController {
            destination.tableView = dogTableView
            destination.dogs = dogs
        }
    }
}
