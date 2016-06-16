//
//  ToDoListViewController.swift
//  klassendiagramproj
//
//  Created by Fhict on 03/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, UITextFieldDelegate {

    var itemArray: [ToDoItem] = []
    var itemTitle: String = ""
    var itemDescription: String = ""
    var itemEstPomodoro: Int = 0
    var itemDeadline: NSDate = NSDate()
    @IBOutlet weak var toDoItemList: UITableView!
    @IBAction func btnNewToDoItem(sender: AnyObject) {
        
        var titleTextField: UITextField?
        var descriptionTextField: UITextField?
        var estPomoAmtTextField: UITextField?
        let alertController = UIAlertController(title: "New Item", message: "Fill out the required fields", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Confirm", style: .Cancel, handler: { (action) -> Void in
            self.itemTitle = (titleTextField?.text)!
            self.itemDescription = (descriptionTextField?.text)!
            self.itemEstPomodoro = Int(estPomoAmtTextField!.text!)!
            
            DatePickerDialog().show("When is this item due?", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
                (date) -> Void in
                let str = "\(date)"
                let subStr = str[str.startIndex.advancedBy(0)...str.startIndex.advancedBy(9)]
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd"
                dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
                let date = dateFormatter.dateFromString(subStr)
                self.itemDeadline = date!
                
                var toDoItem = ToDoItem(id: self.itemArray.count + 1, title: self.itemTitle, description: self.itemDescription, estAmount: self.itemEstPomodoro, deadline: self.itemDeadline)
                
                self.itemArray.append(toDoItem)
                print(self.itemArray.count)
            }
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            // Enter the textfiled customization code here.
            titleTextField = textField
            titleTextField?.placeholder = "Title"
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            // descriptionTextField the textfiled customization code here.
            descriptionTextField = textField
            descriptionTextField?.placeholder = "Description"
        }
        
        alertController.addTextFieldWithConfigurationHandler {[weak self] (textField: UITextField!) in
            textField.delegate = self
            estPomoAmtTextField = textField
            estPomoAmtTextField?.placeholder = "Estimated Pomodoros"
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
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
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newCharacters = NSCharacterSet(charactersInString: string)
        
        if (NSCharacterSet.decimalDigitCharacterSet().isSupersetOfSet(newCharacters) && ((textField.text?.characters.count)! + string.characters.count < 3)) {
            return true
        }
        return false
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
