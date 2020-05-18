// Created by Timothy Rascher
//  Copyright © 2020 CA Lottery. All rights reserved.

import Foundation
import QuickObserver

enum PipelineActions {
    case random(Int)
}

class RandomNumber {
    let observer = QuickObserver<PipelineActions, Error>()
}
extension RandomNumber: QuickInputDownstreamable {
    func run(_ input: ClosedRange<Int>) {
        let number = Int.random(in: input)
        observer.report(.random(number))
    }
    func cancel() { }
}

class NumberPump<UpStream: QuickInputDownstreamable> where UpStream.Action == PipelineActions, UpStream.ActionError == Error, UpStream.Input == ClosedRange<Int> {
    var upStream: UpStream?
    let observer = QuickObserver<PipelineActions, Error>()
    private var looping = false
    
    init() {}
    init(_ upStream: UpStream) {
        self.upStream = upStream
        monitorUpStream()
    }
}
extension NumberPump: QuickUpstreamObservable, QuickDownstreamable {
    func run() {
        if !looping {
            looping = true
            doIt()
        }
    }
    func cancel() {
        looping = false
    }
    private func doIt() { upStream?.run(1...6) }
    func upStream(action: PipelineActions) {
        observer.report(action)
        if looping == true { doIt() }
    }
}

class NumberPrinter<UpStream: QuickDownstreamable>: QuickUpstreamObservable where UpStream.Action == PipelineActions, UpStream.ActionError == Error {
    var upStream: UpStream?
    var count = 0
    var sum = 0
    
    init() {}
    required init(_ upStream: UpStream) {
        self.upStream = upStream
        monitorUpStream()
        upStream.run()
    }
    
    func upStream(action: PipelineActions) {
        switch action {
        case .random(let number):
            count += 1
            sum += number
            print("New Number: \(number), Sum: \(sum), Count: \(count), Average: \(Double(sum) / Double(count))")
            if sum >= 10000 { upStream?.cancel() }
        }
    }
    func upStream(error: Error) {}
}

class NumberRunner {
    let printer: Any
    
    init() {
        printer = NumberPrinter(NumberPump(RandomNumber()))
    }
}
