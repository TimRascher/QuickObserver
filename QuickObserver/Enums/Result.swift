//
//  Result.swift
//
//  Created by Timothy Rascher on 7/12/18.
//  Copyright © 2018 Timothy Rascher. All rights reserved.
//

import Foundation

public enum Result<Item> {
    case success(Item)
    case error(Error)

    public var item: Item? {
        guard case let Result.success(item) = self else { return nil }
        return item
    }
    public var error: Error? {
        guard case let Result.error(error) = self else { return nil }
        return error
    }
}

public extension Result where Item == Bool {
    var isSuccessful: Bool {
        guard let success = item else { return false }
        return success
    }
}
