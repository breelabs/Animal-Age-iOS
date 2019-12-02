//
//  NewsTableViewController.swift
//  Animal Age
//
//  Created by Jon Brown on 12/1/19.
//  Copyright © 2019 Jon Brown. All rights reserved.
//

import Foundation
import RaptureXML
import UIKit

class NewsTableViewController: UITableViewController {
    var objects: [AnyHashable]?
    var responseData: Data?

    var selectedimage: UIImage?
    var selectedlabel: String?
    var selecteddesc: String?

    @IBOutlet var newsTbView: UITableView!
    var titleArray: [AnyHashable]?
    var descArray: [AnyHashable]?
    var imageArray: [AnyHashable]?
    var linkArray: [AnyHashable]?
    var contArray: [AnyHashable]?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Animal News"
        descArray = []
        titleArray = []
        newsTbView.delegate = self
        newsTbView.dataSource = self
        initData()

        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor(red: 0.96, green: 0.84, blue: 0.09, alpha: 1.0)
        refreshControl?.tintColor = UIColor.white
        refreshControl?.addTarget(self, action: #selector(getData), for: .valueChanged)

    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    func initData() {

        var request: URLRequest? = nil
        if let url = URL(string: URLFluxXmlNEWS) {
            request = URLRequest(url: url)
        }

        let session = URLSession(configuration: URLSessionConfiguration.default)

        var dataTask: URLSessionDataTask? = nil
        if let request = request {
            dataTask = session.dataTask(with: request, completionHandler: { data, response, error in


                self.responseData = Data()
                if let data = data {
                    self.responseData?.append(data)
                }

                let rootXML = RXMLElement(fromXMLData: self.responseData)

                let rxmlNews = rootXML?.child("channel")

                let rxmlIndividualNew = rxmlNews?.children("item")

                for i in 0..<(rxmlIndividualNew?.count ?? 0) {
                    let title = (rxmlIndividualNew?[i] as AnyObject).child("title").text ?? ""
                    let desc = (rxmlIndividualNew?[i] as AnyObject).child("encoded").text ?? ""

                    self.titleArray?.append(title)
                    self.descArray?.append(desc)
                }
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })



            })
        }
        dataTask?.resume()



    }

    @objc func getData() {
        titleArray?.removeAll()
        descArray?.removeAll()

        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })

        var request: URLRequest? = nil
        if let url = URL(string: URLFluxXmlNEWS) {
            request = URLRequest(url: url)
        }

        let session = URLSession(configuration: URLSessionConfiguration.default)

        var dataTask: URLSessionDataTask? = nil
        if let request = request {
            dataTask = session.dataTask(with: request, completionHandler: { data, response, error in


                self.responseData = Data()
                if let data = data {
                    self.responseData?.append(data)
                }

                let rootXML = RXMLElement(fromXMLData: self.responseData)

                let rxmlNews = rootXML?.child("channel")

                let rxmlIndividualNew = rxmlNews?.children("item")

                for i in 0..<(rxmlIndividualNew?.count ?? 0) {
                    let title = (rxmlIndividualNew?[i] as AnyObject).child("title").text ?? ""
                    let desc = (rxmlIndividualNew?[i] as AnyObject).child("encoded").text ?? ""

                    self.titleArray?.append(title)
                    self.descArray?.append(desc)
                }
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })



            })
        }
        dataTask?.resume()



    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)

        cell.textLabel?.lineBreakMode = .byTruncatingTail
        cell.textLabel?.numberOfLines = 1
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 17.0)

        // Configure the cell...
        cell.textLabel?.text = titleArray?[indexPath.row] as? String

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedlabel = titleArray?[indexPath.item] as? String ?? ""
        selecteddesc = descArray?[indexPath.item] as? String ?? ""


        performSegue(withIdentifier: "detailNews", sender: self)

    }

// MARK: prepareForSegue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailNews") {
            let detailNews = segue.destination as? DetailNewsController
            detailNews?.selectedimage = selectedimage
            detailNews?.selectedlabel = selectedlabel
            detailNews?.selecteddesc = selecteddesc
        }



    }
}

let URLFluxXmlNEWS = "http://www.vetstreet.com/rss/news-feed.jsp?Categories=siteContentTags:dog-news:cat-news:inspiring-stories:animal-news"

