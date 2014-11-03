//
//  Format.swift
//  Altimetry
//
//  Created by Lucas Wojciechowski on 10/5/14.
//  Copyright (c) 2014 Scree Apps. All rights reserved.
//

import Foundation

extension Int {
    func format(f: String) -> String {
        return NSString(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self)
    }
}

extension String {
    var asDouble: Double {
        get {
            return NSString(string: self).doubleValue
        }
    }
}

extension Array {

    func find(filter: T -> Bool) -> T? {
        for (idx, element) in enumerate(self) {
            if filter(element) {
                return element
            }
        }
        return nil
    }

}

extension Dictionary {
    
    func map<T>(filter: (Key, Value) -> T) -> [Key: T] {
        
        var mapped:[Key:T] = [:]
        
        for (key, value) in self {
            mapped[key] = filter(key, value)
        }
        
        return mapped
    }
    
}