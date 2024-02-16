// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum SourcesPath {
    static let appLayer = "./Sources/App/"
    static let domainLayer = "./Sources/Domain/"
    static let presentationLayer = "./Sources/Presentation/"
    static let frameworkLayer = "./Sources/Framework/"
}

// Ref: 【Swift】Package.swiftのdependenciesをタイプセーフに扱う https://qiita.com/SNQ-2001/items/ed068414747e28999415
private extension PackageDescription.Target.Dependency {
    /// Third party SDK
    static let playbook: Self = .product(name: "Playbook", package: "playbook-ios")
    static let playbookUI: Self = .product(name: "PlaybookUI", package: "playbook-ios")

    // TODO: PlaybookSnapshot によるテスト
    // static let playbookSnapshot: Self = .product(name: "PlaybookSnapshot", package: "playbook-ios")
    
    /// DISample target
    static let domainLayer: Self = "DomainLayer"
    static let licensePresentation: Self = "LicensePresentation"
    static let loggerFramework: Self = "LoggerFramework"
    static let licenseFramework: Self = "LicenseFramework"
}

private extension PackageDescription.Target.PluginUsage {
    static let licensesPlugin: Self = .plugin(name: "LicensesPlugin", package: "LicensesPlugin")
}

let package = Package(
    name: "DISampleAppPackage",
    defaultLocalization: "ja",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // App
        .library(name: "Production", targets: ["ProductionApp"]),
        .library(name: "Develop", targets: ["DevelopApp"]),
        .library(name: "UICatalog", targets: ["UICatalogApp"]),
    ],
    dependencies: [
        // Library
        .package(url: "https://github.com/playbook-ui/playbook-ios.git", from: "0.3.5"),

        // Plugin
        .package(url: "https://github.com/maiyama18/LicensesPlugin", from: "0.1.6"),
        
        // CLI
        .package(url: "https://github.com/uber/mockolo", from: "2.0.1"),
    ],
    targets: [
        // App layer
        .target(
            name: "ProductionApp",
            dependencies: [],
            path: SourcesPath.appLayer + "Production"
        ),
        .target(
            name: "DevelopApp",
            dependencies: [
                .domainLayer,
                .licensePresentation,
                .loggerFramework,
                .licenseFramework,
            ],
            path: SourcesPath.appLayer + "Develop"
        ),
        .target(
            name: "UICatalogApp",
            dependencies: [
                .playbook,
                .playbookUI,
            ],
            path: SourcesPath.appLayer + "UICatalog"
        ),
        
        // Domain layer
        .target(
            name: "DomainLayer",
            dependencies: [],
            path: SourcesPath.domainLayer
        ),

        // Presentation layer
        .target(
            name: "CorePresentation",
            dependencies: [
                .domainLayer,
            ],
            path: SourcesPath.presentationLayer + "Core"
        ),
        .target(
            name: "LicensePresentation",
            dependencies: [
                .domainLayer,
                "LoggerFramework",
                "LicenseFramework",
            ],
            path: SourcesPath.presentationLayer + "License"
        ),

        // Framework layer
        .target(
            name: "CoreFramework",
            dependencies: [
                .domainLayer
            ],
            path: SourcesPath.frameworkLayer + "Core"
        ),
        .target(
            name: "LoggerFramework",
            dependencies: [
                .domainLayer
            ],
            path: SourcesPath.frameworkLayer + "Logger"
        ),
        .target(
            name: "LicenseFramework",
            dependencies: [
                .domainLayer
            ],
            path: SourcesPath.frameworkLayer + "License",
            plugins: [
                .licensesPlugin,
            ]
        ),
    ]
)
