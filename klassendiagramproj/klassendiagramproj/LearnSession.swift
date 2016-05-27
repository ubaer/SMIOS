//
//  LearnSession.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

class LearnSession
{
    var id: Int
    var pomodoroLength: Int
    var shortBreakLenght: Int
    var longBreakLenght: Int

    init(id: Int, pomodoroLength: Int, shortBreakLenght: Int, longBreakLenght: Int)
    {
        self.id = id
        self.pomodoroLength = pomodoroLength
        self.shortBreakLenght = shortBreakLenght
        self.longBreakLenght = longBreakLenght
    }
}