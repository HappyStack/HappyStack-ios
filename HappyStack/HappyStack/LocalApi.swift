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

extension ApiProvider {
    static func api() -> Api {
        return LocalApi.shared
    }
}



/**
 JSONPersistable takes care of persisting JSON serializable objects
 to the NSUserDefaults.
 */
public protocol JSONPersistable: Codable {
    func toJSONString() -> String
}

// Make Codable objects persistable out of the box :)
extension JSONPersistable {
    public func toJSONString() -> String {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self), let str = String(data: data, encoding: .utf8) {
            return str
        }
        return ""
    }
}


public struct Persistence {
    
    static func persist(_ object: JSONPersistable, onKey: String) {
        store(object.toJSONString(), forKey: onKey)
    }
    
    static func object<T: JSONPersistable>(forKey: String) -> T? {
        let decoder = JSONDecoder()
        if let jsonString = retrieveString(forKey: forKey),
            let jsonData = jsonString.data(using: .utf8),
            let object = try? decoder.decode(T.self, from: jsonData) {
            
            return object
        }
        return nil
    }
    
    static func removeObject(onKey: String) {
        removeString(forKey: onKey)
    }
    
    // MARK: - Helpers
    
    private static func store(_ string: String, forKey: String) {
        let localStore = UserDefaults.standard
        localStore.set(string, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    private static func retrieveString(forKey: String) -> String? {
        let localStore = UserDefaults.standard
        return localStore.value(forKey: forKey) as? String
    }
    
    private static func removeString(forKey: String) {
        let localStore = UserDefaults.standard
        localStore.removeObject(forKey: forKey)
        UserDefaults.standard.synchronize()
    }
}
