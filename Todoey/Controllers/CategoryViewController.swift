//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 02/07/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray: [Category] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New category", message: "Enter new category name", preferredStyle: .alert)
        var alertTextView: UITextField?;
        // Add text field
        alert.addTextField { (textField) in
            alertTextView = textField
        }
        // Alert actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let newCategoryName = alertTextView?.text ?? ""
            if newCategoryName.count > 0 {
                let newCategory = Category(context: self.context)
                newCategory.name = newCategoryName
                self.categoryArray.append(newCategory)
                self.saveData()
                self.tableView.reloadData()
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        // Show alert
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data manipulation
    
    func loadData() {
        // NOTE You can replace it with the function argument
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Load data request error: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Save data error: \(error)")
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
