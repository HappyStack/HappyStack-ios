//
//  Stack+Actions.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation
import then

extension Stack {
    func fetch() -> EmptyPromise {
        let api = ApiProvider.api()
        return api.fetchItemsForStack(stack: self).then { items in
            self.items = items
        }
    }
}
