//
//  BatLog.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/7/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation


internal enum BatLogLevel : Int {
    case Off = 0
    case Severe = 1
    case Error = 2
    case Warning = 3
    case Info = 4
    case Debug = 5
    case Verbose = 6
    
    var description: String {
        switch self {
        case .Off:
            return "OFF"
        case .Severe:
            return "SEVERE"
        case .Error:
            return "ERROR"
        case .Warning:
            return "WARNING"
        case .Info:
            return "INFO"
        case .Debug:
            return "DEBUG"
        case .Verbose:
            return "VERBOSE"
        }
    }
}


internal class BatLog {
    
    internal static let level: BatLogLevel = .Verbose
    internal static let unknownModule = "UN"
    
    
    internal static var shared: BatLog = {
        return BatLog()
    }()
    
    
    private init() {}
    
    
    private func log(text: String, withLevel level: BatLogLevel) {
        if BatLog.level.rawValue >= level.rawValue {
            NSLog("[\(NSDate().description)] [\(level.description)] >>> \(text)")
        }
    }
    
    internal func verbose(text: String) {
        self.log(text, withLevel: .Verbose)
    }
    
    internal func debug(text: String) {
        self.log(text, withLevel: .Debug)
    }
    
    internal func info(text: String) {
        self.log(text, withLevel: .Info)
    }
    
    internal func warning(text: String) {
        self.log(text, withLevel: .Warning)
    }
    
    internal func error(text: String) {
        self.log(text, withLevel: .Error)
    }
    
    internal func severe(text: String) {
        self.log(text, withLevel: .Severe)
    }
    
}