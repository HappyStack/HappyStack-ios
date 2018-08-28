//
//  Persistence.swift
//  HappyStack
//
//  Created by Sacha on 28/08/2018.
//  Copyright © 2018 HappyStack. All rights reserved.
//

import Foundation

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
