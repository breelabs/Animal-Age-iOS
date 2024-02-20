//
//  FeedListViewController.swift
//  Rsswift
//
//  Created by Arled Kola on 18/11/2016.
//  Copyright © 2016 ArledKola. All rights reserved.
//

import UIKit

class FeedListViewController: UITableViewController, XMLParserDelegate {

    var myFeed : NSArray = []
    //var feedImgs: [AnyObject] = []
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = .default
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(named: "BarColor")

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.backgroundColor = UIColor(named: "Yellow Background")
        self.tableView.dataSource = self
        self.tableView.delegate = self

        loadData()
    }

    @IBAction func refreshFeed(_ sender: Any) {

        loadData()
    }

    func loadData() {
        url = URL(string: "https://www.vetstreet.com/feed")!
        loadRss(url);
        //print(url);
    }

    func loadRss(_ data: URL) {

        // XmlParserManager instance/object/variable.
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager

        // Put feed in array.
       // feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenPage" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let selectedFURL: String = (myFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String

            // Instance of our feedpageviewcontrolelr.
            let fivc: FeedItemWebViewController = segue.destination as! FeedItemWebViewController
            fivc.selectedFeedURL = selectedFURL as String
        }
    }

    // MARK: - Table view data source.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.detailTextLabel?.backgroundColor = UIColor.clear

        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
        } else {
            cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
        }

        // Load feed iamge.
        //let url = NSURL(string:feedImgs[indexPath.row] as! String)
       // let data = NSData(contentsOf:url! as URL)
       // var image = UIImage(data:data! as Data)
        var image : UIImage = UIImage(named: "cute")!
        
        cell.imageView?.image = image
        
        image = resizeImage(image: image, toTheSize: CGSize(width: 70, height: 70))

       let cellImageLayer: CALayer?  = cell.imageView?.layer

       cellImageLayer!.cornerRadius = 35
       cellImageLayer!.masksToBounds = true

       cell.imageView?.image = image
        cell.textLabel?.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        cell.textLabel?.textColor = UIColor(named: "Text Color")
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "pubDate") as? String
        cell.detailTextLabel?.textColor = UIColor(named: "Text Color")

        return cell
    }

    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{

        let scale = CGFloat(max(size.width/image.size.width,
                                size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;

        let rr:CGRect = CGRect(x: 0, y: 0, width: width, height: height)

        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.draw(in: rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!
    }
    
    
}
