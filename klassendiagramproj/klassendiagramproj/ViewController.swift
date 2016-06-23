//
//  ViewController.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

