//
//  WishesDataStoreProtocol.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/6/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation

protocol WishesDataStoreProtocol {
    
    func insert(withName name: String, longDescription: String?, imageResourceName: String?, imageData: NSData?,
                         price: NSDecimalNumber?, deadline: NSDate?, level: Int?, andThenDo callback: () -> Void,
                         orFailWith errorCallback: (ErrorType) -> Void)
    
}