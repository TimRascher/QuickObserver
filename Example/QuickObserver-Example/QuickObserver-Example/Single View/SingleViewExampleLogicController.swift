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


class Controller: QuickObservable {
    var observer = QuickObserver<Actions, Errors>()
    enum Actions {
        case action
    }
    enum Errors: Error {
        case error
    }
}

extension Controller {
    func performAnAction() {
        // Some Logic
        observer.report(.action)
    }
}

class ViewController: UIViewController {
    var controller = Controller()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.add { [weak self] (result) in
            switch result {
            case .success(let action): self?.handle(action)
            case .failure(let error): self?.handle(error)
            }
        }
    }
    func handle(_ action: Controller.Actions) {
        switch action {
        case .action: break // Do Some Work Here
        }
    }
    func handle(_ error: Controller.Errors) {
        switch error {
        case .error: break // Handle Error Here
        }
    }
}
