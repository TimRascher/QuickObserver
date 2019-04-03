//
//  SingleViewExampleViewController.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import UIKit
import QuickObserver

class SingleViewExampleViewController: UIViewController {
    // MARK: - Properties
    var logicController = SingleViewExampleLogicController()
    
    // MARK: - Outlets
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var input: UITextField!
}

// MARK: - View Life Cycle
extension SingleViewExampleViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor()
        bindDisplay()
    }
    func bindDisplay() {
        logicController.boundText.bind(target: \String.self, to: display, \UILabel.text) { (value) -> String? in
            guard let value = value else { return nil }
            return "-=@ \(value) @=-"
        }
    }
}

// MARK: - Actions
extension SingleViewExampleViewController {
    @IBAction func tapped(_ button: UIButton) {
        guard let text = input.text else { return }
        logicController.report(newText: text)
    }
}

// MARK: - Command Interpreter
extension SingleViewExampleViewController {
    func handle(_ error: Error) {
        print("🔴 \(error)")
    }
}

// MARK: - Monitor
extension SingleViewExampleViewController {
    func monitor() {
        logicController.add(self) { (this, action) in
            print("Action Updated: \(action)")
        }
    }
}
