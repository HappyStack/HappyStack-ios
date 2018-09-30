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
import Alamofire

class GoApi: Api {
    
    static let shared = GoApi()
    
    let network = WS("http://104.248.56.250:8080")
    
    init() {
        network.logLevels = .debug
        network.postParameterEncoding = JSONEncoding()
    }
    
    func fetchItemsForStack(stack: Stack) -> Promise<[Item]> {
        let userId = User.current?.identifier ?? 0
        return network.get("/users/\(userId)/items")
    }
    
    func delete(item: Item) -> EmptyPromise {
        let userId = User.current?.identifier ?? 0
        return network.delete("/users/\(userId)/items/\(item.identifier)")
    }
    
    func edit(item: Item) -> EmptyPromise {
        let params:[String : Any] = [
            "name": item.name,
            "dosage": item.dosage,
            "servingSize": item.servingSize,
            "servingType": item.serving.rawValue
//            "timing": "0001-01-01T00:00:00Z"
        ]
        
        let userId = User.current?.identifier ?? 0
        
        // New item
        if item.identifier == 0 {
            return network.post("/users/\(userId)/items", params: params)
        }
        
        // TODO implement edit item
        return network.put("/users/\(userId)/items/\(item.identifier)", params: params)
    }
    
    func login(username: String, password: String) -> Promise<User> {
        // TODO
        return Promise.reject()
    }
    
    func logout() {
        // TODO
    }
}
