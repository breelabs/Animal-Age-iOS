//
//  FeedItemWebViewController.swift
//  Rsswift
//
//  Created by Arled Kola on 12/03/2019.
//  Copyright © 2019 ArledKola. All rights reserved.
//

import UIKit
import WebKit

class FeedItemWebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    var selectedFeedURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = .default
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(named: "BarColor")

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        
        //selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n\t\t", with:"")
        webView.load(URLRequest(url: URL(string: selectedFeedURL! as String)!))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}
