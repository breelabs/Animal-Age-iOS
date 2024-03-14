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
import DGCharts

class AnimalPicker: UIViewController, AnimalPickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    @IBOutlet var mainArea: UIView!
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
    @IBOutlet var webView: HorizontalBarChartView!
    @IBOutlet var backView: UIView!
    @IBOutlet var frontView: UIView!
    @IBOutlet var masterFlip: UIView!
    @IBOutlet var gradientView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var leg1: UIView!
    @IBOutlet var label1: UILabel!
    @IBOutlet var leg2: UIView!
    @IBOutlet var label2: UILabel!
    @IBOutlet var leg3: UIView!
    @IBOutlet var label3: UILabel!
    @IBOutlet var leg4: UIView!
    @IBOutlet var label4: UILabel!
    var simpleTableVC: UITableViewController?
    @IBOutlet var graphBack: UIView!
    
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

    
    func setChart(values: [Double], yvalues: [Double], y2values: [Double], y3values: [Double]) {
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = ""

        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: 0, yValues:  [values[i],yvalues[i],y2values[i],y3values[i]], data: "groupChart")
                   //let dataEntry = BarChartDataEntry(x: Double(i) , y: values[i])
                   dataEntries.append(dataEntry)
       }
        
        print(dataEntries[0].data as Any)
        let barChartDataSet = BarChartDataSet(entries: dataEntries)
        barChartDataSet.drawValuesEnabled = false
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.barWidth = Double(0.40)
        
        
        webView.data = barChartData
        
        let colors = [NSUIColor(red: 192/255.0, green: 57/255.0, blue: 43/255.0, alpha: 1.0),
            NSUIColor(red: 243/255.0, green: 156/255.0, blue: 18/255.0, alpha: 1.0),
            NSUIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0),
            NSUIColor(red: 41/255.0, green: 128/255.0, blue: 185/255.0, alpha: 1.0)]
        barChartDataSet.colors = colors
        
      }
    
    
    func setGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor(named: "GraphBack")?.cgColor as Any, UIColor(named: "GraphBack")?.cgColor as Any]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = gradientView.layer.bounds
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphBack.backgroundColor = UIColor(named: "GraphBackDk")
        
        setGradient()
        leg1.asCircleOne()
        leg2.asCircleTwo()
        label1.text = "Sm."
        label2.text = "Med."
        label3.text = "Lg."
        label4.text = "People."
        leg3.asCircleThree()
        leg4.asCircleFour()
        
// MARK: - Charts Init
        

        self.webView.rightAxis.drawAxisLineEnabled = false
        self.webView.leftAxis.drawAxisLineEnabled = false
        self.webView.xAxis.drawAxisLineEnabled = false
        self.webView.rightAxis.drawLabelsEnabled = false
        self.webView.xAxis.drawLabelsEnabled = false
        self.webView.xAxis.drawGridLinesEnabled = false
        self.webView.rightAxis.drawGridLinesEnabled = false
        self.webView.leftAxis.drawGridLinesEnabled = false
        self.webView.leftAxis.drawLabelsEnabled = false
        self.webView.legend.enabled = true
        self.webView.isUserInteractionEnabled = false
        self.webView.chartDescription.text = nil
        self.webView.leftAxis.spaceMin = 0
        self.webView.leftAxis.spaceMax = 0
        self.webView.leftAxis.spaceTop = 0
        self.webView.leftAxis.spaceBottom = 0
        self.webView.xAxis.spaceMax = 0
        self.webView.rightAxis.spaceMin = 0
        self.webView.rightAxis.spaceMax = 0
        self.webView.rightAxis.spaceTop = 0
        self.webView.rightAxis.spaceBottom = 0
        self.webView.xAxis.spaceMin = 0
        self.webView.xAxis.spaceMax = 0
        self.webView.autoScaleMinMaxEnabled = false
        
        let one = [18.0]
        let two = [10.0]
        let three = [8.0]
        let four = [80.0]
        setChart(values: one, yvalues: two, y2values: three, y3values: four)
        webView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        
// MARK: - General Load
        
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

extension UIView {
    func asCircleOne() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.backgroundColor = (UIColor(named: "One")?.cgColor as Any as! CGColor)
    }
}
extension UIView {
    func asCircleTwo() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.backgroundColor = (UIColor(named: "Two")?.cgColor as Any as! CGColor)
    }
}
extension UIView {
    func asCircleThree() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.backgroundColor = (UIColor(named: "Three")?.cgColor as Any as! CGColor)
    }
}
extension UIView {
    func asCircleFour() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.backgroundColor = (UIColor(named: "Four")?.cgColor as Any as! CGColor)
    }
}
