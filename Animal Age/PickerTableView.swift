//
//  PickerTableView.swift
//  Animal Age Converter
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

import UIKit

@objc protocol AnimalPickerControllerDelegate: NSObjectProtocol {
    func itemSelectedatRow(_ row: Int)
}

class PickerTableView: UITableViewController {
    var tableData: [AnyHashable]?
    weak var delegate: AnimalPickerControllerDelegate?

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }

    static let tableViewCellIdentifier = "Cell"

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: PickerTableView.tableViewCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: PickerTableView.tableViewCellIdentifier)
        }
        cell?.textLabel?.text = tableData?[indexPath.row] as? String

        return cell!
    }

// MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        tableView.deselectRow(at: indexPath, animated: true)

        if delegate?.responds(to: #selector(AnimalPickerControllerDelegate.itemSelectedatRow(_:))) ?? false {
            delegate?.itemSelectedatRow(indexPath.row)
            dismiss(animated: true)
        }


    }

    @objc func itemSelectedatRow(_ row: Int) {
        print(String(format: "row %lu selected", UInt(row)))


    }

// MARK: - Actions
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.dismiss(animated: true)

        let theInstance = Calc()
        theInstance.calcTapped()
    }
}
