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
        dogColor = "red"
        profileImageView.layer.borderColor = UIColor(named: dogColor!)?.cgColor
    }
    
    @IBAction func didTapAddPhoto(_ sender: Any) {
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        if(nameTextField.text?.isEmpty)!{
            //print error
            return
        }
        if(dogImage == nil){
            //print error message
            return
        }
        if(dogColor == nil){
            //print error message or pick random color
            return
        }
        performSegue(withIdentifier: "dogInfoSegue", sender: nil)
    }

}
