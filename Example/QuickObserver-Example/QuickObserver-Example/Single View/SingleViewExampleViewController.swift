//
//  SingleViewExampleViewController.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import UIKit

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
    func handle(_ action: SingleViewExampleLogicController.Actions) {
        switch action {
        case .updateLabel(let value): display.text = value
        }
    }
    func handle(_ error: SingleViewExampleLogicController.ActionErrors) {
        print("🔴 \(error)")
    }
}

// MARK: - Monitor
extension SingleViewExampleViewController {
    func monitor() {
        logicController.add(self) { (this, result) in
            switch result {
            case .success(let action): this.handle(action)
            case .failure(let error): this.handle(error)
            }
        }
    }
}
