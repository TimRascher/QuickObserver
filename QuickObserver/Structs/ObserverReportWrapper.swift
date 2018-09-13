//
//  ObserverReportWrapper.swift
//
//  Created by Timothy Rascher on 7/12/18.
//  Copyright © 2018 Timothy Rascher. All rights reserved.
//

import Foundation

public struct ObserverReportWrapper<Item> {
    typealias Report = (Result<Item>) -> Void

    let report: Report
}
