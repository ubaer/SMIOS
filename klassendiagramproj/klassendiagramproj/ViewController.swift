//
//  ViewController.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBAction func btnLogin(sender: AnyObject) {
        let username:String = tfUsername.text!
        let password:String = tfPassword.text!
        
        if (DatabaseService.validateLoginCredentials(username, password: password)) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc : AnyObject! = storyBoard.instantiateViewControllerWithIdentifier("ToDoListViewController")
            self.showViewController(vc as! ToDoListViewController, sender: vc)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

