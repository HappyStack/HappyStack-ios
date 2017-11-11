//
//  Item.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

struct Item {
    
    let identifier: Int
    var name: String = ""
    var dosage: String = ""
    var time: Date = Date()
    var createdBy: User?
    var isChecked: Bool = false
    
    init(identifier: Int, name: String) {
        self.identifier = identifier
        self.name = name
    }
}
