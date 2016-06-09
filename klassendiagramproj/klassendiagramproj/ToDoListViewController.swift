//
//  ToDoListViewController.swift
//  klassendiagramproj
//
//  Created by Fhict on 03/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ToDoListViewController.respond(_:)))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ToDoListViewController.respond(_:)))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
    }
    
    func respond(gesture :UIGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                let vc : AnyObject! = storyBoard.instantiateViewControllerWithIdentifier("PreferencesViewController")
                UIView.performWithoutAnimation {
                    self.showViewController(vc as! PreferencesViewController, sender: vc)
                }
            case UISwipeGestureRecognizerDirection.Left:
                let vc : AnyObject! = storyBoard.instantiateViewControllerWithIdentifier("StatisticsViewController")
                UIView.performWithoutAnimation {
                    self.showViewController(vc as! StatisticsViewController, sender: vc)
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
