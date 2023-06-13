//
//  ViewController.swift
//  TodoApp
//
//  Created by Ömer Faruk KÖSE on 13.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // table view for tasks
    @IBOutlet var tableView: UITableView!
        
    // task list
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete All", style: .done, target: self, action: #selector(deleteAllTasks))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup") {
            setup()
        }
        
        updateTasks()
    }
    
    func setup(){
        UserDefaults().set(true, forKey: "setup")
        UserDefaults().set([], forKey: "taskList")
    }
    
    @IBAction func didAddTapped() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController

        vc.title = "New Task"
        
        print("task list : ", tasks)

        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func deleteAllTasks() {
        
        UserDefaults().set([], forKey: "taskList")
        
        updateTasks()
    }
    
    func updateTasks() {
        
        guard let taskList = UserDefaults().value(forKey: "taskList") as? Array<String> else {
            return
        }
                
        tasks = taskList
        
        self.tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        
        let vc = storyboard?.instantiateViewController(identifier: "taskDetail") as! TaskDetailViewController

        vc.title = "Task"
        vc.taskIndex = indexPath.row
        
        print("clicked task index: ", indexPath.row)
        
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = tasks[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
    }
}
