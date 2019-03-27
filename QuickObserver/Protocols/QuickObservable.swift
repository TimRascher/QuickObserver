//
//  Created by Timothy Rascher on 3/26/19.
//  Copyright © 2019 California State Lottery. All rights reserved.
//

import Foundation

public typealias QuickObservable = QuickRepeatObservable & QuickSingleObservable

public protocol QuickRepeatObservable {
    associatedtype Action
    associatedtype ActionError: Error

    var observer: QuickObserver<Action, ActionError> { get }
}

public extension QuickRepeatObservable {
    func add<Observer: AnyObject>(_ observer: Observer,
                                  handler: @escaping ActionResultObserverHandler<Observer, Action, ActionError>) {
        self.observer.add(observer, handler: handler)
    }
}

public protocol QuickSingleObservable {
    associatedtype Action
    associatedtype ActionError: Error

    var observer: QuickObserver<Action, ActionError> { get }
}

public extension QuickSingleObservable {
    func add(handler: @escaping ActionResultHandler<Action, ActionError>) {
        self.observer.add(handler: handler)
    }
}
