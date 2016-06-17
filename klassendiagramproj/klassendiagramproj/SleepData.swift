//
//  SleepData.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

public class SleepData
{
    var id:Int
    var start:NSDate
    var end:NSDate
    var timesRestless: Int
    
    init(id: Int, start: NSDate, end: NSDate, restless: Int)
    {
        self.id = id
        self.start = start
        self.end = end
        self.timesRestless = restless
    }
}