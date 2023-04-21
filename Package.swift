// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FirebladeGraph",
    platforms: [
        .macOS(.v11),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "FirebladeGraph",
            targets: ["FirebladeGraph"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftDocOrg/GraphViz.git", from: "0.4.1"),
        .package(url: "https://github.com/davecom/SwiftGraph.git", from: "3.1.0"),
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.11.0")
    ],
    targets: [
        .target(
            name: "FirebladeGraph",
            dependencies: ["GraphViz", "SwiftGraph"]),
        .testTarget(
            name: "FirebladeGraphTests",
            dependencies: ["FirebladeGraph", "SnapshotTesting"]),
    ]
)
