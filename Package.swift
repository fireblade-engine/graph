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
        .package(url: "https://github.com/davecom/SwiftGraph.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "FirebladeGraph",
            dependencies: ["GraphViz", "SwiftGraph"]),
        .testTarget(
            name: "FirebladeGraphTests",
            dependencies: ["FirebladeGraph"]),
    ]
)
