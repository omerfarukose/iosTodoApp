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
        UserDefaults().set(0, forKey: "count")
    }
    
    @IBAction func didAddTapped() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController

        vc.title = "New Task"

        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func deleteAllTasks() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
                
        setup()
        
        if let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation() as? [String: Any] {
            for (key, value) in defaultsDictionary {
                print("Key: \(key), Value: \(value)")
            }
        }
        
        tableView.reloadData()
    }
    
    func updateTasks() {
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        print("-----------------")
        print("updateTasks count : ", count)
                
        for x in 0..<count {
            print("-----------------")
            print("updateTasks x : ", x)
            if let task = UserDefaults().value(forKey: "task_\(x)") as? String {
                print("task for append list : ", task)
                tasks.append(task)
            }
        }
        
        self.tableView.reloadData()
    }

}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        
        let vc = storyboard?.instantiateViewController(identifier: "taskDetail") as! TaskDetailViewController
        

        vc.title = "Task"
        vc.task = tasks[indexPath.row]
        vc.taskIndex = indexPath.row
        
        print("clicked task index: ", indexPath.row)
        print("clicked task : ", tasks[indexPath.row])
        
        if let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation() as? [String: Any] {
            for (key, value) in defaultsDictionary {
                print("Key: \(key), Value: \(value)")
            }
        }
        
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
