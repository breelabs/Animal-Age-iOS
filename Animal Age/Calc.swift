//
//  Calc.swift
//  Animal Age Converter
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

import Foundation
import ProgressHUD
import WebKit

class Calc: NSObject {
    @IBOutlet var PeopleString: UITextField!
    @IBOutlet var PeopleString2: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var AnimalButt: UIButton!
    @IBOutlet var AnimalButt2: UIButton!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var calcText: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var masterFlip: UIView!
    @IBOutlet var frontView: UIView!
    @IBOutlet var backView: UIView!

    @IBAction func calcTapped() {

        let defaults = UserDefaults.standard
        let flipin = defaults.object(forKey: "flipPref") as? String
        let flipValue = Int(Double(flipin ?? "") ?? 0.0)
        let buttonTitle = AnimalButt?.currentTitle
        let secondString = PeopleString?.text
        let thirdString = PeopleString2?.text

        //Here we are creating three doubles
        var num2: Float
        var answer: Float
        var y: Float

        //Here we are assigning the values

        if flipValue == 0 {

            print("Flip Status 1: \(flipValue)")
            num2 = Float(thirdString ?? "") ?? 0.0
        } else {

            print("Flip Status 2: \(flipValue)")
            num2 = Float(secondString ?? "") ?? 0.0
        }


        // Dog Calculation

        if (buttonTitle == "Dog") {

            if flipValue == 0 {

                // People Age to Animal

                y = (num2 >= 21) ? ((num2 - 21) / 4 + 2) : (num2 / 10.5)
                answer = (y * 100) / 100

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField1 = answerFormatter.string(from: NSNumber(value: answer))


                print("Answer: \(numField1 ?? "")")
                PeopleString?.text = numField1
            } else {

                // Animal Age to People

                y = (num2 >= 2) ? (21 + ((num2 - 2) * 4)) : (num2 * 10.5)
                answer = (y * 100) / 100

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField2 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField2 ?? "")")
                PeopleString2?.text = numField2
            }

            // Trigger Web View Graph

            let scriptSource = "loadDogData()"
            webView?.evaluateJavaScript(scriptSource, completionHandler: { result, error in
                if result != nil {
                    print("Result: \(result ?? "")")
                }

            })

            // Cat Calculation
        } else if (buttonTitle == "Cat") {

            // People Age to Animal

            if flipValue == 0 {

                if (num2 >= 0) && (num2 <= 15) {

                    answer = 1
                } else if (num2 >= 16) && (num2 <= 24) {

                    answer = 2
                } else {
                    answer = ((num2 - 24) / 4) + (2)
                }

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField1 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField1 ?? "")")
                PeopleString?.text = numField1
            } else {

                // Animal Age to People


                if (num2 >= 0) && (num2 <= 1) {

                    answer = 15
                } else if (num2 >= 1) && (num2 <= 2) {

                    answer = 24
                } else {
                    answer = ((num2 - 2) * 4) + (24)
                }

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField2 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField2 ?? "")")
                PeopleString2?.text = numField2
            }

            // Trigger Web View Graph

            let scriptSource = "loadCatData()"
            webView?.evaluateJavaScript(scriptSource, completionHandler: { result, error in
                if result != nil {
                    print("Result: \(result ?? "")")
                }

            })


            // Cow Calculation
        } else if (buttonTitle == "Cow") {

            if flipValue == 0 {

                // People Age to Animal

                answer = num2 * 6

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField1 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField1 ?? "")")
                PeopleString?.text = numField1
            } else {

                // Animal Age to People

                answer = num2 / 6

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField2 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField2 ?? "")")
                PeopleString2?.text = numField2
            }

            // Trigger Web View Graph

            let scriptSource = "loadCowData()"
            webView?.evaluateJavaScript(scriptSource, completionHandler: { result, error in
                if result != nil {
                    print("Result: \(result ?? "")")
                }

            })

            // Rabbit Calculation
        } else if (buttonTitle == "Rabbit") {

            if flipValue == 0 {

                // People Age to Animal

                answer = num2 * 9.25

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField1 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField1 ?? "")")
                PeopleString?.text = numField1
            } else {

                // Animal Age to People

                answer = num2 / 9.25

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField2 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField2 ?? "")")
                PeopleString2?.text = numField2
            }


            // Trigger Web View Graph

            let scriptSource = "loadRabbitData()"
            webView?.evaluateJavaScript(scriptSource, completionHandler: { result, error in
                if result != nil {
                    print("Result: \(result ?? "")")
                }

            })

            // Duck Calculation
        } else if (buttonTitle == "Duck") {

            if flipValue == 0 {

                // People Age to Animal

                answer = num2 * 6.25

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField1 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField1 ?? "")")
                PeopleString?.text = numField1
            } else {

                // Animal Age to People

                answer = num2 / 6.25

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField2 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField2 ?? "")")
                PeopleString2?.text = numField2
            }


            // Trigger Web View Graph

            let scriptSource = "loadDuckData()"
            webView?.evaluateJavaScript(scriptSource, completionHandler: { result, error in
                if result != nil {
                    print("Result: \(result ?? "")")
                }

            })

            // Chicken Calculation
        } else {

            if flipValue == 0 {

                // People Age to Animal

                answer = num2 * 8.12

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField1 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField1 ?? "")")
                PeopleString?.text = numField1
            } else {

                // Animal Age to People

                answer = num2 / 8.12

                // Perform Conversion

                let answerFormatter = NumberFormatter()
                answerFormatter.positiveFormat = "#,###;0;(#,##0)"
                let numField2 = answerFormatter.string(from: NSNumber(value: answer))

                print("Answer: \(numField2 ?? "")")
                PeopleString2?.text = numField2
            }

            // Trigger Web View Graph

            let scriptSource = "loadChickenData()"
            webView?.evaluateJavaScript(scriptSource, completionHandler: { result, error in
                if result != nil {
                    print("Result: \(result ?? "")")
                }

            })
        }



        let answerFormatter = NumberFormatter()
        answerFormatter.positiveFormat = "#,###;0;(#,##0)"
        let string = answerFormatter.string(from: NSNumber(value: answer))

        resultLabel?.numberOfLines = 1
        resultLabel?.minimumScaleFactor = 10.0 / UIFont.labelFontSize
        resultLabel?.adjustsFontSizeToFitWidth = true
        resultLabel?.text = "\(string ?? "")"


        if flipValue == 0 {
            let results = resultLabel?.text
            let animal = AnimalButt?.currentTitle
            calcText?.text = "You are \(results ?? "") years old in \(animal ?? "") years"
        } else {
            let results = resultLabel?.text
            let animal = AnimalButt2?.currentTitle
            calcText?.text = "You are \(results ?? "") years old in \(animal ?? "") years"
        }


    }

    @IBAction func showflip(_ sender: Any) {

        let defaults = UserDefaults.standard
        let flipin = defaults.object(forKey: "flipPref") as? String
        let flipValue = Int(Double(flipin ?? "") ?? 0.0)

        if let masterFlip = masterFlip {
            UIView.transition(with: masterFlip, duration: 1.0, options: displayingFront ? .transitionFlipFromRight : .transitionFlipFromLeft, animations: {
                if self.displayingFront {
                    self.frontView?.isHidden = true
                    self.backView?.isHidden = false

                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "flipPref")
                    print("Flip Status 1: \(flipValue)")
                } else {
                    self.frontView?.isHidden = false
                    self.backView?.isHidden = true

                    let defaults = UserDefaults.standard
                    defaults.set(false, forKey: "flipPref")
                    print("Flip Status 2: \(flipValue)")
                }
            }) { finished in
                if finished {
                    self.displayingFront = !self.displayingFront
                    self.calcTapped()
                }
            }
        }


    }

    var displayingFront = false

    func viewDidLoad() {
        displayingFront = true
        showflip((Any).self)
    }

    @IBAction func closeKeyboard() {
        PeopleString.resignFirstResponder()
    }

    @objc func hideHud(_ timer: Timer?) {

        ProgressHUD.dismiss()
    }

    @objc func dogAnswer(_ timer: Timer?) {

        ProgressHUD.showSuccess(nil)

        perform(#selector(hideHud(_:)), with: nil, afterDelay: 0.85)

    }

    @IBAction func calcWithProg() {

        ProgressHUD.show(nil)
        calcTapped()
        perform(#selector(dogAnswer(_:)), with: nil, afterDelay: 0.50)

    }
}
