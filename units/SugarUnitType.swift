//
//  SugarUnitType.swift
//  Sugar
//
//  Created by Lucas Wojciechowski on 10/21/14.
//  Copyright (c) 2014 Scree Apps. All rights reserved.
//

import Foundation

protocol SugarUnitType {
    class var name:String { get }
    class var units:[SugarUnit<Self>] { get }
}

let distanceUnits = [
    SugarUnit<SugarDistance>(name: "meters", abbreviation: "m"),
    SugarUnit<SugarDistance>(name: "feet", abbreviation: "ft", multiplier: 3.28084)
]
final class SugarDistance:SugarUnitType {
    class var name:String { return "distance" }
    class var units:[SugarUnit<SugarDistance>] { return distanceUnits }
}

let pressureUnits = [
    SugarUnit<SugarPressure>(name: "mmHg",         abbreviation: "mmHg", multiplier: 7.50061683),
    SugarUnit<SugarPressure>(name: "kilopascals",  abbreviation: "kPa"),
    SugarUnit<SugarPressure>(name: "hectopascals", abbreviation: "hPa",  multiplier: 10),
    SugarUnit<SugarPressure>(name: "atmospheres",  abbreviation: "atm",  multiplier: 0.00986923267)
]
final class SugarPressure:SugarUnitType {
    class var name:String { return "pressure" }
    class var units:[SugarUnit<SugarPressure>] { return pressureUnits }
}

let temperatureUnits = [
    SugarUnit<SugarTemperature>(name: "kelvin",       abbreviation: "K",   offset: 273.15),
    SugarUnit<SugarTemperature>(name: "celcius",      abbreviation: "C"),
    SugarUnit<SugarTemperature>(name: "fahrenheit",   abbreviation: "F",   multiplier: 9.0/5.0, offset: 32)
]
final class SugarTemperature:SugarUnitType {
    class var name:String { return "temperature" }
    class var units:[SugarUnit<SugarTemperature>] { return temperatureUnits }
}


let timeUnits = [
    SugarUnit<SugarTime>(name: "seconds",       abbreviation: "s"),
    SugarUnit<SugarTime>(name: "minutes",       abbreviation: "m",  multiplier: 1/60),
    SugarUnit<SugarTime>(name: "hours",         abbreviation: "h",  multiplier: 1/60/60)
]
final class SugarTime:SugarUnitType {
    class var name:String { return "time" }
    class var units:[SugarUnit<SugarTime>] { return timeUnits }
}

let percentUnits = [
    SugarUnit<SugarPercent>(name: "percent", abbreviation: "%", multiplier: 100),
    SugarUnit<SugarPercent>(name: "decimal", abbreviation: "")
]
final class SugarPercent:SugarUnitType {
    class var name:String { return "percent" }
    class var units:[SugarUnit<SugarPercent>] { return percentUnits }
}