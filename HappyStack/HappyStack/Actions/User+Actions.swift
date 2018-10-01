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
        User.current = nil
        let api = ApiProvider.api()
        api.logout()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didLogout"), object: nil, userInfo: nil)
    }
}
