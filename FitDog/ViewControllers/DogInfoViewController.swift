//
//  DogInfoViewController.swift
//  FitDog
//
//  Created by Kristine Laranjo on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit

class DogInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    var dogName: String?
    var dogImage: UIImage?
    var dogColor: String?
    var picker: UIImagePickerController!

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            picker.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            picker.sourceType = .photoLibrary
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        logoImageView.layer.cornerRadius = logoImageView.frame.height/2
        logoImageView.clipsToBounds = true
        
        profileImageView.layer.borderWidth = 10
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        profileImageView.image = originalImage
        dogImage = originalImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapColor(_ sender: Any) {
        //TODO: figure out how to store and retrieve colors
        dogColor = "#FF0000FF"
        var color = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1).cgColor
        profileImageView.layer.borderColor = color
    }
    
    @IBAction func didTapAddPhoto(_ sender: Any) {
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        if(nameTextField.text?.isEmpty)!{
            //print error
            return
        }
        else{
            dogName = nameTextField.text
        }
        if(dogImage == nil){
            //print error message
            return
        }
        if(dogColor == nil){
            //print error message or pick random color
            return
        }
        Dog.SaveDog(image: profileImageView.image, name: nameTextField.text, color: dogColor) { (isComplete, error) in
            if(error != nil){
                print(error?.localizedDescription)
            }
            else{
                self.performSegue(withIdentifier: "dogInfoSegue", sender: nil)
            }
        }
    }

}
