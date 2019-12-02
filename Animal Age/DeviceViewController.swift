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
        if let value = device?.value(forKey: "pet_name"), let value1 = device?.value(forKey: "age") {
            cell.textLabel?.text = "\(value) - Age: \(value1)"
        }

        cell.textLabel?.numberOfLines = 1 // set the numberOfLines
        cell.textLabel?.lineBreakMode = .byTruncatingTail

        if let value = device?.value(forKey: "date") {
            cell.detailTextLabel?.text = "\(value)"
        }

        var image: UIImage? = nil
        if let value = device?.value(forKey: "img") as? Data {
            image = UIImage(data: value)
        }
        cell.imageView?.image = image

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
