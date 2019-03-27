# QuickObserver 2.0
A quick way to enable observable behavior on any object.

## Why Should I Use This?
If you are looking for a way to decouple the logic of your app from the front end, this is a good way to help. It allows for classes to be lightly coupled and for information to quickly pass in both directions. Either from the View Controller up to the Logic Controller, or for the Logic Controller back down to the View Controller. This also easily allows for multiple related view controllers to use the same logic controller.

## Usage
Using the observer is easy, the following is an example observable object.
```swift
import QuickObserver

class Controller: QuickObservable {
    var observer = QuickObserver<Actions, Errors>()
    enum Actions {
        case action
    }
    enum Errors: Error {
        case error
    }
}
```
The above class Controller can now be observed, and issue the actions or errors described in the class.

### Reporting A Change
Any time you need to alert observing objects that something has changed you can simply call `report(action: Actions)` on the `observer` like in the following example.
```swift
extension Controller {
    func performAnAction() {
        // Some Logic
        observer.report(.action)
    }
}
```
Once `observer.report(.action)` is called it'll alert every observer that it needs to act on the change.

### Adding An Observer
There are two types of observer. A repeat observer that will get updates until the observable object no longer exists, or it no longer exists. The second type is a one-off observer that gets an update and is then removed from future updates. Below are examples of each using the above `Controller` class.

#### Repeat Observer
Below is a view controller that can continue to receive updates from the `Controller` object. In the closure passed to the observable object, you see it returns a reference to the passes in observer. In this case that's the View Controller itself. The `this` variable allows you to access the ViewController without having to worry about retaining the reference.
```swift
import UIKit

class ViewController: UIViewController {
    var controller = Controller()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.add(self) { (this, result) in
            switch result {
            case .success(let action): this.handle(action)
            case .failure(let error): this.handle(error)
            }
        }
    }
    func handle(_ action: Controller.Actions) {
        switch action {
        case .action: break // Do Some Work Here
        }
    }
    func handle(_ error: Controller.Errors) {
        switch error {
        case .error: break // Handle Error Here
        }
    }
}
```

#### Single Observer
Below is a view controller that can continue to receive a single update from the `Controller` object. In this case once the closure is called it is released and never called again.
```swift
class ViewController: UIViewController {
    var controller = Controller()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.add { [weak self] (result) in
            switch result {
            case .success(let action): self?.handle(action)
            case .failure(let error): self?.handle(error)
            }
        }
    }
    func handle(_ action: Controller.Actions) {
        switch action {
        case .action: break // Do Some Work Here
        }
    }
    func handle(_ error: Controller.Errors) {
        switch error {
        case .error: break // Handle Error Here
        }
    }
}
```

## Installation
### Cocoapods
If you already have a podfile, simply add `pod 'QuickObserver', '~> 2.0.0'` to it and run pod install.

If you haven't set up cocoapods in your project and need help, refer to [Using Pods](https://guides.cocoapods.org/using/using-cocoapods). Make sure to add `pod 'QuickObserver', '~> 2.0.0'` to your newly created pod file.

### Manual
To manually install the files, simply copy everything from the QuickObserver directory into your project. 
