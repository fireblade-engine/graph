// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "FirebladeGraph",
    products: [
        .library(
            name: "FirebladeGraph",
            targets: ["FirebladeGraph"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ctreffs/GraphViz.git", .branch("master")),
        .package(url: "https://github.com/davecom/SwiftGraph.git", from: "3.0.0"),
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.7.2")
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
