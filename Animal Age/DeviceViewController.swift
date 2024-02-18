//
//  DeviceViewController.swift
//  Animal Age Converter
//
//  Created by Jon on 3/27/17.
//  Copyright © 2017 Jon Brown. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class DeviceViewController: UITableViewController {
    private var devices: [AnyHashable]?

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
        title = "Age Tracker"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // You code here to update the view.
        // Fetch the devices from persistent data store
        let managedObjectContext = self.managedObjectContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            devices = try managedObjectContext?.fetch(fetchRequest) as? [AnyHashable]
        } catch {
        }

        tableView.reloadData()
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
        return devices?.count ?? 0
    }

    static let tableViewCellIdentifier = "Cell"

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceViewController.tableViewCellIdentifier, for: indexPath)
        
       

        // Configure the cell...
        let device = devices?[indexPath.row] as? NSManagedObject
        if let value = device?.value(forKey: "pet_name") {
            cell.textLabel?.text = "\(value)"
        }

        cell.textLabel?.numberOfLines = 0 // set the numberOfLines
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.textLabel?.lineBreakMode = .byWordWrapping

        if let value = device?.value(forKey: "age") {
            cell.detailTextLabel?.text = "Age: \(value)"
        }

        var image: UIImage? = nil
        if let value = device?.value(forKey: "img") as? Data {
            image = UIImage(data: value)
        }
        
        let cellImageLayer: CALayer?  = cell.imageView?.layer
        
        cell.imageView?.image = image
        
        image = resizeImage(image: image!, toTheSize: CGSize(width: 70, height: 70))

       

       cellImageLayer!.cornerRadius = 35
       cellImageLayer!.masksToBounds = true
        
        cell.imageView?.image = image
        
        cell.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = managedObjectContext()

        if editingStyle == .delete {
            // Delete object from database
            if let object = devices?[indexPath.row] as? NSManagedObject {
                context?.delete(object)
            }

            let error: Error? = nil
            do {
                try context?.save()

                if try context?.save() == nil {
                    if let error = error {
                        print("Can't Delete! \(error) \(error.localizedDescription )")
                    }
                    return
                }
            } catch {
                
                return
            }

            // Remove device from table view
            devices?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "UpdateDevice", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "UpdateDevice") {
            let selectedDevice = devices?[tableView.indexPathForSelectedRow?.row ?? 0] as? NSManagedObject
            let destViewController = segue.destination as? DeviceDetailViewController
            destViewController?.device = selectedDevice
        }
    }
}
