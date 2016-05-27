//
//  Pomodoro.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

class Pomodoro
{
    var id: Int
    var startTime: datum
    
    init(id: Int, startTime: datum)
    {
        self.id = id
        self.startTime = startTime
    }
}