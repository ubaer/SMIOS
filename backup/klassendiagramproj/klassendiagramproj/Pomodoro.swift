//
//  Pomodoro.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

public class Pomodoro
{
    var id: Int
    var startTime:NSDate
    
    init(id: Int, startTime: NSDate)
    {
        self.id = id
        self.startTime = startTime
    }
}