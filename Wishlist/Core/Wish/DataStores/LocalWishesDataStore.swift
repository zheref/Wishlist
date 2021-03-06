//
//  LocalWishesDataStore.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/6/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import UIKit
import CoreData

class LocalWishesDataStore : WishesDataStoreProtocol
{
    
    // MARK: - INSTANCE MEMBERS
    
    
    /**
     * Insert model as record into core data DB
     */
    func insert(model: WishModel, andThenDo callback: Callback, orFailWith thrower: ErrorThrower) {
        let context = AppDelegate.sharedInstance.managedObjectContext
        
        if let entity = NSEntityDescription.entityForName(Wish.modelName,
                                                          inManagedObjectContext: context) {
            
            let wish = NSManagedObject(entity: entity, insertIntoManagedObjectContext: context)
            
            wish.setValue(model.name, forKey: "name")
            wish.setValue(model.longDescription, forKey: "longDescription")
            wish.setValue(model.imageResourceName, forKey: "imageResourceName")
            wish.setValue(model.price, forKey: "price")
            wish.setValue(model.deadline, forKey: "deadline")
            wish.setValue(model.level, forKey: "level")
            wish.setValue(model.imageData, forKey: "imageData")
            
            Batground.run {
                do {
                    try context.save()
                    
                    BatUI.run({
                        callback()
                    })
                } catch {
                    BatUI.run({
                        thrower(error)
                    })
                }
            }
            
        } else {
            thrower(WishesDataStoreError.CouldNotCreateManagedEntityFor(modelName: Wish.modelName))
        }
    }
    
    
    /**
     * Retrieve all records as model from core data DB
     */
    func retrieveAll(byReturner returner: WishesReturner, orFailWith thrower: ErrorThrower) {
        let request = NSFetchRequest()
        let context = AppDelegate.sharedInstance.managedObjectContext
        
        request.entity = NSEntityDescription.entityForName(Wish.modelName,
                                                           inManagedObjectContext: context)
        
        request.includesPropertyValues = true
        
        Batground.run {
            do {
                if let results = try context.executeFetchRequest(request) as? [Wish] {
                    let models = results.map({ (wish) -> WishModel in
                        return WishModel(withManaged: wish)
                    })
                    
                    BatUI.run({
                        returner(models)
                    })
                } else {
                    BatUI.run({
                        thrower(WishesDataStoreError.NotPossibleToCastManaged)
                    })
                }
            } catch {
                thrower(error)
            }
        }
    }
    
    
    /**
     * Retrieve records filtered by prefix and sorted as specified from core data DB
     */
    func retrieve(byNamePrefixing prefix: String, sorted sortMode: SortingMode,
                                  byReturner returner: WishesReturner, orFailWith thrower: ErrorThrower) {
        let request = NSFetchRequest()
        
        request.predicate = NSPredicate(format: "\(WishModel.KName) like \"%@*\"", prefix)
        
        request.sortDescriptors = [NSSortDescriptor(key: WishModel.KName, ascending: sortMode == SortingMode.Ascendent)]
        
        let context = AppDelegate.sharedInstance.managedObjectContext
        
        request.entity = NSEntityDescription.entityForName(Wish.modelName,
                                                           inManagedObjectContext: context)
        
        request.includesPropertyValues = true
        
        Batground.run {
            do {
                if let results = try context.executeFetchRequest(request) as? [Wish] {
                    let models = results.map({ (wish) -> WishModel in
                        return WishModel(withManaged: wish)
                    })
                    
                    BatUI.run({
                        returner(models)
                    })
                } else {
                    BatUI.run({
                        thrower(WishesDataStoreError.NotPossibleToCastManaged)
                    })
                }
            } catch {
                thrower(error)
            }
        }
    }
    
    
}