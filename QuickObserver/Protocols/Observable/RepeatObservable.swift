//
//  RepeatObservable.swift
//
//  Created by Timothy Rascher on 7/12/18.
//  Copyright © 2018 Timothy Rascher. All rights reserved.
//

import Foundation

public protocol RepeatObservable {
    associatedtype Item

    var observer: AnyObserver<Item> { get }

    func add<Observer: AnyObject>(
        observer: Observer,
        report: @escaping AnyObserver<Item>.ObserverReport<Observer>)
    func update(_ report: AnyObserver<Item>.Report)
}
public extension RepeatObservable {
    func add<Observer: AnyObject>(
        observer: Observer,
        report: @escaping AnyObserver<Item>.ObserverReport<Observer>) {
        let wrapper = self.observer.set(observer: observer, report: report)
        update(wrapper.report)
    }
    func update(_ report: AnyObserver<Item>.Report) {}
}
public extension RepeatObservable where Self: QuickObserver {
    var observer: AnyObserver<Item> { return AnyObserver(self) }
}
