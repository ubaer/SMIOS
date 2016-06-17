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
    var minutes = 1;
    var seconds = 15;
    var timer: NSTimer? = nil
    
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var btnStudyMode: UIButton!
    @IBOutlet weak var btnDistraction: UIButton!
    @IBOutlet weak var lblTimeLeft: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblItem.text = item?.title
        //Sets the label with the start-time
        lblTimeLeft.text = String(minutes) + ":" + String(seconds)
        //Starts the timer so every second the timer will count down
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(PomodoroViewController.update), userInfo: nil, repeats: true)
        //Starts the lisner to detect locks of the phone and usage of other applications
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(deviceLocked),
            name: UIApplicationDidEnterBackgroundNotification,
            object: nil)
        
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
            playSound()
            
        }
        
        if(seconds < 10){
            lblTimeLeft.text = String(minutes) + ":0" + String(seconds)
            
        }
        else{
            lblTimeLeft.text = String(minutes) + ":" + String(seconds)
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
            AudioServicesPlaySystemSound(mySound);
            print("gotem" )
        }
    }

    //This function gets called when the phone is unlocked aka a distrction
    @objc func deviceLocked(notification: NSNotification){
        //do database call to add distraction by unlocking phone
    }

}
