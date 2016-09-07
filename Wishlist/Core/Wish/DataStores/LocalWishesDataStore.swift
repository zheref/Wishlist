//
//  WishesDataStore.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/6/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import UIKit
import CoreData

class LocalWishesDataStore : WishesDataStoreProtocol {
    
    func insert(withName name: String, longDescription: String?, imageResourceName: String?, imageData: NSData?,
                         price: NSDecimalNumber?, deadline: NSDate?, level: Int?, andThenDo callback: () -> Void,
                         orFailWith errorCallback: (ErrorType) -> Void)
    {
        
    }
    
    func retrieveAll(byReturner returner: () -> Void, orFailWith errorCallback: (ErrorType) -> Void) {
        let request = NSFetchRequest()
        if let context = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            request.entity = NSEntityDescription.entityForName(Wish.modelName,
                                                               inManagedObjectContext: context)
        } else {
            
        }
        
        request.includesPropertyValues = true
        //request.fetchLimit = amount
    }
    
}