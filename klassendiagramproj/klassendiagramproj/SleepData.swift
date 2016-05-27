//
//  SleepData.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

class SleepData
{
    var id:Int
    var start: datum
    var end: datum
    var timesRestless: Int
    
    init(id: Int, start: datum, end: datum, var restless: Int)
    {
        self.id = id
        self.start = start
        self.end = end
        self.timesRestless = restless
    }
}