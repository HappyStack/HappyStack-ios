//
//  User.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

class User {
    static var current: User?
    let stack = Stack()
}


class Stack {
    var items = [Item]()
}
                                                                                                    
