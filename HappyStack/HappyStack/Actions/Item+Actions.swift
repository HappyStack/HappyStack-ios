//
//  Item+Actions.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation
import then

extension Item {
    
    func save() -> EmptyPromise {
        return ApiProvider.api().edit(item: self)
    }
    
    func delete() -> EmptyPromise  {
        return ApiProvider.api().delete(item: self)
    }
}
                    
