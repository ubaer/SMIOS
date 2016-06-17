//
//  PersistenceService.swift
//  klassendiagramproj
//
//  Created by Nino Vrijman on 10/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

public class PersistenceService {
    
    static var sharedInstance = PersistenceService()
    
    private static var store:[String:AnyObject] = [:]
    
    static func store(key : String, value : AnyObject) -> Bool {
        store[key] = value
        return true
    }
}
