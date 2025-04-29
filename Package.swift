// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "shakespearemon-sdk",
    products: [
        .library(
            name: "shakespearemon-sdk",
            targets: ["ShakespearemonSDK"]),
    ],
    targets: [
        .target(
            name: "ShakespearemonSDK"),
        .testTarget(
            name: "ShakespearemonTests",
            dependencies: ["ShakespearemonSDK"]
        ),
    ]
)
