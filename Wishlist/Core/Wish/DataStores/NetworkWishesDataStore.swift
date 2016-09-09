//
//  NetworkWishesDataStore.swift
//  Wishlist
//
//  Created by Sergio Daniel Leztark on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation
import Alamofire


class NetworkWishesDataStore : WishesDataStoreProtocol {
    
    // MARK: - INSTANCE MEMBERS
    
    /**
     * Persist model through REST web service
     */
    func insert(model: WishModel, andThenDo callback: Callback, orFailWith thrower: ErrorThrower) {
        let urlString = KUris.Host + "/post"
        
        Alamofire.request(.POST, urlString, parameters: ["wish": model.dictVersion]).responseJSON { response in
            switch response.result {
            case .Success:
                callback()
            case .Failure(let error):
                thrower(error)
            }
        }
    }
    
    
    /**
     * Retrieve all the dicts from the REST web service
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
     * Retrieve all dicts filted by prefixing name
     */
    func retrieve(byNamePrefixing prefix: String, byReturner returner: WishesReturner,
                                  orFailWith thrower: ErrorThrower) {
        let urlString = KUris.Host + "/get/\(prefix)"
        
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
    
    
}