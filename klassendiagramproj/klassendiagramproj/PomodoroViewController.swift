//
//  PomodoroViewController.swift
//  klassendiagramproj
//
//  Created by Fhict on 16/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import UIKit
import AudioToolbox


class PomodoroViewController: UIViewController {
    
    var item: ToDoItem?
    var minutes = 0;
    var seconds = 15;
    var timer: NSTimer? = nil
    
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var btnStudyMode: UIButton!
    @IBOutlet weak var btnDistraction: UIButton!
    @IBOutlet weak var lblTimeLeft: UILabel!
    @IBOutlet weak var lblDecibelLevel: UILabel!
    
    var notificationCenter:NSNotificationCenter? = nil
    var dataService:PhoneDataService? = nil
    
    var avgDecibelLevel:Float! = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        lblItem.text = item?.title
        //Sets the label with the start-time
        lblTimeLeft.text = String(minutes) + ":" + String(seconds)
        
        
        //  Pomodoro tip
        let alert = UIAlertController(title: "Tip", message: "Last time you were in a loud environment. Perhaps try somewhere more quiet this time?", preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "Start pomodoro", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Start pomodoro", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                self.addSelfAsListenerForDecibelLevel()
                self.startMeasuring()
                
                //Starts the timer so every second the timer will count down
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(PomodoroViewController.update), userInfo: nil, repeats: true)
                //Starts the lisner to detect locks of the phone and usage of other applications
                NSNotificationCenter.defaultCenter().addObserver(
                    self,
                    selector: #selector(self.deviceLocked),
                    name: UIApplicationDidEnterBackgroundNotification,
                    object: nil)
            default: break
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This update gets called every second by the timer. It is used to count down the pomodoro timer
    func update() {
        seconds-=1;
        if(minutes == 0 && seconds == 0){
            timer?.invalidate();
            lblTimeLeft.text = "Pomodoro completed!";
            stopMeasuring()
            playSound()
        }
        
        if(seconds < 10){
            lblTimeLeft.text = String(minutes) + ":0" + String(seconds)
        }
        else{
            lblTimeLeft.text = String(minutes) + ":" + String(seconds)
        }
        
        if (avgDecibelLevel > 0) {
            lblDecibelLevel.text = String(Int(avgDecibelLevel)) + " db"
        }
        
        if(minutes == 0 && seconds == 0){
            timer?.invalidate();
            lblTimeLeft.text = "Done!";
        }
        if(seconds == 0){
            minutes -= 1;
            seconds = 60;
        }
    }
    
    //Is used to play a sound when the timer is finished
    func playSound(){
        
        if let soundURL = NSBundle.mainBundle().URLForResource("alarm1", withExtension: "mp3") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound)
            print("gotem" )
        }
    }

    //This function gets called when the phone is unlocked aka a distrction
    @objc func deviceLocked(notification: NSNotification){
        //do database call to add distraction by unlocking phone
    }
    
    //  Audio level monitoring
    func addSelfAsListenerForDecibelLevel() {
        notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter?.addObserver(self, selector: #selector(self.processObserverNotification(_:)), name: "DecibelLevelChangeNotification", object: nil)
        NSLog("PomodoroViewController added as observer for DecibelLevelChangeNotification")
        
    }
    
    func startMeasuring() {
        //  dataService = PhoneDataService()
        PhoneDataService.prepare()
        PhoneDataService.startMeasuring()
    }
    
    @objc func processObserverNotification(notification : NSNotification) {
        let notificationDictionary:[NSObject : AnyObject] = notification.userInfo! as [NSObject : AnyObject]
        avgDecibelLevel = notificationDictionary["DecibelLevel"] as! Float
    }
    
    func stopMeasuring() {
        PhoneDataService.stopMeasuring()
    }

}
