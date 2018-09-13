//
//  QuickObserver.swift
//
//  Created by Timothy Rascher on 7/12/18.
//  Copyright © 2018 Timothy Rascher. All rights reserved.
//

import Foundation

public protocol QuickObserver: AnyObject {
    // MARK: - Type Aliases
    associatedtype Item
    typealias Report = (Result<Item>) -> Void
    typealias ObserverReport<ExternalObserver: AnyObject> = (ExternalObserver, Result<Item>) -> Void

    // MARK: - Properties Declaration
    var observers: [UUID: Report] { get set }

    // MARK: - Observers Management Declaration
    func add<ExternalObserver: AnyObject>(
        observer externalObserver: ExternalObserver,
        report: @escaping ObserverReport<ExternalObserver>)
        -> ObserverReportWrapper<Item>
    func add(report: @escaping Report) -> ObserverReportWrapper<Item>

    // MARK: - Data Reporting Declaration
    func report(_ item: Item)
    func report(error: Error)
    func fowardError<T>(_ result: Result<T>)
}

// MARK: - Observers Management
public extension QuickObserver {
    @discardableResult
    public func add<ExternalObserver: AnyObject>(
        observer externalObserver: ExternalObserver,
        report: @escaping ObserverReport<ExternalObserver>)
        -> ObserverReportWrapper<Item> {
            let uuid = UUID()
            let internalReport = { [weak externalObserver, weak self] (result: Result<Item>) in
                guard let externalObserver = externalObserver else {
                    self?.observers.removeValue(forKey: uuid)
                    return
                }
                report(externalObserver, result)
            }
            observers[uuid] = internalReport
            return ObserverReportWrapper(report: internalReport)
    }
    @discardableResult
    public func add(report: @escaping Report) -> ObserverReportWrapper<Item> {
        let uuid = UUID()
        let internalReport = { [weak self] (result: Result<Item>) in
            self?.observers.removeValue(forKey: uuid)
            report(result)
        }
        observers[uuid] = internalReport
        return ObserverReportWrapper(report: internalReport)
    }
}

// MARK: - Data Reporting
public extension QuickObserver {
    public func report(_ item: Item) {
        report(.success(item))
    }
    public func report(error: Error) {
        report(.error(error))
    }
    public func fowardError<T>(_ result: Result<T>) {
        guard let error = result.error else { return }
        report(.error(error))
    }
}
extension QuickObserver {
    func report(_ item: Result<Item>) {
        observers.forEach { (_, report) in
            report(item)
        }
    }
}
