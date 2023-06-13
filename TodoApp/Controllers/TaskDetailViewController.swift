//
//  TaskDetailViewController.swift
//  TodoApp
//
//  Created by Ömer Faruk KÖSE on 13.06.2023.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet var field: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    var update: (() -> Void)?
    
    var task: String?
    var taskIndex: Int!
    
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.delegate = self
        
        guard var taskList = UserDefaults().value(forKey: "taskList") as? Array<String> else {
            print("task detail : can't get task list !")
            return
        }
        
        tasks = taskList

        field.text = tasks[taskIndex]
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func saveButtonTapped() {
        // Handle button tap event here
        
        tasks[taskIndex] = field.text!
        
        UserDefaults().set(tasks, forKey: "taskList")
        
        update?()
        
        navigationController?.popViewController(animated: true )
        
    }
    
    
    @objc func deleteTask() {
        
        tasks.remove(at: taskIndex)
        
        UserDefaults().set(tasks, forKey: "taskList")
        
        update?()
        
        navigationController?.popViewController(animated: true )
    }


}

extension TaskDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
