//
//  Item.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

struct Item: Codable {
    
    let identifier: String
    let name: String
    let dosage: String
    let time: Date
    let isChecked: Bool
    
    init(identifier: String = UUID().uuidString,
         name: String,
         dosage: String = "",
         time: Date = Date(),
         isChecked: Bool = false) {
        self.identifier = identifier
        self.name = name
        self.dosage = dosage
        self.time = time
        self.isChecked = isChecked
    }
}
