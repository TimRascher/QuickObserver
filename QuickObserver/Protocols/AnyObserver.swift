//
//  AnyObserver.swift
//
//  Created by Timothy Rascher on 7/12/18.
//  Copyright © 2018 Timothy Rascher. All rights reserved.
//

import Foundation

private class _AnyObserverBase<Item>: QuickObserver {
    var observers: [UUID: (Result<Item>) -> Void] {
        get { fatalError("Must Override") }
        // swiftlint:disable unused_setter_value
        set { fatalError("Must Override") }
        // swiftlint:enable unused_setter_value
    }

    func set<ExternalObserver>(
        observer externalObserver: ExternalObserver,
        report: @escaping (ExternalObserver, Result<Item>) -> Void)
        -> ObserverReportWrapper<Item> where ExternalObserver: AnyObject {
            fatalError("Must Override")
    }
    func set(report: @escaping (Result<Item>) -> Void) -> ObserverReportWrapper<Item> {
        fatalError("Must Override")
    }
    func report(_ item: Item) {
        fatalError("Must Override")
    }
    func report(error: Error) {
        fatalError("Must Override")
    }
    func fowardError<T>(_ result: Result<T>) {
        fatalError("Must Override")
    }
}

private final class _AnyObserverBox<Observer: QuickObserver>: _AnyObserverBase<Observer.Item> {
    var observer: Observer

    init(_ observer: Observer) {
        self.observer = observer
    }
    override var observers: [UUID: (Result<Item>) -> Void] {
        get { return observer.observers }
        set(value) { observer.observers = value }
    }
    override func set<ExternalObserver>(
        observer externalObserver: ExternalObserver,
        report: @escaping (ExternalObserver, Result<Item>) -> Void)
        -> ObserverReportWrapper<Item> where ExternalObserver: AnyObject {
            return observer.set(observer: externalObserver, report: report)
    }
    override func set(report: @escaping (Result<Item>) -> Void) -> ObserverReportWrapper<Item> {
        return observer.set(report: report)
    }
    override func report(_ item: Item) {
        observer.report(item)
    }
    override func report(error: Error) {
        observer.report(error: error)
    }
    override func fowardError<T>(_ result: Result<T>) {
        observer.fowardError(result)
    }
}

public final class AnyObserver<Item> {
    private let box: _AnyObserverBase<Item>

    public init<Observer: QuickObserver>(_ observer: Observer) where Observer.Item == Item {
        box = _AnyObserverBox(observer)
    }
}

extension AnyObserver: QuickObserver {
    public var observers: [UUID: (Result<Item>) -> Void] {
        get { return box.observers }
        set(value) { box.observers = value }
    }

    public func set<ExternalObserver>(
        observer externalObserver: ExternalObserver,
        report: @escaping (ExternalObserver, Result<Item>) -> Void)
        -> ObserverReportWrapper<Item> where ExternalObserver: AnyObject {
            return box.set(observer: externalObserver, report: report)
    }
    public func set(report: @escaping (Result<Item>) -> Void) -> ObserverReportWrapper<Item> {
        return box.set(report: report)
    }
    public func report(_ item: Item) {
        box.report(item)
    }
    public func report(error: Error) {
        box.report(error: error)
    }
    public func fowardError<T>(_ result: Result<T>) {
        box.fowardError(result)
    }
}
