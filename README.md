# QuickObserver
A quick way to enable observable behavior on any object.

## Installation
### Cocoapods
Coming Soon
### Manual
To manually install the files, simply copy everything from the QuickObserver directory into your project.

## Usage
The two major parts of this library are the QuickObserver protocol, and the Observable protocols.
### QuickObserver
The QuickObserver protocol is the heavy lifter. It is responsible for keeping track of the all the observation objects and alerting them when something is reported.

To make a class Observable, all you have to do is conform it to the QuickObserver protocol, and make sure it has a property called observers that's a dictionary with a UUID key and a closure for a value. A convince type alias called Report that is included to make using the closure easier.

```swift
import QuickObserver

class ExampleObserver: QuickObserver {
  typealias Item = YourReturnType
  var observers = [UUID: Report]()
}
```
Setting the type alias Item to your return type allows you to take advantage of the Report type alias to make your code a little cleaner. The Report type alias is equal to `(Result<YourReturnType>) -> Void`.

You can now add items to your observer using the `set` functions.
```swift
import UIKit

class ExampleViewController: UIViewController {
  var observer = ExampleObserver()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Repeat Observer: Continue to get updates for the entire existence of the object.
    observer.set(observer: self, report: { (exampleViewController, result) in
      // Result Handling Code Goes Here!
    })
    // Single Time Observer: Get one update and then get dropped by the observer object.
    observer.set { (result) in
      // Result Handling Code Goes Here!
    }
  }
}
```
When you set an object to an observer, you can choose to have it continue to get updates for the life of the object, or just one time. When you do life of the object, you pass in the object whose life time you wish to use. When the closure is called it passes the object back in with the result. If the object is destroyed, but the observer continues on, it doesn't maintain a strong reference to the object, so no retain cycle is formed.

#### Reporting Values
When you want to alert all the objects that have subscribed to your observer, you can use the `report` function.

### Observable

If you don't need to add special functionality to the observer. Or you wish to have a base observer with many different interpreters but wish to simply pass the `set` functions forward. You can use the Observable, OneTimeObservable, and RepeatObservable protocols.

These protocols allow you to create a wrapper around a QuickObserver using the AnyObserver protocol. This is desirable because you can use this wrapper class to hold values and use these values to instantly update newly added objects to the observer using the `update` function.

Note that a QuickObserver has the `set` function while Observable protocols have the `add` function. This is to help eliminate ambiguity for the compiler. The functions are not exactly the same, but very similar.

```swift
import QuickObserver

class ExampleLogicController: Observable {
  var observer = AnyObserver(ExampleObserver())
  var value: YourReturnType?

  func update(_ report: (Result<YourReturnType>) -> Void) {
    guard let value = value else { return }
    report(.success(value))
  }
}
```

When a new object is added, the update function is called, and the proper closure is passed in. If the Observable object has a value, it instantly reports it to the new observer and only the new observer to allow it to catch up to everything else.

#### Differences between Observable Protocols
 - RepeatObservable exposes just the repeat `add` function that requires passing in the object to continually keep it up to day. This is the protocol you’ll use the most.
 - OneTimeObservable exposes just the `add` function that does not require passing in the object and will only report to the object once. Less useful then the Repeat Observable, but you may need it when you only care about getting a single value for a short lived or static object.
 - Observable exposes both of the functions of the RepeatObservable and the OneTimeObservable protocols.
