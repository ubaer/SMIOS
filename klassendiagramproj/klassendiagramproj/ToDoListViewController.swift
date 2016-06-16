//
//  ToDoListViewController.swift
//  klassendiagramproj
//
//  Created by Fhict on 03/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    var itemArray: [ToDoItem] = []
    var itemTitle: String = ""
    var itemDescription: String = ""
    var itemEstPomodoro: Int = 0
    var itemDeadline: String = ""
    @IBOutlet weak var toDoItemList: UITableView!{
        didSet {
            toDoItemList.dataSource = self
        }
    }
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
                print(str)
                let subStr = str[str.startIndex.advancedBy(0)...str.startIndex.advancedBy(18)]
                
                var toDoItem = ToDoItem(id: self.itemArray.count + 1, title: self.itemTitle, description: self.itemDescription, estAmount: self.itemEstPomodoro, deadline: subStr)
                
                self.itemArray.append(toDoItem)
                
                self.toDoItemList.reloadData()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var selectedRow = self.toDoItemList.indexPathForSelectedRow
        var selectedItem = self.itemArray[selectedRow!.row]
        var controller = segue.destinationViewController as! PomodoroViewController
        
        controller.item = selectedItem
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
