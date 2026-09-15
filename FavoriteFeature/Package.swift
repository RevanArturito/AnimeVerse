// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "FavoriteFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "FavoriteFeature", targets: ["FavoriteFeature"])
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Common", path: "../Common"),
        .package(path: "../DetailFeature"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0")
    ],
    targets: [
        .target(
            name: "FavoriteFeature",
            dependencies: ["Core", "Common", "Swinject", "DetailFeature"]
        )
    ]
)
