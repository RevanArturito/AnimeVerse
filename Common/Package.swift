// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Common",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Common", targets: ["Common"])],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(url: "https://github.com/onevcat/Kingfisher.git",exact: "8.12.0")],
    targets: [
        .target(
            name: "Common",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
