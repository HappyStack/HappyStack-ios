//
//  User+Actions.swift
//  HappyStack
//
//  Created by Sacha DSO on 12/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation
import then

extension User {
    class func login(username: String, password: String) -> Promise<User> {
        let api = ApiProvider.api()
        return api.login(username: username, password: password)
    }
    
    func logout() {
        let api = ApiProvider.api()
        api.logout()
    }
}
