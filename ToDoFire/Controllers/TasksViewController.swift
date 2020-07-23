//
//  TaskViewController.swift
//  ToDoFire
//
//  Created by mac on 23.07.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {
    
    var user: TaskUser!
    var ref: DatabaseReference!
    var tasks = [Task]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        guard let currentUser = Auth.auth().currentUser else {return}
        
        user = TaskUser(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(user.uid).child("tasks")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.observe(.value) { [weak self](snapshot) in
            
            var tasksArray = [Task]()
            for item in snapshot.children {
                let task = Task(snapshot: item as! DataSnapshot)
                tasksArray.append(task)
            }
            self?.tasks = tasksArray
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add new Task", message: "Type new task", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let save = UIAlertAction(title: "Save", style: .default) { [weak self]_ in
            guard let textField = alertController.textFields?.first, textField.text != "" else {return}
            let task = Task(title: textField.text!, userId: (self?.user.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(task.convertToDictionary())
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancel)
        alertController.addAction(save)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        let taskTitle = tasks[indexPath.row].title
        cell.textLabel?.text = taskTitle
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    
}
