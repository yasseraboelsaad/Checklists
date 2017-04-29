//
//  ViewController.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 17/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items: [CheckListItem]!
    var delegate: ViewChecklistItemTableViewControllerDelegate!
    var categoryDelegate: CategoryListViewController!
    var categoryIndex : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    required init?(coder aDecoder: NSCoder) {
        items = []
        
        items = [CheckListItem]()
        
//        let row0item = CheckListItem()
//        row0item.text = "Walk the dog"
//        items.append(row0item)
//        
//        let row1item = CheckListItem()
//        row1item.text = "Brush my teeth"
//        items.append(row1item)
//        
//        let row2item = CheckListItem()
//        row2item.text = "Learn iOS development"
//        items.append(row2item)
//        
//        let row3item = CheckListItem()
//        row3item.text = "Soccer practice"
//        items.append(row3item)
//        
//        let row4item = CheckListItem()
//        row4item.text = "Eat ice cream"
//        items.append(row4item)
        
        super.init(coder: aDecoder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath) as! CheckListItemCell
        
        configureCheckText(for: cell, at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            items[indexPath.row].checked = !items[indexPath.row].checked

            configureCheckMark(for: cell as! CheckListItemCell, at: indexPath)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func configureCheckMark(for cell : CheckListItemCell, at indexPath: IndexPath){
        let item = items[indexPath.row]
        cell.checkLabel.text = item.checked ? "☑️" : ""
    }
    
    func configureCheckText(for cell : CheckListItemCell, at indexPath: IndexPath){
        let item = items[indexPath.row]
        cell.itemTitleLable.text = item.text
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: CheckListItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        categoryDelegate.categoryItems[categoryIndex].items.append(item)
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func editItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func editItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: CheckListItem) {
        let newRowIndex = items.index(of: item)!
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        let newRowIndex = items.count
        let item = CheckListItem()
        item.checked = false
        item.text = "I am a new row"
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "AddItemViewController" {
            if let navigationController = segue.destination as? UINavigationController{
                let controller = navigationController.topViewController! as! AddItemTableViewController
                controller.delegate = self
            }
        }else if segue.identifier == "EditItemViewController"{
            if let navigationController = segue.destination as? UINavigationController{
                let controller = navigationController.topViewController! as! AddItemTableViewController
                controller.delegate = self
                
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    controller.itemToEdit = items[indexPath.row]
                }
            }
        
        }

    }
}

protocol ViewChecklistItemTableViewControllerDelegate: class {
    func viewChecklistItemViewController(_ controller : ChecklistViewController, didFinishAdding item: CategoryListItem)
    
}
