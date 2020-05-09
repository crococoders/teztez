// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServerModels",
    products: [
        .library(
            name: "ServerModels",
            targets: ["ServerModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
    ],
    targets: [
        .target(
            name: "ServerModels",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ],
            path: "Sources/"
        )
    ]
)
