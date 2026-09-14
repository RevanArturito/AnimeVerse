// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Common",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Common", targets: ["Common"])
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.10.0")
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: ["Kingfisher"],
            resources: [.process("Resources")]   
        )
    ]
)
