//
//  Wish+CoreDataProperties.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/6/16.
//  Copyright © 2016 zheref. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Wish {

    @NSManaged var name: String?
    @NSManaged var longDescription: String?
    @NSManaged var imageResourceName: String?
    @NSManaged var price: NSDecimalNumber?
    @NSManaged var deadline: NSDate?
    @NSManaged var level: NSNumber?
    @NSManaged var imageData: NSData?

}
