//
//  SingleViewLogicController.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import Foundation
import QuickObserver

class SingleViewExampleLogicController: QuickObservable {
    // MARK: - Properties
    var observer = QuickObserver<Actions, ActionErrors>()
}

// MARK: - Commands
extension SingleViewExampleLogicController {
    enum Actions {
        case updateLabel(String)
    }
    enum ActionErrors: Error {
        case unableToComply
    }
    func report(newText: String) {
        let text = "-=@ \(newText) @=-"
        observer.report(.updateLabel(text))
    }
}
