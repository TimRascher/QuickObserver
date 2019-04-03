//
//  SingleViewLogicController.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import Foundation
import QuickObserver

class SingleViewExampleLogicController: QuickActionable {
    // MARK: - Properties
    var observer = QuickAction<Actions>()
    var boundText = QuickBinder<String>()
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
        let text = "\(newText): The \(newText)ing"
        observer.report(.updateLabel(text))
        boundText.update(text)
    }
}
