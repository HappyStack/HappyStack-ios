//
//  Stack+Actions.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

extension Stack {
    func fetch(completion:() -> Void) {
        let api = ApiProvider.api()
        api.fetchItemsForStack(stack: self) { items in
            self.items = items
            completion()
        }
    }
}
