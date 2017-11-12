//
//  Item+Actions.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

extension Item {
    
    func saveInBackground() {
        let api = ApiProvider.api()
        api.edit(item: self).start()
    }
    
    func deleteInBackground() {
        let api = ApiProvider.api()
        api.delete(item: self).start()
    }
}
                    
