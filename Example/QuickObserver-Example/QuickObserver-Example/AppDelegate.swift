//
//  AppDelegate.swift
//  QuickObserver-Example
//
//  Created by Timothy Rascher on 9/13/18.
//  Copyright © 2018 CA Lottery. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var runner: NumberRunner?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {
            runner = NumberRunner()
            return true
    }
}
