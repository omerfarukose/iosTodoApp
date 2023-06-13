//
//  EntryViewController.swift
//  TodoApp
//
//  Created by Ömer Faruk KÖSE on 13.06.2023.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet var todoField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        todoField.delegate = self

    }
    

}


extension EntryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
