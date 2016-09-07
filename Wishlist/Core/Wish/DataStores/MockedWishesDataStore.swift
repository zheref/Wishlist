//
//  MockedWishesDataStore.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/7/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation


class MockedWishesDataStore : WishesDataStoreProtocol
{
    
    private static let WishesKey = "wishes"
    
    
    private var mockedWishes: [WishModel] {
        var models: [WishModel] = []
        
        models.append(WishModel(withName: "iPhone 7",
            longDescription: "Telefono inteligente de la generación 2017",
            imageResourceName: "",
            price: 2500000,
            deadline: NSDate(timeIntervalSinceNow: 30000000),
            level: 5))
        
        models.append(WishModel(withName: "Apple Watch Series 2",
            longDescription: "Relój de mano inteligente de la generación 2016",
            imageResourceName: "",
            price: 1800000,
            deadline: NSDate(timeIntervalSinceNow: 15000000),
            level: 4))
        
        models.append(WishModel(withName: "Renault Sandero Stepway",
            longDescription: "Minicamioneta perfecta para mí",
            imageResourceName: "",
            price: 47000000,
            deadline: NSDate(timeIntervalSinceNow: 62000000),
            level: 3))
        
        return models
        
    }
    
    
    func insert(model: WishModel, andThenDo callback: Callback, orFailWith thrower: ErrorThrower) {
        var previous: [AnyObject] = [WishModel]()
        
        if Memcache.shared.hasKey(MockedWishesDataStore.WishesKey) {
            previous = Memcache.shared[MockedWishesDataStore.WishesKey]!
        }
        
        previous.append(model)
        
        Memcache.shared.addOrUpdateKey(MockedWishesDataStore.WishesKey, withData: previous)
        
        callback()
    }
    
    
    func retrieveAll(byReturner returner: WishesReturner, orFailWith thrower: ErrorThrower) {
        if !Memcache.shared.hasKey(MockedWishesDataStore.WishesKey) {
            Memcache.shared.addOrUpdateKey(MockedWishesDataStore.WishesKey, withData: mockedWishes)
        }
        
        if let models = Memcache.shared[MockedWishesDataStore.WishesKey] as? [WishModel] {
            returner(models)
        } else {
            thrower(WishesDataStoreError.NotPossibleToCast)
        }
    }
    
    
}