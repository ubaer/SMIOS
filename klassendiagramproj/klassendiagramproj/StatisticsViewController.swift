//
//  StatisticsViewController.swift
//  klassendiagramproj
//
//  Created by Fhict on 09/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(StatisticsViewController.respond(_:)))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
    }
    
    func respond(gesture :UIGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                let vc : AnyObject! = storyBoard.instantiateViewControllerWithIdentifier("ToDoListViewController")
                UIView.performWithoutAnimation {
                    self.showViewController(vc as! ToDoListViewController, sender: vc)
                }
            default:
                break
            }
        }
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
