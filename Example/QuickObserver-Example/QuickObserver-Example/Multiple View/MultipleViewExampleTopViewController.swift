//
//  MultipleViewExampleTopViewController.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import UIKit

class MultipleViewExampleTopViewController: UIViewController {
    // MARK: - Properties
    var logicController = MultipleViewExampleLogicController.main
    
    // MARK: - Outlets
    @IBOutlet weak var display: UITextView?
    @IBOutlet weak var id: UILabel!
}

// MARK: - Actions
extension MultipleViewExampleTopViewController {
    @IBAction func tapped(_ button: UIButton) {
        logicController.report(button: .top)
    }
}

// MARK: - View Life Cycle
extension MultipleViewExampleTopViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor()
        id.text = logicController.id.uuidString
    }
}

// MARK: - Logic Controllable
extension MultipleViewExampleTopViewController: MultipleViewExampleLogicControllable {
    func run(_ command: MultipleViewExampleLogicController.Command) {
        switch command {
        case .updateTopViewAppending(let value), .newlyAdded(let value):
            guard let text = display?.text else { display?.text = "\(value)\r"; return }
            display?.text = "\(text)\(value)\r"
            display?.scrollToBottom()
        case .updateBottomViewReplacingWith: break
        }
    }
}

// MARK: - Text View Scroll To Bottom
extension UITextView {
    func scrollToBottom() {
        guard let length = text?.count, length > 0 else { return }
        let bottom = NSMakeRange(length, 0)
        scrollRangeToVisible(bottom)
        isScrollEnabled = false
        isScrollEnabled = true
    }
}
