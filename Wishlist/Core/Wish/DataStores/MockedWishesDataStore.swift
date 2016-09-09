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
    // MARK: - CLASS MEMBERS
    
    private static let WishesKey = "wishes"
    
    
    // MARK: - INSTANCER MEMBERS
    
    
    /**
     * Mocked wishes
     */
    private var mockedWishes: [WishModel] {
        let models: [WishModel] = [
            WishModel(withName: "iPhone 7",
                longDescription: "Telefono inteligente de la generación 2017",
                imageResourceName: "http://www.theinquirer.net/IMG/824/353824/iphone-7-plus-1-580x358.png?1473276015",
                price: 2500000,
                deadline: NSDate(timeIntervalSinceNow: 30000000),
                level: 5),
            WishModel(withName: "Apple Watch Series 2",
                longDescription: "Relój de mano inteligente de la generación 2016",
                imageResourceName: "http://cdn2.itpro.co.uk/sites/itpro/files/styles/insert_main_image/public/2016/09/2up-stainless-black-sport-black-select.jpg?itok=27hGrOwj",
                price: 1800000,
                deadline: NSDate(timeIntervalSinceNow: 15000000),
                level: 4),
            WishModel(withName: "Renault Sandero Stepway",
                longDescription: "Minicamioneta perfecta para mí",
                imageResourceName: "http://bright-cars.com/uploads/renault/renault-sandero-stepway/renault-sandero-stepway-15.jpg",
                price: 47000000,
                deadline: NSDate(timeIntervalSinceNow: 62000000),
                level: 3),
            WishModel(withName: "Motocicleta BMW G650",
                longDescription: "El cilindraje y diseño de una moto que siempre he querido",
                imageResourceName: "http://www.advpulse.com/wp-content/uploads/2014/03/BMW-G650GS.jpg",
                price: 38000000,
                deadline: NSDate(timeIntervalSinceNow: 97000000),
                level: 2)
        ]
        
        return models
    }
    
    
    /**
     * Insert model into memcache
     */
    func insert(model: WishModel, andThenDo callback: Callback, orFailWith thrower: ErrorThrower) {
        var previous: [AnyObject] = [WishModel]()
        
        if Memcache.shared.hasKey(MockedWishesDataStore.WishesKey) {
            previous = Memcache.shared[MockedWishesDataStore.WishesKey]!
        }
        
        previous.append(model)
        
        Memcache.shared.addOrUpdateKey(MockedWishesDataStore.WishesKey, withData: previous)
        
        callback()
    }
    
    
    /**
     * Retrieve all the models from memcache
     */
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
    
    
    /**
     *
     */
    func retrieve(byNamePrefixing prefix: String, byReturner returner: WishesReturner,
                                  orFailWith thrower: ErrorThrower) {
        
    }
    
    
}