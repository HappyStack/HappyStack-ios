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
    var identifier = 0
    let stack = Stack()
}


class Stack: Codable {
    var items = [Item]()
}

//public struct YPOptin: Codable {
//
//    public var identifier: String = ""
//    public var origin: Int = 0
//    public var hasBeenSent: Bool = false
//    public var hasBeenDisplayed: Bool = false
//    public var isFullOptin = true
//
//    public init() { }
//    public init(identifier: String, origin: Int) {
//        self.identifier = identifier
//        self.origin = origin
//    }
//}
//
//

