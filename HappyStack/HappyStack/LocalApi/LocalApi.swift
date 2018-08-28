//
//  LocalApi.swift
//  HappyStack
//
//  Created by Sacha DSO on 11/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation
import then

class LocalApi: Api {

    static let shared = LocalApi()
    
    private var token: String?
    
    private let stack: Stack
    
    init() {
        // Rehydrate Database.
        let savedStack: Stack? = Persistence.object(forKey: "myStack")
        print(savedStack)
        self.stack = savedStack ?? Stack()
    
    }
    
    func login(username: String, password: String) -> Promise<User> {
        if username == "sacha" && password == "1234" {
            token = "asfrghfdkgjwlegwf134"
            return Promise.resolve(User())
        }
        return Promise.reject()
    }
    
    func logout() {
        token = nil
    }
    
    func fetchItemsForStack(stack: Stack) -> Promise<[Item]> {
        return Promise.resolve(self.stack.items)
    }
    
    func delete(item: Item) -> EmptyPromise {
        stack.items = stack.items.filter { $0.identifier != item.identifier }
        saveToDisk()
        return Promise.resolve()
    }
    
    func edit(item: Item) -> EmptyPromise {
        stack.items = stack.items.filter { $0.identifier != item.identifier }
        stack.items.append(item)
        saveToDisk()
        return Promise.resolve()
    }
    
    private func saveToDisk() {
        Persistence.persist(stack, onKey: "myStack")
    }
}

extension Stack: JSONPersistable {
    
}
