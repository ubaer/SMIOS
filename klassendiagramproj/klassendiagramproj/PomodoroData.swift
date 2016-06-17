//
//  PomodoroData.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

public class PomodoroData
{
    var id: Int
    var description: String
    var value: String
    var unit: EUnit
    
    init(id: Int, description: String, value: String, unit: EUnit)
    {
        self.id = id
        self.description = description
        self.value = value
        self.unit = unit
    }
    
    init(id : Int, description : String, value : String) {
        self.id = id
        self.description = description
        self.value = value
    }
}