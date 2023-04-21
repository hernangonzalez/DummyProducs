// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Models", targets: ["Models"]),
        .library(name: "Core", targets: ["Core"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Models"),
        .target(name: "Utils", dependencies: ["Models"]),
        .target(name: "Core", dependencies: ["Models", "Utils"]),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
    ]
)
