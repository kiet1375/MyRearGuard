//
//  Incedent.swift
//  Medic
//
//  Created by Kiet Lam on 25/5/18.
//  Copyright © 2018 Kiet Lam. All rights reserved.
//

import Foundation

class Incident
{
    var date: String
    var longitude: Double
    var latitude: Double
    var time: String
    var attackType: String
    var medic: String
    var patient: String
    
    init()
    {
        self.date = ""
        self.longitude = 0
        self.latitude = 0
        self.time = ""
        self.attackType = ""
        self.medic = ""
        self.patient = ""
    }
    
    init(date: String, longitude: Double, latitude: Double, time: String, attackType: String, medic: String, patient: String)
    {
        self.date = date
        self.longitude = longitude
        self.latitude = latitude
        self.time = time
        self.attackType = attackType
        self.medic = medic
        self.patient = patient
    }
    
}
