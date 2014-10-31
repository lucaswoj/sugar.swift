# Sugar.swift

Someday, I'd like to grow this into a general utility library for Swift (somewhat like [Boost](http://www.boost.org/) in spirit.) Until then, this is just a collection of useful things I have written.

In the `serialization` directory, you will find a Swift serialization framework, like `NSCoding` and `NSUserDefaults`, but with additional type safety and support for pure Swift objects. It still has a lot of caveats but could grow into something very useful!

In the `units` directory, you will find a library for working with values with units (pressures, distances, temperatures, etc.). It eases computations using these values and uses generics and the type system to ensure operations on units are well-formed.