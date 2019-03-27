//
//  MultipleViewLogicControllable.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import UIKit
import QuickObserver

enum MultipleViewExampleLogicActions {
    case topButtonPressed(Int)
    case bottomButtonPressed(Int)
}
enum MultipleViewExampleLogicActionError: Error {
    case unknownError
}

protocol MultipleViewExampleLogicControllable: AnyObject, QuickObservable
where Self.Action == MultipleViewExampleLogicActions, Self.ActionError == MultipleViewExampleLogicActionError {
    var topClicks: Int { get set }
    var bottomClicks: Int { get set }
    var identifier: UUID { get }
}

// MARK: - Actions
extension MultipleViewExampleLogicControllable {
    func topButtonPressed() {
        topClicks += 1
        observer.report(.topButtonPressed(topClicks))
    }
    func bottomButtonPressed() {
        bottomClicks += 1
        observer.report(.bottomButtonPressed(bottomClicks))
    }
}

class MultipleViewExampleLogicController: MultipleViewExampleLogicControllable {
    var observer = QuickObserver<MultipleViewExampleLogicActions, MultipleViewExampleLogicActionError>()
    var topClicks = 0
    var bottomClicks = 0
    let identifier = UUID()
}

// MARK: - Weak Singleton
extension MultipleViewExampleLogicController {
    private static weak var _main: MultipleViewExampleLogicController?
    static var main: MultipleViewExampleLogicController {
        if let main = _main { return main }
        let main = MultipleViewExampleLogicController()
        _main = main
        return main
    }
}
