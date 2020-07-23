//
//  TaskViewController.swift
//  ToDoFire
//
//  Created by mac on 23.07.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        
    }
    
    

}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "Task \(indexPath.row)"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    
}
