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
        .package(url: "https://github.com/ctreffs/GraphViz.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "FirebladeGraph",
            dependencies: ["GraphViz"]),
        .testTarget(
            name: "FirebladeGraphTests",
            dependencies: ["FirebladeGraph"]),
    ]
)
