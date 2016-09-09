//
//  NetworkWishesDataStore.swift
//  Wishlist
//
//  Created by Sergio Daniel Leztark on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation
import Alamofire

class NetworkWishesDataStore : WishesDataStoreProtocol
{
    
    // MARK: - INSTANCE MEMBERS
    
    /**
     *
     */
    func insert(model: WishModel, andThenDo callback: Callback, orFailWith thrower: ErrorThrower) {
        
    }
    
    
    /**
     *
     */
    func retrieveAll(byReturner returner: WishesReturner, orFailWith thrower: ErrorThrower) {
        let urlString = KUris.Host + "/get"
        
        Alamofire.request(.GET, urlString).responseJSON { response in
            switch response.result {
            case .Success:
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            case .Failure(let error):
                thrower(error)
            }
            
            
        }
    }
    
    
    /**
     *
     */
    func retrieve(byNamePrefixing prefix: String, byReturner returner: WishesReturner,
                                  orFailWith thrower: ErrorThrower) {
        
    }
    
    
}