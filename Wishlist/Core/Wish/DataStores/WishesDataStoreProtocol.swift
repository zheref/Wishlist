//
//  WishesDataStoreProtocol.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/6/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation

typealias Callback = () -> Void
typealias ErrorThrower = (ErrorType) -> Void
typealias WishesReturner = ([WishModel]) -> Void


enum WishesDataStoreError : ErrorType {
    
    case CouldNotCreateManagedEntityFor(modelName: String)
    case NotPossibleToCastManaged
    case NotPossibleToCast
    
}


protocol WishesDataStoreProtocol {
    
    func insert(model: WishModel, andThenDo callback: Callback, orFailWith thrower: ErrorThrower)
    
    func retrieveAll(byReturner returner: WishesReturner, orFailWith thrower: ErrorThrower)
    
}