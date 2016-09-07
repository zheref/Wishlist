//
//  Wish.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/6/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation

class WishModel {
    
    var name: String
    var longDescription: String?
    var imageResourceName: String?
    var imageData: NSData?
    
    var price: NSDecimalNumber?
    var deadline: NSDate?
    var level: Int = 0
    
    init(withName name: String) {
        self.name = name
    }
    
    init(withManaged managed: Wish) {
        name = managed.name!
        longDescription = managed.longDescription
        imageResourceName = managed.imageResourceName
        imageData = managed.imageData
        price = managed.price
        deadline = managed.deadline
        level = managed.level!.integerValue
    }
    
}