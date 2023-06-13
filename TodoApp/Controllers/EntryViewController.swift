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
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        print("saveTask count : ", count)
        print("saveTask text : ", text)
                
        UserDefaults().set(newCount, forKey: "count")
                
        UserDefaults().set(text, forKey: "task_\(count)")
        
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
