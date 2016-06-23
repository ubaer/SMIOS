//
//  RegisterViewController.swift
//  klassendiagramproj
//
//  Created by Nino Vrijman on 10/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRegister_Click(sender: AnyObject) {
        let username:String = tfUsername.text!
        let password:String = tfPassword.text!
        DatabaseService.registerUser(username, password: password, firstname: "Gerrit", lastname: "Hiemstra")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
