//
//  SwiftyPlistManagerControlPanelViewController.swift
//  SwiftyPlistManagerExample
//
//  Created by Muhammed Karakul on 5.09.2018.
//  Copyright © 2018 Muhammed Karakul. All rights reserved.
//

import UIKit
import SwiftyPlistManager
import ProgressHUD

class SwiftyPlistManagerControlPanelViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var outputLabel: UILabel!
    @IBOutlet var dataTextField: UITextField!
    @IBOutlet var keyTextField: UITextField!
    @IBOutlet var getValueKeyTextField: UITextField!
    @IBOutlet var removeKeyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTextField.delegate = self
        keyTextField.delegate = self
        getValueKeyTextField.delegate = self
        removeKeyTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func addNewValue(_ sender: UIButton) {
        SwiftyPlistManager.shared.addNew(dataTextField.text ?? "Empty", key: keyTextField.text ?? "Empty", toPlistWithName: "Data") { (error) in
            if let err = error {
                print("Error: \(err.localizedDescription)")
                ProgressHUD.showError("\(err.localizedDescription)")
            } else {
                print("Success: New value added to plist file successfully.")
                ProgressHUD.showSuccess("New value added to plist file successfully.")
            }
        }
    }
    
    
    @IBAction func getValue(_ sender: UIButton) {
        SwiftyPlistManager.shared.getValue(for: getValueKeyTextField.text ?? "Empty", fromPlistWithName: "Data") { (data, error) in
            if let err = error {
                print("Error: \(err.localizedDescription)")
                ProgressHUD.showError("\(err.localizedDescription)")
            } else {
                print("Data: \(data ?? "No value returned.")")
                outputLabel.text = "\(data ?? "No value returned.")"
            }
        }
    }
    
    @IBAction func removeValue(_ sender: UIButton) {
        SwiftyPlistManager.shared.removeKeyValuePair(for: removeKeyTextField.text ?? "Empty", fromPlistWithName: "Data") { (error) in
            if let err = error {
                print("Error: \(err.localizedDescription)")
                ProgressHUD.showError("\(err.localizedDescription)")
            } else {
                print("Success: \(removeKeyTextField.text ?? "Empty") key and key's value removed form plist file successfully.")
                ProgressHUD.showSuccess("\(removeKeyTextField.text ?? "Empty") key and key's value removed form plist file successfully.")
            }
        }
    }
    
    @IBAction func removeAll(_ sender: UIButton) {
        SwiftyPlistManager.shared.removeAllKeyValuePairs(fromPlistWithName: "Data") { (error) in
            if let err = error {
                print("Error: \(err.localizedDescription)")
                ProgressHUD.showError("\(err.localizedDescription)")
            } else {
                print("Success: All values removed successfully.")
                ProgressHUD.showSuccess("All values removed successfully.")
            }
        }
    }
    
}
