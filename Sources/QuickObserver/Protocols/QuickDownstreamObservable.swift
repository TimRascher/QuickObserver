// Created by Timothy Rascher
//  Copyright © 2020 CA Lottery. All rights reserved.

import Foundation

public protocol QuickInputDownstreamable: QuickObservable {
    associatedtype Input
    func run(_ input: Input)
    func cancel()
}
public protocol QuickDownstreamable: QuickInputDownstreamable {
    typealias Input = Any?
    func run()
}
public extension QuickDownstreamable {
    public func run(_ input: Input) { run() }
}
