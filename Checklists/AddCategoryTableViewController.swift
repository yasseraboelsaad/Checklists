//
//  AddCategoryTableViewController.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 29/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import UIKit

class AddCategoryTableViewController: UITableViewController, AddIconTableViewControllerDelegate {

    @IBOutlet weak var textField: UITextField!
    
    var delegate: AddCategoryTableViewControllerDelegate!
    
    var itemToEdit: CategoryListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        itemToEdit = CategoryListItem()
        super.init(coder: aDecoder)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func doneButton(_ sender: Any) {
        let item = CategoryListItem()
        item.text = textField.text ?? "I am a new Row"
        item.image = itemToEdit.image ?? #imageLiteral(resourceName: "No Icon")
        delegate.addCategoryViewController(self, didFinishAdding: item)

    }

    @IBAction func cancelButton(_ sender: Any) {
        delegate.addCategoryViewControllerDidCancel(self)
    }
    
    func addIconViewController(_ controller : AddIconTableViewController, didFinishAdding item: UIImage){
        itemToEdit.image = item
    }
    
    func editIconViewController(_ controller : AddIconTableViewController, didFinishAdding item: UIImage){
        
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "AddIconViewController" {
            if let navigationController = segue.destination as? UITableViewController{
                let controller = navigationController as! AddIconTableViewController
                controller.delegate = self
            }
        }else if segue.identifier == "EditCategoryViewController" {
            if let navigationController = segue.destination as? UITableViewController{
                let controller = navigationController as! AddIconTableViewController
                controller.delegate = self
            }
        }
    }


}

protocol AddCategoryTableViewControllerDelegate: class {
    func addCategoryViewControllerDidCancel(_ controller: AddCategoryTableViewController)
    func addCategoryViewController(_ controller : AddCategoryTableViewController, didFinishAdding item: CategoryListItem)
}
