//
//  user.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

class User
{
    var id:Int
    var username:String
    var firstName:String
    var lastName:String
    
    init(id :Int, username:String, firstName:String, lastName:String)
    {
        self.id=id
        self.username=username
        self.firstName=firstName
        self.lastName=lastName
    }
}