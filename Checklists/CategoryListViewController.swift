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
    var lastClickedIndex : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        categoryItems = [CategoryListItem]()

        super.init(coder: aDecoder)
        loadChecklistItems()

    }
    
    
    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(categoryItems, forKey: "Categories")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }

    func loadChecklistItems() {
        //1
        let path = dataFilePath()
        // 2
        if let data = try? Data(contentsOf: path) {
            // 3
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            categoryItems = unarchiver.decodeObject(forKey: "Categories") as! [CategoryListItem]
            unarchiver.finishDecoding()
        }
    }

    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Check_Lists.plist")
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
        print(lastClickedIndex)
        self.tableView.reloadData()
        saveChecklistItems()
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
        saveChecklistItems()
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
        saveChecklistItems()
        dismiss(animated: true, completion: nil)
    }

    func editCategoryViewController(_ controller : AddCategoryTableViewController, didFinishEditing item: CategoryListItem){
        let newRowIndex = categoryItems.index(of: item)!
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
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
        else if segue.identifier == "EditCategoryViewController"{
            if let navigationController = segue.destination as? UINavigationController{
                let controller = navigationController.topViewController! as! AddCategoryTableViewController
                controller.delegate = self
                
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    controller.itemToEdit = categoryItems[indexPath.row]
                }
            }
        }
    }
    
    
}
