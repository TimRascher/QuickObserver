//
//  MultipleViewExampleBottomViewController.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import UIKit

class MultipleViewExampleBottomViewController: UIViewController {
    // MARK: - Properties
    var logicController = MultipleViewExampleLogicController.main
    
    // MARK: - Outlets
    @IBOutlet weak var display: UITextView?
    @IBOutlet weak var id: UILabel!
}

// MARK: - Actions
extension MultipleViewExampleBottomViewController {
    @IBAction func tapped(_ button: UIButton) {
        logicController.report(button: .bottom)
    }
}

// MARK: - View Life Cycle
extension MultipleViewExampleBottomViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor()
        id.text = logicController.id.uuidString
    }
}

// MARK: - Logic Controllable
extension MultipleViewExampleBottomViewController: MultipleViewExampleLogicControllable {
    func run(_ command: MultipleViewExampleLogicController.Command) {
        switch command {
        case .updateBottomViewReplacingWith(let value), .newlyAdded(let value): display?.text = value
        case .updateTopViewAppending: break
        }
    }
}
