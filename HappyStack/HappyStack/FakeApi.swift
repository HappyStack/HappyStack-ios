//
//  FakeApi.swift
//  HappyStack
//
//  Created by Sacha DSO on 11/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

class FakeApi: Api {

    static let shared = FakeApi()
    
    var dataBase: [Item] = {
        return [
            Item(identifier: 1,name: "vitamine D"),
            Item(identifier: 2, name: "Meditation"),
            Item(identifier: 3, name: "Magnesium"),
        ]
    }()
    
    func fetchItemsForStack(stack: Stack, completion: ([Item]) -> Void) {
        print("Fetching Stack")
        completion(dataBase)
    }
    
    func delete(item: Item, completion: (() -> Void)?) {
        dataBase = dataBase.filter { $0.identifier != item.identifier }
        completion?()
    }
    
    func edit(item: Item, completion: (() -> Void)?) {
        dataBase = dataBase.filter { $0.identifier != item.identifier }
        dataBase.append(item)
        completion?()
    }
}


extension ApiProvider {
    static func api() -> Api {
        return FakeApi.shared
    }
}
