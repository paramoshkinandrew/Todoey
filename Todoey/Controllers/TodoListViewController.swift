//
//  ViewController.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 02/06/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray: [Item] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    // MARK: - UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Changing done mark and reload data
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
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
                    self.itemArray.append(Item(title: newTodoItemText))
                    self.defaults.set(self.itemArray, forKey: "TodoListArray")
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

