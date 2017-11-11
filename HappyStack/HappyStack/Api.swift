//
//  Api.swift
//  HappyStack
//
//  Created by Sacha DSO on 11/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Foundation

protocol Api {
    func fetchItemsForStack(stack: Stack, completion: ([Item]) -> Void)
    func delete(item: Item, completion:(() -> Void)?)
    func edit(item: Item, completion:(() -> Void)?)
}

class ApiProvider { }
