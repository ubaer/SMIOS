//
//  ToDoItem.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

class ToDoItem
{
    var id: Int
    var title: String
    var description: String
    var estPomodoroAmount: Int
    var deadline: datum
    var completed: Bool
    var childId: Int?
    
    init(id: Int, title: String, description: String, estAmount: Int, deadline: datum)
    {
        self.id = id
        self.title = title
        self.description = description
        self.estPomodoroAmount = estAmount
        self.deadline = deadline
        self.completed = false
    }
    
    init(id: Int, title: String, description: String, estAmount: Int, deadline: datum, childId: Int)
    {
        self.id = id
        self.title = title
        self.description = description
        self.estPomodoroAmount = estAmount
        self.deadline = deadline
        self.completed = false
        self.childId = childId
    }
}