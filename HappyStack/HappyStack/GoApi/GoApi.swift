//
//  GoApi.swift
//  HappyStack
//
//  Created by Sacha on 28/08/2018.
//  Copyright © 2018 HappyStack. All rights reserved.
//

import Foundation
import ws
import then

class GoApi: Api {
    
    static let shared = GoApi()
    
    let network = WS("http://104.248.56.250:8080")
    
    init() {
        network.logLevels = .debug
    }
    
    func fetchItemsForStack(stack: Stack) -> Promise<[Item]> {
        return network.get("/users/1/items")
    }
    
    func delete(item: Item) -> EmptyPromise {
        return network.delete("/users/1/items/\(item.identifier)")
    }
    
    func edit(item: Item) -> EmptyPromise {
        // TODO
        return Promise.reject()
    }
    
    func login(username: String, password: String) -> Promise<User> {
        // TODO
        return Promise.reject()
    }
    
    func logout() {
        // TODO
    }
}
