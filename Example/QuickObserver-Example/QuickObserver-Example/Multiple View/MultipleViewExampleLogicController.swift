//
//  MultipleViewLogicController.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import Foundation
import QuickObserver

class MultipleViewExampleLogicController {
    // MARK: - Properties
    var observers = [UUID: Report]()
    var topClicks = 0
    var bottomClicks = 0
    var id = UUID()
}

// MARK: - Commands
extension MultipleViewExampleLogicController {
    enum Command {
        case updateTopViewAppending(String)
        case updateBottomViewReplacingWith(String)
        case newlyAdded(String)
    }
    enum Button {
        case top
        case bottom
    }
    func report(button: Button) {
        switch button {
        case .bottom:
            bottomClicks += 1
            report(.updateTopViewAppending("Bottom Clicked \(bottomClicks) time(s)"))
        case .top:
            topClicks += 1
            report(.updateBottomViewReplacingWith("Top Clicked \(topClicks) time(s)"))
        }
    }
}

// MARK: - Quick Observer
extension MultipleViewExampleLogicController: QuickObserver {
    typealias Item = Command
}

// MARK: - Repeat Observable
extension MultipleViewExampleLogicController: RepeatObservable {
    func update(_ report: (Result<Item>) -> Void) {
        report(.success(.newlyAdded("Controller Was Added!")))
    }
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
