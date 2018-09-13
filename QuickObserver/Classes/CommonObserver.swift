//
//  CommonObserver.swift
//
//  Created by Timothy Rascher on 7/12/18.
//  Copyright © 2018 Timothy Rascher. All rights reserved.
//

import Foundation

public class CommonObserver<Item>: QuickObserver {
    public var observers = [UUID: (Result<Item>) -> Void]()

    public init() {}
}
