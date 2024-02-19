// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum SourcesPath {
    static let domainLayer = "./Sources/Domain/"
    static let presentationLayer = "./Sources/Presentation/"
    static let frameworkLayer = "./Sources/Framework/"
    static let diLayer = "./Sources/DI/"
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
        .library(name: "DISampleApp", targets: ["DISampleAppRootPresentation", "DomainLayer", "DILayer"]),
        .library(name: "NonFrameworkDISampleApp", targets: ["DISampleAppRootPresentation", "DomainLayer"]),
        .library(name: "UICatalogApp", targets: ["UICatalogAppRootPresentation", "DomainLayer"]),
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
        // Domain layer
        .target(
            name: "DomainLayer",
            dependencies: [],
            path: SourcesPath.domainLayer
        ),

        // App Presentation layer
        .target(
            name: "DISampleAppRootPresentation",
            dependencies: [
                .domainLayer,
                .licensePresentation,
            ],
            path: SourcesPath.presentationLayer + "DISampleAppRoot"
        ),
        .target(
            name: "UICatalogAppRootPresentation",
            dependencies: [
                .playbook,
                .playbookUI,
            ],
            path: SourcesPath.presentationLayer + "UICatalogAppRoot"
        ),
        
        // Presentation layer
        .target(
            name: "LicensePresentation",
            dependencies: [
                .domainLayer,
            ],
            path: SourcesPath.presentationLayer + "License"
        ),

        // Framework layer
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

        // DI Layer
        .target(
            name: "DILayer",
            dependencies: [
                .domainLayer,
                .licenseFramework,
                .loggerFramework
            ],
            path: SourcesPath.diLayer
        ),
        
    ]
)
