# Fireblade Graph

<!--[![Build Status](<#TODO#>)](<#TODO#>)-->
[![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)
[![swift version](https://img.shields.io/badge/swift-5.0-brightgreen.svg)](#)
[![platforms](https://img.shields.io/badge/platforms-%20macOS%20|%20iOS%20|%20tvOS%20|%20watchOS%20|%20linux%20-brightgreen.svg)](#)

This is a **lightweight**, **fast** and **easy to use** directed acyclic node graph implementation in Swift.    
It is developed and maintained as part of the [Fireblade Game Engine](https://github.com/fireblade-engine) project.

## 🚀 Getting Started

These instructions will get you a copy of the project up and running on your local machine and provide a code example.

### 📋 Prerequisites

* [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager)
* [Swiftlint](https://github.com/realm/SwiftLint) for linting - (optional)
* [SwiftEnv](https://swiftenv.fuller.li/) for Swift version management - (optional)

### 💻 Installing

Fireblade Graph is available for all platforms that support [Swift 5.0](https://swift.org/) and higher and the [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager).

Extend the following lines in your `Package.swift` file or use it to create a new project.

```swift
// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "YourPackageName",
    dependencies: [
    .package(url: "https://gitlab.com/fireblade/graph.git", from: "1.0.2")
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: ["FirebladeGraph"])
    ]
)

```

## 📝 Code Example

The `Node` is the core element of the package.   
It is representing a node in a [directed acyclic graph (DAG)](https://en.wikipedia.org/wiki/Directed_acyclic_graph)  and holds a (weak) reference to it's parent node and references to it's child nodes.

To create a graph create a node and add children.

```swift
let rootNode = Node()

let child1 = Node()
let child2 = Node()

rootNode.addChild(child1)
rootNode.addChild(child2)

```

A DAG implementation starts to shine when you can add functionality or behavior to it's nodes.
This is acchieved by subclassing `Node` and implementing the desired behavior in it's `.updateFromParent()` method.

```swift
class MyNode: Node {

	let name: String // you may add properties
	
	func myFunc() { ... } // or functions

    override open func updateFromParent() {
        super.updateFromParent()
    
        // ... and do fancy stuff here ...
    }
}

```

To traverse through the graph from root to leave nodes call `.update()` on the root node of the graph.

```swift
let rootNode = Node()

// ... build up your graph here ...

rootNode.update()

```


## 🏷️ Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](tags). 

## ✍️ Authors

* [Christian Treffs](https://github.com/ctreffs)

See also the list of [contributors](<#TODO#>) who participated in this project.

## 🔏 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
