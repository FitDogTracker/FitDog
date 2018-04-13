//
//  SelectDogViewController.swift
//  FitDog
//
//  Created by Coleman on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse

class SelectDogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var dogs: [Dog] = []
    var selectedDogs: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        fetchPosts(refresh: refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). Cell"
        cell.accessoryType = self.selectedDogs.contains(indexPath.row) ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedDogs.contains(indexPath.row) {
            self.selectedDogs.remove(at: self.selectedDogs.index(of: indexPath.row)!)
        } else {
            self.selectedDogs.append(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
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
        tableView.reloadData()
        refresh.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
