//
//  MultipleViewLogicControllable.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import UIKit

protocol MultipleViewExampleLogicControllable: AnyObject {
    var logicController: MultipleViewExampleLogicController { get }
    var display: UITextView? { get }
    
    func run(_ command: MultipleViewExampleLogicController.Command)
}

// MARK: - Monitor
extension MultipleViewExampleLogicControllable where Self: UIViewController {
    func monitor() {
        logicController.add(observer: self) { (viewController, result) in
            guard let command = result.item else { fatalError() }
            viewController.run(command)
        }
    }
}
