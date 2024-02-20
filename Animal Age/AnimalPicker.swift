//
//  AnimalPicker.swift
//  Animal Age Converter
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

import CoreData
import ProgressHUD
import QuartzCore
import UIKit
import WebKit

class AnimalPicker: UIViewController, AnimalPickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    @IBOutlet var mainArea: UIView!
    @IBOutlet var graphView: WKWebView!
    @IBOutlet var AnimalButt: UIButton!
    @IBOutlet var AnimalButt2: UIButton!
    @IBOutlet var AgeButt: UIButton!
    @IBOutlet var convertButt: UIButton!
    @IBOutlet var HumanAge: UITextField!
    @IBOutlet var HumanAge2: UITextField!
    @IBOutlet var ManView: UIView!
    @IBOutlet var ManView2: UIView!
    @IBOutlet var calcText: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var backView: UIView!
    @IBOutlet var frontView: UIView!
    @IBOutlet var masterFlip: UIView!
    @IBOutlet var scrollView: UIScrollView!
    var simpleTableVC: UITableViewController?

    @IBAction func save(_ sender: Any) {

        let alert = UIAlertController(title: "What is your pets name?", message: "Save your pets name in the database.", preferredStyle: .alert) // 7
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {
                _ in print("FOO ")
            
            ProgressHUD.animate("Loading...")

            let context = self.managedObjectContext()

            let currDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/YY"
            let dateString = dateFormatter.string(from: currDate)

            var newDevice: NSManagedObject? = nil
            if let context = context {
                newDevice = NSEntityDescription.insertNewObject(forEntityName: "List", into: context)
            }
            newDevice?.setValue(self.resultLabel?.text, forKey: "age")
            newDevice?.setValue(self.AnimalButt.currentTitle, forKey: "name")
            newDevice?.setValue(dateString, forKey: "date")
            newDevice?.setValue(self.calcText?.text, forKey: "notes")
            newDevice?.setValue(alert.textFields?[0].text, forKey: "pet_name")

            let image = UIImage(named: "cute.png")
            let imageData:NSData? = image!.pngData() as NSData?
            newDevice?.setValue(imageData, forKey: "img")

            self.perform(#selector(Calc.dogAnswer(_:)), with: nil, afterDelay: 0.50)
            
        }))
        
        


        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Pet Name"
        })
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    

    private var animalArray: [AnyHashable]?

    func managedObjectContext() -> NSManagedObjectContext? {

        var context: NSManagedObjectContext? = nil
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if delegate?.perform(#selector(getter: AppDelegate.persistentContainer)) != nil {
            context = delegate?.persistentContainer?.viewContext
        }

        return context
    }

    @objc func hideHud(_ timer: Timer?) {
        ProgressHUD.dismiss()
    }

    @objc func dogAnswer(_ timer: Timer?) {
        ProgressHUD.succeed()
        perform(#selector(Calc.hideHud(_:)), with: nil, afterDelay: 100)
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        scrollView.addSubview(mainArea)//if the contentView is not already inside your scrollview in your xib/StoryBoard doc

        scrollView.contentSize = mainArea.frame.size //sets ScrollView content size
        
        navigationController?.navigationBar.barStyle = .default
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(named: "BarColor")

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "flipPref")
        let flipin = defaults.object(forKey: "flipPref") as? String
        let flipValue = Int(Double(flipin ?? "") ?? 0.0)
        print("Flip Status: \(flipValue)")




        backView.isHidden = true

        if flipValue == 0 {
            let results = resultLabel?.text
            let animal = AnimalButt?.currentTitle
            calcText?.text = "You are \(results ?? "") years old in \(animal ?? "") years"
        } else {
            let results = resultLabel?.text
            let animal = AnimalButt2?.currentTitle
            calcText?.text = "You are \(results ?? "") years old in \(animal ?? "") years"
        }

// MARK: - Button Style

        // R: 76 G: 76 B: 76
        let buttColor = UIColor.white

        let layer = AnimalButt?.layer
        layer?.masksToBounds = true
        layer?.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer?.borderWidth = 1.0
        layer?.borderColor = buttColor.cgColor

        let layer2 = AnimalButt2?.layer
        layer2?.masksToBounds = true
        layer2?.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer2?.borderWidth = 1.0
        layer2?.borderColor = buttColor.cgColor

        let calcLayer = AgeButt.layer
        calcLayer.masksToBounds = true
        calcLayer.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        calcLayer.borderWidth = 1.0
        calcLayer.borderColor = UIColor.white.cgColor
        AgeButt.backgroundColor = UIColor(named: "BarColor")



// MARK: - Set WebView

        let path1 = Bundle.main.path(forResource: "index", ofType: "html")
        var html: String? = nil
        do {
            html = try String(contentsOfFile: path1 ?? "", encoding: .utf8)
        } catch {
        }
        graphView.loadHTMLString(html ?? "", baseURL: nil)

// MARK: - Set MainView Color

        // R: 190 G: 190 B: 190
        let myColor = UIColor.clear
        let whiteColor = UIColor.white



// MARK: - Set Animal Array

        animalArray = ["Dog", "Cat", "Cow", "Rabbit", "Duck", "Chicken", "Goose"]


// MARK: - Set Buttons / View Colors


        ManView2.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        ManView2.isOpaque = false
        ManView.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        ManView.isOpaque = false

        let layer_man = HumanAge.layer
        layer_man.masksToBounds = true
        layer_man.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer_man.borderWidth = 1.0
        layer_man.borderColor = whiteColor.cgColor


        let layer_man2 = HumanAge2.layer
        layer_man2.masksToBounds = true
        layer_man2.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer_man2.borderWidth = 1.0
        layer_man2.borderColor = whiteColor.cgColor


        HumanAge.backgroundColor = myColor
        HumanAge.leftView = ManView
        HumanAge.leftViewMode = .always


        HumanAge2.backgroundColor = myColor
        HumanAge2.leftView = ManView2
        HumanAge2.leftViewMode = .always

// MARK: - Set Done Button on Number Pad

        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelNumberPad)), UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()



        HumanAge.inputAccessoryView = numberToolbar

        let numberToolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        numberToolbar2.barStyle = .default
        numberToolbar2.items = [UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelNumberPad2)), UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneWithNumberPad2))]
        numberToolbar2.sizeToFit()
        HumanAge2.inputAccessoryView = numberToolbar2

        resultLabel?.font = UIFont.systemFont(ofSize: 200)


        let insets = UIApplication.shared.delegate?.window??.safeAreaInsets
        if (insets?.top ?? 0.0) > 0 {



            var mycviewFrame = graphView.frame
            mycviewFrame.origin.y = 50
            mycviewFrame.origin.x = 0
            graphView.frame = mycviewFrame

            var ageFrame = AgeButt.frame
            ageFrame.origin.y = -10
            ageFrame.origin.x = 10
            AgeButt.frame = ageFrame
        }


    }

    @objc func cancelNumberPad() {
        HumanAge.resignFirstResponder()
        HumanAge.text = ""
        let theInstance = Calc()
        theInstance.calcTapped()

    }

    @objc func cancelNumberPad2() {
        HumanAge2.resignFirstResponder()
        HumanAge2.text = ""
        let theInstance = Calc()
        theInstance.calcTapped()

    }

    @objc func doneWithNumberPad() {
        // NSString *numberFromTheKeyboard = HumanAge.text;
        HumanAge.resignFirstResponder()
        let theInstance = Calc()
        theInstance.calcTapped()
    }

    @objc func doneWithNumberPad2() {
        // NSString *numberFromTheKeyboard = HumanAge.text;
        HumanAge2.resignFirstResponder()
        let theInstance = Calc()
        theInstance.calcTapped()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count ?? 0) + string.count - range.length
        return (newLength > 2) ? false : true
    }

    
    @IBAction func selectAnimalPressed(_ sender: Any) {

        let navigationController = storyboard?.instantiateViewController(withIdentifier: "SimpleTableVC") as? UINavigationController
        let tableViewController = navigationController?.viewControllers[0] as? PickerTableView
        tableViewController?.tableData = animalArray
        tableViewController?.navigationItem.title = "Animals"
        tableViewController?.delegate = self
        self.navigationController?.popToRootViewController(animated: true)
        if let navigationController = navigationController {
            present(navigationController, animated: true)
        }



    }

    @objc func itemSelectedatRow(_ row: Int) {

        print(String(format: "row %lu selected", UInt(row)))
        AnimalButt?.setTitle(animalArray?[row] as? String, for: .normal)
        AnimalButt2?.setTitle(animalArray?[row] as? String, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
