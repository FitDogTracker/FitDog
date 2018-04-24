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
    var dogs: [Dog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        cell.dog = dogs[indexPath.row]
        
        return cell
    }
    
    @objc func fetchPosts(refresh: UIRefreshControl){
        dogs = PFUser.current()?.value(forKey: "dogs") as! [Dog]
        
        //load dog data from pointers within the user object
        for dog in dogs{
            do{
                try dog.fetchIfNeeded()
            }
            catch {
                print("error fetching dog data")
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
        //result.backgroundColor = UIColor(displayP3Red: 0.454, green: 0.772, blue: 0.827, alpha: 1)
        result.setTitle("+ Add Dog", for: .normal)
        //result.titleLabel!.font = UIFont(name: "System", size: 1000.0)
        result.setTitleColor(UIColor.darkText, for: .normal)
        result.addTarget(self, action: #selector(didTapAddDog), for: UIControlEvents.touchUpInside)
        return result;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let cell = sender as! DogCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let image = cell.profileImageView.image
            destination.photoImage = image
        } else if let destination = segue.destination as? SelectDogViewController {
            destination.tableView = dogTableView
            destination.dogs = dogs
        }
    }
}
