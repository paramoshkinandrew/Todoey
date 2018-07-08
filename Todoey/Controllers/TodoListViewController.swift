//
//  ViewController.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 02/06/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    let realm = try! Realm.init()
    
    var selectedCategory: Category? {
        // Called just after selectedCategory has been set
        didSet {
            loadData()
        }
    }
    
    var todoItems: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadData() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
        self.tableView.reloadData()
    }
    //
    // MARK: - UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (todoItems != nil) ? todoItems!.count : 1
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Changing done mark and reload data
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error writing done property: \(error)")
            }
            
        }
    
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    
    @IBAction func onAddTopBarButtonClicked(_ sender: Any) {
        
        var actionTextField: UITextField?
        let alert = UIAlertController(title: "Add new ToDo item", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "New item text"
            actionTextField = textField
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if let newTodoItemText = actionTextField?.text {
                if newTodoItemText.count > 0 {
                    
                    if let currentCategory = self.selectedCategory {
                        let item = Item()
                        item.title = newTodoItemText
                        do {
                            try self.realm.write { currentCategory.items.append(item) }
                        } catch {
                            print("Error on save new item: \(error)")
                        }
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text ?? "").sorted(byKeyPath: "dateCreated", ascending: true)
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
