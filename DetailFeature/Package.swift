// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "DetailFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DetailFeature", targets: ["DetailFeature"])
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Common", path: "../Common"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0")
    ],
    targets: [
        .target(
            name: "DetailFeature",
            dependencies: ["Core", "Common", "Swinject"]
        )
    ]
)
