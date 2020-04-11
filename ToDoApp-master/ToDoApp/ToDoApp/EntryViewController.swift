//
//  SecondViewController.swift
//  ToDoApp
//
//  Created by Field Employee on 3/24/20.
//  Copyright © 2020 Tom Kew-Goodale. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var titleField: UITextField!
    
    @IBOutlet weak var DescriptionField: UITextField!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    var update: (() -> Void)?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self//when enter is pressed save start
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveTask))

        // Do any additional setup after loading the view.
    }
    
 /*   @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
 */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
    }

    @objc func saveTask() {
        
        
        
        guard let text = titleField.text, !text.isEmpty else{
            return
        }
        
        let Destext = "\(DescriptionField.text ?? "") : "
        let dateFormatr = DateFormatter()
        dateFormatr.dateFormat = "dd MMMM, h:mm a"
        let strDate = dateFormatr.string(from: (DatePicker?.date)!)
        
        guard var count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        
        
       let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        UserDefaults().set(Destext+strDate, forKey: "SubTask_\(newCount)")
        
      //  UserDefaults().set(imageView, forKey: "Image_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    
    }
    
  /*  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
     
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
    */
}
