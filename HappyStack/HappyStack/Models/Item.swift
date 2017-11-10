//
//  Item.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

class Item {
    var name: String = ""
    var time: Date = Date()
    var createdBy: User?
    var isChecked: Bool = false
}
