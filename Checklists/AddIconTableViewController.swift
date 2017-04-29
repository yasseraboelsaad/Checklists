//
//  AddIconTableViewController.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 29/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import UIKit

class AddIconTableViewController: UITableViewController {

    var icons: [UIImage] = [#imageLiteral(resourceName: "No Icon"),#imageLiteral(resourceName: "Appointments"),#imageLiteral(resourceName: "Birthdays"),#imageLiteral(resourceName: "Chores"),#imageLiteral(resourceName: "Drinks"),#imageLiteral(resourceName: "Folder"),#imageLiteral(resourceName: "Groceries"),#imageLiteral(resourceName: "Inbox"), #imageLiteral(resourceName: "Photos"), #imageLiteral(resourceName: "Trips")]
    var delegate: AddIconTableViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = tableView.cellForRow(at: indexPath){
            delegate.addIconViewController(self, didFinishAdding: icons[indexPath.row])
            navigationController?.popViewController(animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

protocol AddIconTableViewControllerDelegate: class {
    func addIconViewController(_ controller : AddIconTableViewController, didFinishAdding item: UIImage)
}
