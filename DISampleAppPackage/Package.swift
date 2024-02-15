// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DISampleAppPackage",
    defaultLocalization: "ja",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "Production", targets: ["ProductionApp"]),
        .library(name: "Develop", targets: ["DevelopApp"]),
        .library(name: "UICatalog", targets: ["UICatalogApp"]),
    ],
    targets: [
        // App layer
        .target(
            name: "ProductionApp",
            dependencies: [],
            path: "./Sources/AppLayer/Production"
        ),
        .target(
            name: "DevelopApp",
            dependencies: [],
            path: "./Sources/AppLayer/Develop"
        ),
        .target(
            name: "UICatalogApp",
            dependencies: [],
            path: "./Sources/AppLayer/UICatalog"
        ),
    ]
)
