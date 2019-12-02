//
//  DetailNewsController.swift
//  Animal Age
//
//  Created by Jon Brown on 12/1/19.
//  Copyright © 2019 Jon Brown. All rights reserved.
//

import Foundation
import UIKit

class DetailNewsController : UIViewController {
    @IBOutlet private var customButtonHome:UIButton!
    var  selectedimage:UIImage!
    var  selectedlabel:String!
    var  selecteddesc:String!
    @IBOutlet weak var  imgView:UIImageView!
    @IBOutlet weak var  textView:UITextView!
    @IBOutlet weak var  lablView:UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let attrStr = try! NSAttributedString(
            data: selecteddesc.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        textView.attributedText = attrStr
        textView.font = .systemFont(ofSize: 18)

        imgView.image = self.selectedimage
        lablView.text = self.selectedlabel

        lablView.textContainer.maximumNumberOfLines = 1
        lablView.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail

        super.viewDidLoad()

    // MARK: - Button Style

        let myColor : UIColor = UIColor( red:(255.0 / 255.0), green:(255.0 / 255.0), blue:(255.0 / 255.0), alpha: 1 )
        customButtonHome.layer.masksToBounds = true
        customButtonHome.layer.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        customButtonHome.layer.borderWidth = 1.0
        customButtonHome.layer.borderColor = myColor.cgColor
        
        let randomImage:UIImage! = UIImage(named: String(format:"image%u.jpg", 1+arc4random_uniform(6)))
               imgView.image = randomImage
    }

    @IBAction func Dismiss(sender:UIButton!) {
        self.dismiss(animated: true, completion:nil)
    }

    func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
