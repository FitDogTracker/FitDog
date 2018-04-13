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
        fetchPosts(refresh: refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapStartWalk(_ sender: Any) {
        if (dogs.count > 1) {
            performSegue(withIdentifier: "SelectDogSegue", sender: dogs)
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CurrentWalkViewController") as! CurrentWalkViewController
            self.present(nextViewController, animated:true, completion:nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let cell = sender as! DogCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let image = cell.profileImageView.image
            destination.photoImage = image
        }
    }
}
