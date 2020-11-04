//
//  Created by Timothy Rascher on 3/26/19.
//  Copyright © 2019 California State Lottery. All rights reserved.
//

import Foundation

public typealias ActionResultHandler<Action, ActionError: Error> = (Result<Action, ActionError>) -> Void
public typealias ActionResultObserverHandler<Observer: AnyObject, Action, ActionError: Error> =
    (Observer, Result<Action, ActionError>) -> Void
private let ObserverRemovalQueue =  DispatchQueue(label: "QuickObserver.ObserverRemovalQueue", qos: .background, attributes: .concurrent)

public protocol ActionObserver: AnyObject {
    associatedtype Action
    associatedtype ActionError: Error

    var observers: [UUID: ActionResultHandler<Action, ActionError> ] { get set }
}

public extension ActionObserver {
    func add<Observer: AnyObject>(_ observer: Observer,
                                  handler: @escaping ActionResultObserverHandler<Observer, Action, ActionError>) {
        let identifier = UUID()
        observers[identifier] = { [weak observer, weak self] (result) in
            guard let observer = observer else {
                ObserverRemovalQueue.async {
                    if let self = self, self.observers.keys.contains(identifier) == true {
                        self.observers.removeValue(forKey: identifier)
                    }
                }
                return
            }
            handler(observer, result)
        }
    }
    func add(handler: @escaping ActionResultHandler<Action, ActionError>) {
        let identifier = UUID()
        observers[identifier] = { [weak self] (result) in
            self?.observers.removeValue(forKey: identifier)
            handler(result)
        }
    }
    func report(_ action: Action) {
        let result: Result<Action, ActionError> = Result.success(action)
        let observers = self.observers
        for identifier in observers.keys {
            observers[identifier]?(result)
        }
    }
    func report(error: ActionError) {
        let result: Result<Action, ActionError> = Result.failure(error)
        let observers = self.observers
        for identifier in observers.keys {
            observers[identifier]?(result)
        }
    }
}
public typealias QuickAction<Action> = QuickObserver<Action, QuickActionErrors>

public class QuickObserver<Action, ActionError: Error>: ActionObserver {
    public var observers = [UUID: (Result<Action, ActionError>) -> Void]()
    public init() {}
}
