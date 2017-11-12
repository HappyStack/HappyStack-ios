//
//  FakeApi.swift
//  HappyStack
//
//  Created by Sacha DSO on 11/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation
import then

class FakeApi: Api {

    static let shared = FakeApi()
    
    private var token: String?
    
    var dataBase: [Item] = {
        return [
            Item(identifier: 1, name: "vitamine D"),
            Item(identifier: 2, name: "Meditation"),
            Item(identifier: 3, name: "Magnesium"),
        ]
    }()
    
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
        return Promise.resolve(dataBase)
    }
    
    func delete(item: Item) -> EmptyPromise {
        dataBase = dataBase.filter { $0.identifier != item.identifier }
        return Promise.resolve()
    }
    
    func edit(item: Item) -> EmptyPromise {
        dataBase = dataBase.filter { $0.identifier != item.identifier }
        dataBase.append(item)
        return Promise.resolve()
    }
}


extension ApiProvider {
    static func api() -> Api {
        return FakeApi.shared
    }
}
