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
    var dogs: [Dog]!
    var selectedDogs: [SelectDogCell] = []
    var currentDogs: [Dog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDogCell", for: indexPath) as! SelectDogCell
        cell.dog = dogs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectDogCell
        if cell.isSelected {
            selectedDogs.append(cell)
            currentDogs.append(dogs[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectDogCell
        var index = 0
        if cell.isSelected == false {
            for dog in selectedDogs {
                if selectedDogs.contains(dog) {
                    selectedDogs.remove(at: index)
                    currentDogs.remove(at: index)
                    return
                }
                index = index + 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapGo(_ sender: Any) {
        if (selectedDogs.count > 0) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let destination = storyBoard.instantiateViewController(withIdentifier: "CurrentWalkViewController") as! CurrentWalkViewController
            destination.dogs = selectedDogs
            destination.currentDogs = currentDogs
            self.present(destination, animated:true, completion:nil)
        } else {
            print("No dogs selected")
        }
    }
}
