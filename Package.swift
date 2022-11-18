// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONObject",
    platforms: [
        .macOS(.v13), .iOS(.v16), .watchOS(.v8), .tvOS(.v16)
    ],
    products: [
        .library(
            name: "JSONObject",
            targets: ["JSONObject"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "JSONObject",
            dependencies: []),
        .testTarget(
            name: "JSONObjectTests",
            dependencies: ["JSONObject"]),
    ],
    swiftLanguageVersions: [.v5]
)
