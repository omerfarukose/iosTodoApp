//
//  TaskDetailViewController.swift
//  TodoApp
//
//  Created by Ömer Faruk KÖSE on 13.06.2023.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet var label : UILabel!
    
    var update: (() -> Void)?
    
    var task: String?
    var taskIndex: Int!
    
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard var taskList = UserDefaults().value(forKey: "taskList") as? Array<String> else {
            print("task detail : can't get task list !")
            return
        }
        
        tasks = taskList

        label.text = tasks[taskIndex]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    
    @objc func deleteTask() {
        
        tasks.remove(at: taskIndex)
        
        UserDefaults().set(tasks, forKey: "taskList")
        
        update?()
        
        navigationController?.popViewController(animated: true )
    }


}
