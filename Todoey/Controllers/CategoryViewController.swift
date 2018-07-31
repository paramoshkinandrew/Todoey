//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 02/07/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
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
                let newCategory = Category()
                newCategory.name = newCategoryName
                self.saveData(category: newCategory)
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
        categoryArray = realm.objects(Category.self)
    }
    
    func saveData(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Save data error: \(error)")
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        guard let color = UIColor(hexString: categoryArray?[indexPath.row].color ?? "FFFFFF") else {fatalError()}
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        cell.backgroundColor = color
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Delete methods
    override func updateModel(at indexPath: IndexPath) {
        do {
            if let category = self.categoryArray?[indexPath.row] {
                try realm.write {
                    realm.delete(category)
                }
            }
        } catch {
            print("Error on delete category: \(error)")
        }
    }
}
