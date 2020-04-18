// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v10_11)],
    dependencies: [
        .package(
            url: "https://github.com/realm/SwiftLint",
            from: "0.39.1"
        ),
        .package(
            url: "https://github.com/nicklockwood/SwiftFormat",
            from: "0.44.4"
        ),
    ],
    targets: [
        .target(
            name: "BuildTools",
            dependencies: []),
    ]
)
