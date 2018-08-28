//
//  Item+JSON.swift
//  HappyStack
//
//  Created by Sacha on 28/08/2018.
//  Copyright © 2018 HappyStack. All rights reserved.
//

import Foundation
import Arrow

extension Item: ArrowParsable {
    
    init() {
        identifier = 0
        name = ""
        dosage = ""
        time = Date()
        serving = .pill
        servingSize = 1
        isChecked = false
    }
    
    mutating func deserialize(_ json: JSON) {
        identifier <-- json["id"]
        name <-- json["name"]
        dosage <-- json["dosage"]
        servingSize <-- json["servingSize"]
        serving <-- json["servingType"]
        isChecked <-- json["takenToday"]
        time <-- json["timing"]
    }
}
