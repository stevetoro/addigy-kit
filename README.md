# AddigyKit

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

## What is this?

AddigyKit is a Swift wrapper for [Addigy's public API](https://addigy.com/) that enables you to interact with your Addigy-managed devices. 

All code is written in Swift and uses Apple's Combine framework. No third-party frameworks are used in this package.

## Requirements

OSX 10.15+, iOS 13+, tvOS 13.0+, watchOS 6.0+

## Usage

Instantiate the `Addigy` class with your Addigy API keys then call functions that interact with Addigy resources.

```swift
let client = Addigy(clientId: "YOUR-CLIENT-ID", clientSecret: "YOUR-CLIENT-SECRET")
```

### Response

Use Combine subscribers to handle responses.

```swift
let subscription = client.getDevices()
    .sink(
        receiveCompletion: { _ in },
        receiveValue: { devices in
        // do something with your devices
        }
    )
```

## Installation

### Swift Package Manager

Add as a Swift package dependency within your Xcode project: File > Swift Packages > Add Package Dependency.

```
https://github.com/stevetoro/addigy-kit
```

## Author

Steve Toro, steve.toro@gmail.com
