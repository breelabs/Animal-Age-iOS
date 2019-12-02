//
//  DeviceDetailViewController.swift
//  Animal Age Converter
//
//  Created by Jon on 3/27/17.
//  Copyright © 2017 Jon Brown. All rights reserved.
//

import UIKit
import CoreData

class DeviceDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIBarPositioningDelegate, UINavigationBarDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var pname: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var choose: UIButton!
    @IBOutlet weak var take: UIButton!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var navigationbar: UINavigationBar!
    var device: NSManagedObject?

    @IBAction func save(_ sender: Any) {
        let context = managedObjectContext()

        if device != nil {

            // Update existing device
            device?.setValue(name.text, forKey: "name")
            device?.setValue(age.text, forKey: "age")
            device?.setValue(date.text, forKey: "date")
            device?.setValue(pname.text, forKey: "pet_name")
            device?.setValue(notes.text, forKey: "notes")


            let imageData:NSData? = self.imageView.image!.pngData() as NSData?
            device?.setValue(imageData, forKey: "img")
        } else {

            // Create a new managed object
            var newDevice: NSManagedObject? = nil
            if let context = context {
                newDevice = NSEntityDescription.insertNewObject(forEntityName: "List", into: context)
            }
            newDevice?.setValue(name.text, forKey: "name")
            newDevice?.setValue(age.text, forKey: "age")
            newDevice?.setValue(date.text, forKey: "date")
            newDevice?.setValue(notes.text, forKey: "notes")
            newDevice?.setValue(pname.text, forKey: "pet_name")

            let imageData:NSData? = self.imageView.image!.pngData() as NSData?
            newDevice?.setValue(imageData, forKey: "img")
        }

        if context!.hasChanges {
            do {
                try context?.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }

        dismiss(animated: true)
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func selectPhoto(_ sender: UIButton) {

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary

        present(picker, animated: true)


    }

    @IBAction func takePhoto(_ sender: UIButton) {

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .camera

        present(picker, animated: true)

    }

    @IBAction func clearPhoto(_ sender: UIButton) {
        imageView.image = UIImage(named: "cute.png")
    }

    func managedObjectContext() -> NSManagedObjectContext? {

        var context: NSManagedObjectContext? = nil
        let delegate = UIApplication.shared.delegate as? AppDelegate
        // call "persistentContainer" not "managedObjectContext"
        if delegate?.perform(#selector(getter: AppDelegate.persistentContainer)) != nil {
            // call viewContext from persistentContainer not "managedObjectContext"
            context = delegate?.persistentContainer?.viewContext
        }

        return context
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationbar.delegate = self

        if device != nil {
            name.text = device?.value(forKey: "name") as? String
            date.text = device?.value(forKey: "date") as? String
            age.text = device?.value(forKey: "age") as? String
            pname.text = device?.value(forKey: "pet_name") as? String
            notes.text = device?.value(forKey: "notes") as? String

            var image: UIImage? = nil
            if let value = device?.value(forKey: "img") as? Data {
                image = UIImage(data: value)
            }
            imageView.image = image
        }

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(updateTextField(_:)), for: .valueChanged)
        date.inputView = datePicker


        // R: 76 G: 76 B: 76
        // UIColor *buttColor = [UIColor whiteColor];
        // UIColor *butbackcolor = [UIColor clearColor];
        let grey = UIColor(red: 0.74, green: 0.76, blue: 0.78, alpha: 1.0)

        let layer = notes.layer
        layer.masksToBounds = true
        layer.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer.borderWidth = 1.0
        layer.borderColor = grey.cgColor

        let layer2 = age.layer
        layer2.masksToBounds = true
        layer2.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer2.borderWidth = 1.0
        layer2.borderColor = grey.cgColor

        let layer3 = name.layer
        layer3.masksToBounds = true
        layer3.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer3.borderWidth = 1.0
        layer3.borderColor = grey.cgColor

        let layer4 = pname.layer
        layer4.masksToBounds = true
        layer4.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer4.borderWidth = 1.0
        layer4.borderColor = grey.cgColor


        let layer5 = date.layer
        layer5.masksToBounds = true
        layer5.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer5.borderWidth = 1.0
        layer5.borderColor = grey.cgColor

        let layer6 = choose.layer
        layer6.masksToBounds = true
        layer6.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer6.borderWidth = 1.0
        layer6.borderColor = grey.cgColor
        choose.backgroundColor = grey

        let layer7 = take.layer
        layer7.masksToBounds = true
        layer7.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer7.borderWidth = 1.0
        layer7.borderColor = grey.cgColor
        take.backgroundColor = grey

        let layer8 = clear.layer
        layer8.masksToBounds = true
        layer8.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer8.borderWidth = 1.0
        layer8.borderColor = grey.cgColor
        clear.backgroundColor = grey

        let layer9 = imageView.layer
        layer9.masksToBounds = true
        layer9.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer9.borderWidth = 1.0
        layer9.borderColor = grey.cgColor
        clear.backgroundColor = grey


    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    @objc func updateTextField(_ sender: Any?) {
        let picker = date.inputView as? UIDatePicker

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        var dateString: String? = nil
        if let date1 = picker?.date {
            dateString = dateFormatter.string(from: date1)
        }


        date.text = dateString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = chosenImage

        picker.dismiss(animated: true)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        picker.dismiss(animated: true)

    }
}
