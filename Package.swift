// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "shakespearemon-sdk",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "shakespearemon-sdk",
            targets: ["ShakespearemonSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/immobiliare/RealHTTP.git", exact: "1.9.0"),
        .package(url: "https://github.com/kean/Nuke.git", exact: "12.8.0")
    ],
    targets: [
        .target(
            name: "ShakespearemonSDK",
            dependencies: [
                .product(name: "RealHTTP", package: "RealHTTP"),
                .product(name: "NukeUI", package: "Nuke")
            ]),
        .testTarget(
            name: "ShakespearemonSDKTests",
            dependencies: ["ShakespearemonSDK"],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
