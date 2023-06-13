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
    var taskIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    
    @objc func deleteTask() {
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
                
        let newCount = count - 1
        
        UserDefaults().set(newCount , forKey: "count")
        
        guard let task = UserDefaults().value(forKey: "task_\(taskIndex!)") as? String else {
            return
        }
        
        print("delete task : ", task)
        
        UserDefaults().set(nil , forKey: "task_\(taskIndex!)")
        
        update?()
        
        navigationController?.popViewController(animated: true )
    }


}
