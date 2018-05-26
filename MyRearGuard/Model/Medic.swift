//
//  Medic.swift
//  Medic
//
//  Created by Kiet Lam on 16/5/18.
//  Copyright © 2018 Kiet Lam. All rights reserved.
//

import Foundation

class Medic
{
    var index: Int
    var email: String
    
    init() // default constructor
    {
        self.index = 0
        self.email = ""
    }
    
    init(email: String, index: Int)
    {
        self.email = email
        self.index = index
    }
    
    
}
