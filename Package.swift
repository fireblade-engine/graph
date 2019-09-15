// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FirebladeGraph",
    products: [
        .library(
            name: "FirebladeGraph",
            targets: ["FirebladeGraph"]),
    ],
    dependencies: [
        .package(url: "https://github.com/fireblade-engine/uuid.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "FirebladeGraph",
            dependencies: ["FirebladeUUID"]),
        .testTarget(
            name: "FirebladeGraphTests",
            dependencies: ["FirebladeGraph"]),
    ]
)
