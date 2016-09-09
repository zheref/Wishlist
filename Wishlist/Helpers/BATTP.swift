//
//  BATTP.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation


typealias DataReturner = (NSData) -> Void


enum BATTPError : ErrorType {
    case NoDataAvailableInResponse
}


class BATTP {
    
    /**
     * Gets an image from the network given its URI
     * - Parameter uri String: The URI of the image resource over the network
     */
    internal static func getImage(uri: String, by returner: DataReturner,
                                  orFailWith thrower: (String) -> Void) {
        
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: uri)!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if let error = error {
                thrower(error.localizedDescription)
            } else if let data = data {
                returner(data)
            } else {
                thrower("\(BATTPError.NoDataAvailableInResponse)")
            }
        }
        
        task.resume()
        
    }
    
}