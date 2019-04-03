//
//  Created by Timothy Rascher on 4/3/19.
//  Copyright © 2019 California State Lottery. All rights reserved.
//

import Foundation

public class QuickBinder<Object> {
    private(set) public var object: Object?
    private let observer = QuickObserver<Object?, Errors>()

    public init() {}
    public init(_ object: Object?) {
        self.object = object
    }
}

public extension QuickBinder {
    func update(_ object: Object?) {
        self.object = object
        observer.report(object)
    }
    func bind<Observer: AnyObject, TargetValue, DestinationValue>(
        target: KeyPath<Object, TargetValue>,
        to obsevering: Observer,
        _ destination: ReferenceWritableKeyPath<Observer, DestinationValue?>,
        with transformer: @escaping (TargetValue?) -> DestinationValue?) {
        observer.add(obsevering) { (obsevering, result) in
            guard case let Result.success(object) = result else { assert(false); return }
            let value = object?[keyPath: target]
            let transformedValue = transformer(value)
            obsevering[keyPath: destination] = transformedValue
        }
        observer.report(object)
    }
    func bind<Observer: AnyObject, TargetValue, DestinationValue>(
        target: KeyPath<Object, TargetValue?>,
        to obsevering: Observer,
        _ destination: ReferenceWritableKeyPath<Observer, DestinationValue?>,
        with transformer: @escaping (TargetValue?) -> DestinationValue?) {
        observer.add(obsevering) { (obsevering, result) in
            guard case let Result.success(object) = result else { assert(false); return }
            let value = object?[keyPath: target]
            let transformedValue = transformer(value)
            obsevering[keyPath: destination] = transformedValue
        }
        observer.report(object)
    }
    func bind<Observer: AnyObject, Value>(
        target: KeyPath<Object, Value?>,
        to obsevering: Observer,
        _ destination: ReferenceWritableKeyPath<Observer, Value?>) {
        observer.add(obsevering) { (obsevering, result) in
            guard case let Result.success(object) = result else { assert(false); return }
            let value = object?[keyPath: target]
            obsevering[keyPath: destination] = value
        }
        observer.report(object)
    }
    func bind<Observer: AnyObject, Value>(
        target: KeyPath<Object, Value>,
        to obsevering: Observer,
        _ destination: ReferenceWritableKeyPath<Observer, Value?>) {
        observer.add(obsevering) { (obsevering, result) in
            guard case let Result.success(object) = result else { assert(false); return }
            let value = object?[keyPath: target]
            obsevering[keyPath: destination] = value
        }
        observer.report(object)
    }
}

public extension QuickBinder {
    enum Errors: LocalizedError {
        case unknownError
    }
}
