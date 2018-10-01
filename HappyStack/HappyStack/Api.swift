//
//  Api.swift
//  HappyStack
//
//  Created by Sacha DSO on 11/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation
import then
import Arrow

protocol Api {
    func fetchItemsForStack(stack: Stack) -> Promise<[Item]>
    func delete(item: Item) -> EmptyPromise
    func edit(item: Item) -> EmptyPromise
    func login(username: String, password:String) -> Promise<User>
    func logout()
}

class ApiProvider { }
