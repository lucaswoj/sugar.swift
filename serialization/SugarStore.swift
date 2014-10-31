//
//  SugarStore.swift
//  Sugar
//
//  Created by Lucas Wojciechowski on 10/20/14.
//  Copyright (c) 2014 Scree Apps. All rights reserved.
//

import Foundation

struct SugarStore {

    static let defaults = NSUserDefaults.standardUserDefaults()

    static func get<T:SugarSerializable>(key:String) -> T? {
        if let data = defaults.objectForKey(key) as? NSData {
            if let dictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NSDictionary {
                let serialized = SugarSerialized.fromNSDictionary(dictionary)
                let unserialized =  T.unserialize(serialized)
                return unserialized
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    static func set<T:SugarSerializable>(value:T, key:String) -> Void {
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(value.serialize().asNSDictionary), forKey: key)
        defaults.synchronize()
    }

}