//
//  SugarUnit.swift
//  Sugar
//
//  Created by Lucas Wojciechowski on 10/16/14.
//  Copyright (c) 2014 Scree Apps. All rights reserved.
//

import Foundation

final class SugarUnit<Type:SugarUnitType>:SugarSerializable {

    class var all:[SugarUnit<Type>] { return Type.units }

    class func get(name:String) -> SugarUnit<Type>? {
        return all.find({
            unit in return unit.matches(name)
        })
    }

    class var standard:SugarUnit<Type> {
        return all.find({unit in return unit.isStandard})!
    }

    let name:String
    let abbreviation:String
    let multiplier:Double // Multiplier is this unit per standard unit
    let offset:Double // Offset is measured in this unit

    convenience init(unit:SugarUnit) {
        self.init(
            name: unit.name,
            abbreviation: unit.abbreviation,
            multiplier: unit.multiplier,
            offset: unit.offset
        )
    }

    init(name:String, abbreviation:String, multiplier:Double = 1, offset:Double = 0) {
        self.name = name
        self.abbreviation = abbreviation
        self.multiplier = multiplier
        self.offset = offset
    }

    convenience required init(coder: NSCoder) {
        let name = coder.decodeObjectForKey("name") as String
        let TypeName = coder.decodeObjectForKey("TypeName") as String

        self.init(unit: SugarUnit<Type>.get(name)!)
    }

    class func unserialize(s:SugarSerialized) -> SugarUnit {
        let unit = get(s.get("name")!)!
        assert(s.get("type") == Type.name)

        return unit
    }

    func serialize() -> SugarSerialized {
        return SugarSerialized().set(name, key: "name").set(Type.name, key: "type")
    }

    var isStandard:Bool {
        return multiplier == 1 && offset == 0
    }

    func matches(name_:String) -> Bool {
        let name = name_.lowercaseString
        return (self.name.lowercaseString == name || self.abbreviation.lowercaseString == name)
    }
}
