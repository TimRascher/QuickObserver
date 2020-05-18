// Created by Timothy Rascher
// Copyright © 2020 CA Lottery. All rights reserved.

import Foundation

public protocol QuickUpstreamObservable: AnyObject {
    associatedtype UpStream: QuickInputDownstreamable
    var upStream: UpStream? { get set }
    func upStream(action: UpStream.Action)
    func upStream(error: UpStream.ActionError)
}
public extension QuickUpstreamObservable {
    func monitorUpStream() {
        upStream?.add(self) { (this, result) in
            switch result {
            case .success(let action): this.upStream(action: action)
            case .failure(let error): this.upStream(error: error)
            }
        }
    }
}
public extension QuickUpstreamObservable where Self: QuickInputDownstreamable, UpStream.Action == Action, UpStream.ActionError == ActionError {
    func upStream(action: UpStream.Action) {
        observer.report(action)
    }
    func upStream(error: UpStream.ActionError) {
        observer.report(error: error)
    }
}
