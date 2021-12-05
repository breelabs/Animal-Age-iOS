//
//  UISnapNav.swift
//  Animal Age
//
//  Created by Jon Brown on 12/1/19.
//  Copyright © 2019 Jon Brown. All rights reserved.
//

import Foundation
import UIKit

class UISnapNav: UINavigationController, UINavigationBarDelegate {
    @IBOutlet weak var navigationbar: UINavigationBar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationbar.delegate = self
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        
        let yellow = UIColor(red: 0.96, green: 0.84, blue: 0.09, alpha: 1.00)
       
        
        
        if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            
                let appearance2 = UINavigationBarAppearance()
                appearance2.backgroundColor = yellow
            
               // navigationBar.standardAppearance = appearance2
                // navigationBar.scrollEdgeAppearance = appearance2
                navigationBar.tintColor = UIColor.white

            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
