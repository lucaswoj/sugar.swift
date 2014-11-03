//
//  SugarUnitValue.swift
//  Sugar
//
//  Created by Lucas Wojciechowski on 10/21/14.
//  Copyright (c) 2014 Scree Apps. All rights reserved.
//

import Foundation

class SugarUnitValue<Type:SugarUnitType>:SugarSerializable,Comparable {

    let value:Double
    let unit:SugarUnit<Type>

    class func fromString(string:NSString) -> SugarUnitValue<Type>? {

        var regexError:NSError? = nil
        let regex = NSRegularExpression(pattern: "^\\s*([0-9]+)\\s*([a-zA-Z]+)\\s*$", options: NSRegularExpressionOptions.allZeros, error:&regexError)

        if regexError != nil { return nil }

        let match = regex!.firstMatchInString(string, options:NSMatchingOptions.allZeros, range: NSMakeRange(0, string.length))
        if match == nil { return nil }

        let value = string.substringWithRange(match!.rangeAtIndex(1)).asDouble
        let unit = string.substringWithRange(match!.rangeAtIndex(2))

        return SugarUnitValue<Type>(value: value, unit: unit)
    }

    convenience init(value:Double, unit:String) {
        self.init(
            value: value,
            unit: SugarUnit<Type>.get(unit)!
        )
    }

    convenience init(standardValue:Double) {
        self.init(value: standardValue, unit: SugarUnit<Type>.standard)
    }

    required init(value:Double, unit:SugarUnit<Type>) {
        self.value = value
        self.unit = unit
    }

    required init(coder: NSCoder) {
        let unit = coder.decodeObjectForKey("unit") as SugarUnit<Type>
        let value = coder.decodeDoubleForKey("value")

        self.unit = unit
        self.value = value
    }

    class func unserialize(serialized: SugarSerialized) -> Self {
        return self(value: serialized.get("value")!, unit: (serialized.get("unit")! as SugarUnit<Type>))
    }

    func serialize() -> SugarSerialized {
        return SugarSerialized().set(value, key: "value").set(unit, key: "unit")
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.unit, forKey: "unit")
        coder.encodeDouble(self.value, forKey: "value")
    }

    var asStandardUnit:SugarUnitValue<Type> {
        return asUnit(SugarUnit<Type>.standard)
    }

    var standardValue:Double {
        return asStandardUnit.value
    }

    func asUnit(newUnitName:String) -> SugarUnitValue<Type> {
        return asUnit(SugarUnit<Type>.get(newUnitName)!)
    }

    func asUnit(newUnit:SugarUnit<Type>) -> SugarUnitValue<Type> {
        if (newUnit.name == unit.name) {
            return self
        } else {
            let standardValue = unit.isStandard ? value : (value - unit.offset) / unit.multiplier
            let newValue = newUnit.isStandard ? standardValue : standardValue * newUnit.multiplier + newUnit.offset

            return SugarUnitValue(value: newValue, unit: newUnit)
        }
    }

    func valueAsUnit(unit:String) -> Double {
        return asUnit(unit).value
    }

    func valueAsUnit(unit:SugarUnit<Type>) -> Double {
        return asUnit(unit).value
    }

    func asString(significantDigits:Int? = nil, fractionDigits:Int? = nil, unit:String? = nil) -> String {
        
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.usesGroupingSeparator = true
        if significantDigits != nil {
            formatter.usesSignificantDigits = true
            formatter.maximumSignificantDigits = significantDigits!
            formatter.minimumSignificantDigits = significantDigits!
        } else if fractionDigits != nil {
            formatter.minimumFractionDigits = fractionDigits!
            formatter.maximumFractionDigits = fractionDigits!
        }

        return formatter.stringFromNumber(self.value)! + " " + self.unit.abbreviation
    }

}


func - <T:SugarUnitType>(left: SugarUnitValue<T>, right: SugarUnitValue<T>) -> SugarUnitValue<T> {
    return SugarUnitValue(value: left.value - right.valueAsUnit(left.unit), unit: left.unit.name)
}

func == <T:SugarUnitType>(left: SugarUnitValue<T>, right: SugarUnitValue<T>) -> Bool {
    return left.value == right.valueAsUnit(left.unit)
}

func < <T:SugarUnitType>(left: SugarUnitValue<T>, right: SugarUnitValue<T>) -> Bool {
    return left.value < right.valueAsUnit(left.unit)
}