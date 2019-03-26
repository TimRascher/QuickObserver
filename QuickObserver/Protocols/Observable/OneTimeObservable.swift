//
//  OneTimeObservable.swift
//
//  Created by Timothy Rascher on 7/12/18.
//  Copyright © 2018 Timothy Rascher. All rights reserved.
//

import Foundation

public protocol OneTimeObservable {
    associatedtype Item

    var observer: AnyObserver<Item> { get }

    func add(report: @escaping AnyObserver<Item>.Report)
    func update(_ report: AnyObserver<Item>.Report)
}
public extension OneTimeObservable {
    func add(report: @escaping AnyObserver<Item>.Report) {
        let wrapper = observer.set(report: report)
        update(wrapper.report)
    }
    func update(_ report: AnyObserver<Item>.Report) {}
}
public extension OneTimeObservable where Self: QuickObserver {
    var observer: AnyObserver<Item> { return AnyObserver(self) }
}
