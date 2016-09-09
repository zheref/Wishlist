//
//  WishRepository.swift
//  Wishlist
//
//  Created by Sergio Daniel Leztark on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation


protocol WishesDataManagerProtocol {
    
    func getWishes(returner: ([WishModel]) -> Void, orFailWith thrower: (ErrorType) -> Void)
    func getWishes(withPrefixingName prefix: String, sorting: SortingMode, returner: ([WishModel]) -> Void, orFailWith thrower: (ErrorType) -> Void)
    
}


class WishesDataManager : WishesDataManagerProtocol {
    
    func getWishes(returner: ([WishModel]) -> Void, orFailWith thrower: (ErrorType) -> Void) {
        var collectedModels: [WishModel] = []
        
        let localStore = LocalWishesDataStore()
        let mockedStore = MockedWishesDataStore()
        
        localStore.retrieveAll(byReturner: { (models) in
            collectedModels.appendContentsOf(models)
            
            mockedStore.retrieveAll(byReturner: { (models) in
                collectedModels.appendContentsOf(models)
                
                returner(models)
            }, orFailWith: { (error) in
                thrower(error)
            })
            
        }) { (error) in
            thrower(error)
        }
        
    }
    
    
    func getWishes(withPrefixingName prefix: String, sorting: SortingMode, returner: ([WishModel]) -> Void, orFailWith thrower: (ErrorType) -> Void) {
        var collectedModels: [WishModel] = []
        
        let localStore = LocalWishesDataStore()
        let mockedStore = MockedWishesDataStore()
        
        localStore.retrieve(byNamePrefixing: prefix, sorted: sorting, byReturner: { (models) in
            collectedModels.appendContentsOf(models)
            
            mockedStore.retrieve(byNamePrefixing: prefix, sorted: sorting, byReturner: { (models) in
                collectedModels.appendContentsOf(models)
                
                returner(models)
            }, orFailWith: { (error) in
                    thrower(error)
            })
        }) { (error) in
            thrower(error)
        }
    }
    
}