// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClientDependencies",
    platforms: [.macOS(.v10_11)],
    products: [
        .library(name: "ClientDependencies", targets: ["ClientDependencies"])
    ],
    dependencies: [
        .package(url: "https://github.com/HeroTransitions/Hero.git", from: "1.3.0"),
        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", from: "6.5.5"),
        .package(url: "https://github.com/mac-cain13/R.swift.Library", from: "5.1.0"),
        .package(url: "https://github.com/marcosgriselli/ViewAnimator", from: "2.7.0"),
        .package(path: "../Shared/Models")
    ],
    targets: [
        .target(
            name: "ClientDependencies",
            dependencies: [],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
