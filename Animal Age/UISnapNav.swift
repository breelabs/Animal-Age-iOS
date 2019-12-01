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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
