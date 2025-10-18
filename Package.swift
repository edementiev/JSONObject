// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONObject",
    platforms: [
        .macOS(.v12), .iOS(.v15), .watchOS(.v7), .tvOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "JSONObject",
            targets: ["JSONObject"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "JSONObject",
            dependencies: []),
        .testTarget(
            name: "JSONObjectTests",
            dependencies: ["JSONObject"]
        ),
    ],
    swiftLanguageVersions: [.v5, .version("6")]
)
