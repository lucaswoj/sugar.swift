//
//  SugarEventStream.swift
//  Sugar
//
//  Created by Lucas Wojciechowski on 10/20/14.
//  Copyright (c) 2014 Scree Apps. All rights reserved.
//

import Foundation

class SugarEventStream<T> {

    init() {}

    var handlers:[(handler:Handler, once:Bool, queue:NSOperationQueue?)] = []

    typealias Handler = T -> Void

    func addHandler(handler:Handler, once:Bool = false, queue:NSOperationQueue? = nil) {
        handlers.append((handler: handler, once: once, queue:queue))
    }

    func trigger(value:T) {
        for (index, (handler, once, queue)) in enumerate(handlers) {

            if queue == nil {
                handler(value)
            } else {
                queue!.addOperation(NSBlockOperation({
                    handler(value)
                }))
            }

            if once {
                handlers.removeAtIndex(index)
            }
        }
    }
}