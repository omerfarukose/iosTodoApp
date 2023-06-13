//
//  EntryViewController.swift
//  TodoApp
//
//  Created by Ömer Faruk KÖSE on 13.06.2023.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet var todoField: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))

    }
    
    @objc func saveTask() {
        
        guard let text = todoField.text, !text.isEmpty else {
            print("saveTask : can't get text !")
            return
        }
        
        guard var taskList = UserDefaults().value(forKey: "taskList") as? Array<String> else {
            print("saveTask : can't get task list !")
            return
        }
                
        taskList.append(text)
        
        UserDefaults().set(taskList, forKey: "taskList")
        
        update?()
        
        navigationController?.popViewController(animated: true )
        
    }
    
}


extension EntryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == todoField {
            saveTask()
        }
        
        return true
    }
}
