// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FirebladeGraph",
    products: [
        .library(
            name: "FirebladeGraph",
            targets: ["FirebladeGraph"]),
    ],
    targets: [
        .target(
            name: "FirebladeGraph",
            dependencies: []),
        .testTarget(
            name: "FirebladeGraphTests",
            dependencies: ["FirebladeGraph"]),
    ]
)
