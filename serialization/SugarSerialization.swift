//
//  SugarSerialization.swift
//  Sugar
//
//  Created by Lucas Wojciechowski on 10/22/14.
//  Copyright (c) 2014 Scree Apps. All rights reserved.
//

import Foundation

protocol SugarSerializable {
    func serialize() -> SugarSerialized
    class func unserialize(SugarSerialized) -> Self
}

final class SugarSerialized {

    var values:[String:NSCoding]

    var asNSDictionary:NSDictionary { return values as NSDictionary }
    class func fromNSDictionary(d:NSDictionary) -> SugarSerialized { return SugarSerialized(values: d as [String:NSCoding]) }

    init() {
        values = [:]
    }

    private init(values:[String:NSCoding]) {
        self.values = values
    }

    func set(value:NSCoding, key:String) -> SugarSerialized {
        values[key] = value
        return self
    }

    func set(value:SugarSerializable, key:String) -> SugarSerialized {
        values[key] = value.serialize().asNSDictionary
        return self
    }

    func get<T:SugarSerializable>(key:String) -> T? {
        let dictionary = values[key] as NSDictionary?
        if dictionary == nil {
            return nil
        } else {
            return T.unserialize(SugarSerialized.fromNSDictionary(dictionary!))
        }
    }

    func get<T>(key:String) -> T? {
        return values[key] as T?
    }

}