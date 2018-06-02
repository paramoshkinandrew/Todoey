//
//  ViewController.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 02/06/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["First", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Setting or removing checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        // I've called this method in order to remove the cell highlight
        tableView.deselectRow(at: indexPath, animated: true)
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
                    self.itemArray.append(newTodoItemText)
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

