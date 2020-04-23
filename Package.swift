// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuickObserver",
    products: [
        .library(
            name: "QuickObserver",
            targets: ["QuickObserver"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "QuickObserver",
            dependencies: []),
    ]
)
