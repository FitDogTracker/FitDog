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
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dogs: [Dog]!
    var selectedDogs: [SelectDogCell] = []
    var currentDogs: [Dog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#f0f8ffff")
        self.view.backgroundColor = UIColor(hexString: "#f0f8ffff")
        tableView.backgroundColor = UIColor(hexString: "#f0f8ffff")
        goButton.backgroundColor = UIColor(hexString: "#f0f8ffff")
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDogCell", for: indexPath) as! SelectDogCell
        cell.dog = dogs[indexPath.row]
        cell.backgroundColor = UIColor(hexString: "#f0f8ffff")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectDogCell
        isValid()
        if cell.isSelected {
            selectedDogs.append(cell)
            currentDogs.append(dogs[indexPath.row])
        }
        isValid()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectDogCell
        var index = 0
        isValid()
        if cell.isSelected == false {
            for dog in selectedDogs {
                if selectedDogs.contains(dog) {
                    selectedDogs.remove(at: index)
                    currentDogs.remove(at: index)
                    isValid()
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
    
    func isValid() {
        if (selectedDogs.count == 0) {
            goButton.backgroundColor = UIColor(hexString: "#f0f8ffff")
            goButton.setTitleColor(UIColor(red:91, green:49, blue:11), for: .normal)
        } else {
            goButton.backgroundColor = UIColor(red: 108, green: 230, blue: 121)
            goButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
}
