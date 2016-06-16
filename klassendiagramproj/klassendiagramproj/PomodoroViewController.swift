//
//  PomodoroViewController.swift
//  klassendiagramproj
//
//  Created by Fhict on 16/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit

class PomodoroViewController: UIViewController {
    
    var item: ToDoItem?
    
    @IBOutlet weak var lblItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblItem.text = item?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
