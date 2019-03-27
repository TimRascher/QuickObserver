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
        logicController.bottomButtonPressed()
    }
}

// MARK: - View Life Cycle
extension MultipleViewExampleBottomViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorController()
        id.text = logicController.identifier.uuidString
    }
}

// MARK: - Logic Monitor
extension MultipleViewExampleBottomViewController {
    func monitorController() {
        logicController.add(self) { (this, result) in
            switch result {
            case .success(let action): this.handle(action)
            case .failure(let error): this.handle(error)
            }
        }
    }
    func handle(_ action: MultipleViewExampleLogicActions) {
        switch action {
        case .bottomButtonPressed(let times): display?.text = "\(times)"
        case .topButtonPressed: break
        }
    }
    func handle(_ error: MultipleViewExampleLogicActionError) {
        print("🔴 Bottom View Error: \(error)")
    }
}
