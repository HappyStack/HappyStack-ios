//
//  User+Actions.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

extension User {
    // where user is me (createdBy)
    func fetchStack(items:([Item]) -> Void) {
        
        let item1 = Item()
        item1.name = "vitamine D"
        
        let item2 = Item()
        item2.name = "Meditation"
        
        let item3 = Item()
        item3.name = "Magnesium"
        
        items([item1, item2, item3])
    }
}
