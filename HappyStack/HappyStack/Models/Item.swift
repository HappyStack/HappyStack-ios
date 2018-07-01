//
//  Item.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation


enum Serving:String, Codable {
    case scoop
    case pill
    case drop
}

struct Item: Codable {
    
    let identifier: String
    var name: String
    var dosage: String
    var time: Date
    var serving = Serving.pill
    var servingSize: Int = 1
    let isChecked: Bool
    
    init(identifier: String = UUID().uuidString,
         name: String = "My supplement",
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
