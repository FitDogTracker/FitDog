//
//  DogInfoViewController.swift
//  FitDog
//
//  Created by Kristine Laranjo on 3/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse
import SwiftHSVColorPicker

class DogInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    var dogName: String?
    var dogImage: UIImage?
    var dogColor: UIColor?
    var picker: UIImagePickerController!
    var colorPicker: SwiftHSVColorPicker!
    var selectButton: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#f0f8ffff")
        self.view.backgroundColor = UIColor(hexString: "#f0f8ffff")
        let screenSize = UIScreen.main.bounds
        colorPicker = SwiftHSVColorPicker(frame: CGRect(origin: .init(x: screenSize.width/10, y: screenSize.height/4.8), size: CGSize(width: 300, height: 400)))
        let selectSize = colorPicker.frame.size
        selectButton = UIButton(frame: CGRect(x: selectSize.width/2 - 30, y: selectSize.height + 120, width: 150, height: 100))
        selectButton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Bold", size: 20)
        selectButton.backgroundColor = UIColor.lightGray
        selectButton.setTitle("Select Color", for: .normal)
        selectButton.addTarget(self, action: #selector(didTapSelectColor), for: .touchUpInside)
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
     
        logoImageView.layer.cornerRadius = logoImageView.frame.height/2
        logoImageView.clipsToBounds = true
        
        profileImageView.layer.borderWidth = 10
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        colorButton.backgroundColor = .clear
        colorButton.layer.cornerRadius = 12
        colorButton.layer.borderWidth = 1
        colorButton.layer.borderColor = UIColor(hexString: "#4d2600ff")?.cgColor
        
        photoButton.backgroundColor = .clear
        photoButton.layer.cornerRadius = 12
        photoButton.layer.borderWidth = 1
        photoButton.layer.borderColor = UIColor(hexString: "#4d2600ff")?.cgColor
        
        submitButton.backgroundColor = .clear
        submitButton.layer.cornerRadius = 12
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(hexString: "#4d2600ff")?.cgColor
        
        nameTextField.textColor = UIColor(hexString: "#4d2600ff")
        nameTextField.backgroundColor = .clear
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor(hexString: "#4d2600ff")?.cgColor
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
        if(colorPicker.isHidden == true) {
            colorPicker.isHidden = false
            selectButton.isHidden = false
        }
        colorPicker.backgroundColor = UIColor.lightGray
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(colorPicker)
        self.view.addSubview(selectButton)
        colorPicker.setViewColor(UIColor.red)
    }
    
    @objc func didTapSelectColor(sender: UIButton!) {
        print("Button tapped")
        print(colorPicker.color)
        colorPicker.isHidden = true
        selectButton.isHidden = true
        dogColor = colorPicker.color
        profileImageView.layer.borderColor = dogColor?.cgColor
        self.view.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor(hexString: "#f0f8ffff")
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
            if(isComplete){
                self.performSegue(withIdentifier: "dogInfoSegue", sender: nil)
            }
            if(error != nil){
                print(error?.localizedDescription)
            }
        }
    }

}
