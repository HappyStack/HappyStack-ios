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
import Arrow

private let kAuthorizationKey = "Authorization"

extension WS {
    
    var jwtToken: String? {
        get { return headers[kAuthorizationKey] }
        set {
            if let t = newValue {
                headers = [kAuthorizationKey: t]
            } else {
                headers[kAuthorizationKey] = nil
            }
        }
    }
}

class GoApi: Api {
    
    static let shared = GoApi()
    
    //    let network = WS("http://localhost:8080")
    let network = WS("http://104.248.56.250:8080")
    
    init() {
        network.logLevels = .debug
        network.postParameterEncoding = JSONEncoding()
        
        network.jwtToken = storedToken()
    }
    
    func storedToken() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "HSAuthToken")
    }
    
    func storeToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "HSAuthToken")
        defaults.synchronize()
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
        let params = ["username" : username, "password" : password]
        return network.post("/login", params: params).then { [weak self] (json:JSON) -> User in
            let user = User()
            if let token: String = json["token"]?.data as? String {
                self?.network.jwtToken = token
                self?.storeToken(token: token)
                user.identifier = self?.userIdFromToken(token: token) ?? 0
            }
            return user
        }
    }
    
    func userIdFromToken(token: String) -> Int? {
        var tokenMiddleSection = String(token.split(separator: ".")[1])
        
        let rest = tokenMiddleSection.count % 4
        print(rest)
            
        if rest == 1 {
            tokenMiddleSection += "==="
        }
        if rest == 2 {
            tokenMiddleSection += "=="
        }
        if rest == 3 {
            tokenMiddleSection += "="
        }
        if let decodedData = Data(base64Encoded: tokenMiddleSection),
            let decodedString = String(data: decodedData, encoding: .utf8) {
            let tokenJsonPayload = JSON(decodedString)
            var userId: Int? = 0
            userId <-- tokenJsonPayload?["userId"]
            return userId
        }
        return nil
    }
    
    func logout() {
        network.jwtToken = nil
    }
}
