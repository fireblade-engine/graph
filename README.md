# Fireblade Graph

[![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)

This is a **lightweight**, **fast** and **easy to use** [directed acyclic graph (DAG)](https://en.wikipedia.org/wiki/Directed_acyclic_graph) implementation in Swift.    
It is developed and maintained as part of the [Fireblade Game Engine](https://github.com/fireblade-engine) project.

## 🚀 Getting Started

These instructions will get you a copy of the project up and running on your local machine and provide a code example.

### 📋 Prerequisites

* [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager)
* [Swiftlint](https://github.com/realm/SwiftLint) for linting - (optional)
* [SwiftEnv](https://swiftenv.fuller.li/) for Swift version management - (optional)

### 💻 Installing

Fireblade Graph is available for all platforms that support [Swift 5](https://swift.org/) and higher and the [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager).

Extend the following lines in your `Package.swift` file or use it to create a new project.

```swift
// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "YourPackageName",
    dependencies: [
    .package(url: "https://github.com/fireblade-engine/graph.git", from: "1.3.0")
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
It is representing a node in a [directed acyclic graph (DAG)](https://en.wikipedia.org/wiki/Directed_acyclic_graph)  and holds a (weak) reference to its parent node and references to its child nodes.

To create a graph create a node and add children.

```swift
let rootNode = Node<Void>()

let child1 = Node<Void>()
let child2 = Node<Void>()

rootNode.addChild(child1)
rootNode.addChild(child2)

```

A DAG implementation starts to shine when you can add functionality or behavior to its nodes.   
This is acchieved by subclassing `Node` and implementing the desired behavior in its `.updateFromParent()` method as well as setting the node's generic `Content` constraint.

```swift
class StringNode: Node<String> {

	let content: String
	
	func myFunc() { ... } // or functions

    override open func updateFromParent() {
        super.updateFromParent()
    
        // ... and do fancy stuff here ...
    }
}

let node = StringNode("Hello World!")

```

To traverse through the graph from root to leave nodes call `.update()` on the root node of the graph.

```swift
let rootNode = Node<Void>()

// ... build up your graph here ...

rootNode.update()

```


## 🏷️ Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the tags on this repository. 

## ✍️ Authors

* [Christian Treffs](https://github.com/ctreffs)

See also the list of [contributors](graphs/contributors) who participated in this project.

## 🔏 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
