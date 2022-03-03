# NWReachability
[NWReachability]() is a pure Swift library for monitoring the network connection of iOS devices using Apple's [Network](https://developer.apple.com/documentation/network) framework.

---

* Latest release: [version 1.1.1](https://github.com/aresxin/NWReachability/releases/tag/v1.1.1) <br>

* Requirements: iOS 13.0~ / Swift 5.0~ <br>

* Combine Support 

## Installation

### CocoaPods
[CocoaPods][] is a dependency manager for Cocoa projects. To install NWReachability with CocoaPods:

 1. Make sure CocoaPods is [installed][CocoaPods Installation].

 2. Update your Podfile to include the following:

    ``` ruby
    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '13.0'
    use_frameworks!

    target 'YourApp' do
    # your other pod
    # ...
    pod 'NWReachability', '~> 1.1.0'
    end
    ```

 3. Run `pod install`.

[CocoaPods]: https://cocoapods.org
[CocoaPods Installation]: https://guides.cocoapods.org/using/getting-started.html#getting-started
 
 4. In your code import NWReachability like so: <br>
   `import NWReachability` <br>
   `import Combine` <br>

#### Swift Package Manager
- File > Swift Packages > Add Package Dependency
- Add `https://github.com/aresxin/NWReachability.git`
- Select "Up to Next Major" with "1.1.1"


## Usage
### Example - notifications
NOTE: All notifications are delivered on the **main queue**.

```swift
let token = NWReachability.default.addObserver { [weak self] connectivity in
 print("connectivity isConnected \(connectivity.isConnected)")
 print("connectivity isExpensive \(connectivity.isExpensive)")
 switch connectivity.status {
 case .reachable(.cellular):
   print("cellular")
 case .notReachable:
   print("notReachable")
 case .reachable(.ethernetOrWiFi):
   print("ethernetOrWiFi")
case .unknown:
   print("unknown")
}
}
NWReachability.default.startMonitoring()
```

and for stopping notifications

```swift
NWReachability.default.stopMonitoring()
NotificationCenter.default.removeObserver(token as Any)
```

### Example - Combine
```swift
NWReachability.default.publisher.sink {  [weak self] connectivity in
  print("connectivity isConnected \(connectivity.isConnected)")
  print("connectivity isExpensive \(connectivity.isExpensive)")
  switch connectivity.status {
  case .reachable(.cellular):
    print("cellular")
  case .notReachable:
    print("notReachable")
  case .reachable(.ethernetOrWiFi):
    print("ethernetOrWiFi")
  case .unknown:
    print("unknown")
  }          
}.store(in: &cancellables)
NWReachability.default.startMonitoring()
```
and for stopping 

```swift
NWReachability.default.stopMonitoring()
cancellables.removeAll()
```
