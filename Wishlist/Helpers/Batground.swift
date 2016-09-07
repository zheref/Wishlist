//
//  Batground.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/7/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation

class Batground {
    
    static func run(task: () -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), task)
    }
    
}

class BatUI {
    
    static func run(task: () -> Void) {
        dispatch_async(dispatch_get_main_queue(), task)
    }
    
}