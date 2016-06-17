//
//  EUnit.swift
//  klassendiagramproj
//
//  Created by Fhict on 27/05/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

enum EUnit : String
{
    case BPM = "Hartslagen per minuuut"
    
    case Decibel = "Decibel"
    
    case Userdefined = "Zelf gespecificeerde"
    
    case Steps = "Stappen"
    
    case Times = "Aantal afleidingen"
    
    static let EUnitValues = [BPM, Decibel, Userdefined, Steps, Times]
}