//
//  SingleViewLogicController.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import Foundation
import QuickObserver

class SingleViewExampleLogicController {
    // MARK: - Properties
    var observers = [UUID: Report]()
}

// MARK: - Commands
extension SingleViewExampleLogicController {
    enum Command {
        case updateLabel(String)
    }
    func report(newText: String) {
        let text = "-=@ \(newText) @=-"
        report(.updateLabel(text))
    }
}

// MARK: - Quick Observer && Repeat Observable
extension SingleViewExampleLogicController: QuickObserver, RepeatObservable {
    typealias Item = Command
}
