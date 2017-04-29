//
//  CategoryListViewController.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 26/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import UIKit

class CategoryListViewController: UITableViewController, ViewChecklistItemTableViewControllerDelegate, AddCategoryTableViewControllerDelegate {
    
    var categoryItems: [CategoryListItem]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        categoryItems = []
        
        categoryItems = [CategoryListItem]()
        
        var items = [CheckListItem]()
        
        let item0 = CheckListItem()
        item0.text = "Walk the dog"
        items.append(item0)
        
        let item1 = CheckListItem()
        item1.text = "Brush my teeth"
        items.append(item1)
        
        let item2 = CheckListItem()
        item2.text = "Learn iOS development"
        items.append(item2)
        
        let item3 = CheckListItem()
        item3.text = "Soccer practice"
        items.append(item3)
        
        let item4 = CheckListItem()
        item4.text = "Eat ice cream"
        items.append(item4)
        
        let row0item = CategoryListItem()
        row0item.text = "Errands"
        row0item.image = #imageLiteral(resourceName: "Folder")
        row0item.items.append(item0)
        row0item.items.append(item1)
        row0item.items.append(item2)
        categoryItems.append(row0item)

        
        let row1item = CategoryListItem()
        row1item.text = "Studying"
        row1item.image = #imageLiteral(resourceName: "Folder")
        row1item.items.append(item3)
        row1item.items.append(item4)
        categoryItems.append(row1item)
        
        super.init(coder: aDecoder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return categoryItems.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListItem", for: indexPath) as! CategoryListItemCell
        configureCategoryCount(for: cell, at: indexPath)
        configureCategoryText(for: cell, at: indexPath)
        configureCategoryIcon(for: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        categoryItems.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    func configureCategoryCount(for cell : CategoryListItemCell, at indexPath: IndexPath){
        let item = categoryItems[indexPath.row]
        cell.counterLabelView.text = String(item.items.count)
    }
    
    func configureCategoryIcon(for cell : CategoryListItemCell, at indexPath: IndexPath){
        let item = categoryItems[indexPath.row]
        cell.iconImageView.image = item.image
    }
    
    func configureCategoryText(for cell : CategoryListItemCell, at indexPath: IndexPath){
        let item = categoryItems[indexPath.row]
        cell.textLabelView.text = item.text
    }
    
    func viewChecklistItemViewController(_ controller : ChecklistViewController, didFinishAdding item: CategoryListItem){
        //logic
        dismiss(animated: true, completion: nil)
    }
    
    func viewChecklistItemViewControllerDidCancel(_ controller: ChecklistViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func addCategoryViewControllerDidCancel(_ controller: AddCategoryTableViewController){
        dismiss(animated: true, completion: nil)
    }
    func addCategoryViewController(_ controller : AddCategoryTableViewController, didFinishAdding item: CategoryListItem){
        let newRowIndex = categoryItems.count
        categoryItems.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        dismiss(animated: true, completion: nil)
    }

    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ChecklistViewController" {
            if let navigationController = segue.destination as? UITableViewController{
                let controller = navigationController as! ChecklistViewController
                controller.delegate = self
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    controller.categoryDelegate=self
                    controller.categoryIndex=indexPath.row
                    for item in categoryItems[indexPath.row].items{
                        controller.items.append(item)
                    }
                }
            }
        }else if segue.identifier == "AddCategoryViewController"{
            if let navigationController = segue.destination as? UINavigationController{
                let controller = navigationController.topViewController! as! AddCategoryTableViewController
                controller.delegate = self
            }
        }
    }
    
    
}
