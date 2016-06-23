//
//  PhoneDataService.swift
//  klassendiagramproj
//
//  Created by Nino Vrijman on 22/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation
import AVFoundation

public class PhoneDataService : PService {
    
    private static var notificationCenter:NSNotificationCenter? = nil
    private static var fileManager:NSFileManager? = nil
    
    private static var bestandsnaam:String? = nil
    private static var settings:[String : AnyObject]? = nil
    private static var audioSession:AVAudioSession? = nil
    private static var audioRecorder:AVAudioRecorder? = nil
    private static var audioTimer = NSTimer()
    
    private static var phoneData:NSMutableDictionary = ["DecibelLevel" : 0.0]
    private static var tempAudioFileLocation:NSURL? = nil
    
    private static var counter:Float = 0.0
    private static var levelTotal:Float = 0.0
    private static var averageLevel:Float = 0.0
    
    public static func prepare() {
        if (notificationCenter == nil) {
            notificationCenter = NSNotificationCenter.defaultCenter()
        }
        
        //get documents directory
        let opslaglocatie: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        bestandsnaam =  opslaglocatie.stringByAppendingPathComponent("tempPomdoroRecording.caf")
        tempAudioFileLocation = NSURL.fileURLWithPath(bestandsnaam!)
        
        //create AnyObject of settings
        settings = [
            AVFormatIDKey:Int(kAudioFormatAppleIMA4),
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:2,
            AVEncoderBitRateKey:12800,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
        ]
    }
    
    public static func startMeasuring() {
        audioSession = AVAudioSession.sharedInstance()
        //try! self.audioSession!.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! self.audioSession!.setCategory(AVAudioSessionCategoryRecord)
        try! self.audioSession!.setActive(true)
        try! self.audioRecorder = AVAudioRecorder(URL: tempAudioFileLocation!, settings: settings!)
        self.audioRecorder?.meteringEnabled = true
        self.audioRecorder?.record()
        
        audioTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.measureAudioTimerCallback), userInfo: nil, repeats: true)
    }
    
    @objc private static func measureAudioTimerCallback(){
        //  UpdateMeters() moet aangeroepen worden om het huidige geluidsniveau te verkrijgen.
        //  try! audioSession?.setPreferredInputNumberOfChannels(1)
        audioRecorder!.updateMeters()
        
        let positiveLevel:Float = audioRecorder!.averagePowerForChannel(0) * (-1.0)
        let logarithmicLevel = 120 - log(positiveLevel) * 20.0
        //  print("Current (logged): " + String(logLevel))
        
        counter = counter + 1.0
        levelTotal = levelTotal + logarithmicLevel
        averageLevel = levelTotal / counter
        let phoneData:[NSObject : AnyObject] = ["DecibelLevel" : logarithmicLevel]
        notificationCenter?.postNotificationName("DecibelLevelChangeNotification", object: nil, userInfo: phoneData as [NSObject : AnyObject])
    }
    
    public static func stopMeasuring() {
        audioTimer.invalidate()
        audioRecorder?.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
        audioRecorder?.deleteRecording()
        
        do {
            try fileManager?.removeItemAtURL(tempAudioFileLocation!)
        } catch {
            NSLog("Error when setting AudioSession as inactive and removing temporary audio file")
        }
    }
    
}

