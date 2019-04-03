//
//  Created by Timothy Rascher on 4/3/19.
//  Copyright © 2019 California State Lottery. All rights reserved.
//

import Foundation

private let kFatalErrorMessage =
"Actionable requires no errors to be passed out. If a error should be passed use Observable."

public typealias QuickActionable = QuickRepeatActionable & QuickSingleActionable

public protocol QuickRepeatActionable {
    associatedtype Action

    var observer: QuickAction<Action> { get }
    func afterRepeatAdd()
}

public extension QuickRepeatActionable {
    func add<Observer: AnyObject>(_ observer: Observer,
                                  handler: @escaping (Observer, Action) -> Void) {
        self.observer.add(observer) { (observer, result) in
            guard case let Result.success(action) = result else { fatalError(kFatalErrorMessage) }
            handler(observer, action)
        }
        afterRepeatAdd()
    }
    func afterRepeatAdd() {}
}

public protocol QuickSingleActionable {
    associatedtype Action

    var observer: QuickAction<Action> { get }
    func afterSingleAdd()
}

public extension QuickSingleActionable {
    func add(handler: @escaping (Action) -> Void) {
        self.observer.add { (result) in
            guard case let Result.success(action) = result else { fatalError(kFatalErrorMessage) }
            handler(action)
        }
        afterSingleAdd()
    }
    func afterSingleAdd() {}
}
