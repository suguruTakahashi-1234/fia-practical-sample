// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum SourcesPath {
    static let domainLayer = "./Sources/Domain/"
    static let presentationLayer = "./Sources/Presentation/"
    static let frameworkLayer = "./Sources/Framework/"
    static let diLayer = "./Sources/DependencyInjector/"
}

// Ref: 【Swift】Package.swiftのdependenciesをタイプセーフに扱う https://qiita.com/SNQ-2001/items/ed068414747e28999415
private extension PackageDescription.Target.Dependency {
    /// Third party SDK
    static let firebaseAnalytics: Self = .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
    static let playbook: Self = .product(name: "Playbook", package: "playbook-ios")
    static let playbookUI: Self = .product(name: "PlaybookUI", package: "playbook-ios")

    // TODO: PlaybookSnapshot によるテスト
    // static let playbookSnapshot: Self = .product(name: "PlaybookSnapshot", package: "playbook-ios")
    
    /// DISample target
    static let domainLayer: Self = "DomainLayer"
    static let appRootPresentation: Self = "DISampleAppRootPresentation"
    static let licensePresentation: Self = "LicensePresentation"
    static let loggerFramework: Self = "LoggerFramework"
    static let licenseFramework: Self = "LicenseFramework"
    static let cloudServiceFramework: Self = "CloudServiceFramework"
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
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.19.0"), // TODO: 10.22 以上がリリースされたらアップデートする（直らないかもしれないが） https://github.com/firebase/firebase-ios-sdk/issues/12390
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
                .domainLayer,
                .appRootPresentation,
                .licensePresentation,
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
        .target(
            name: "CloudServiceFramework",
            dependencies: [
                .domainLayer,
                .firebaseAnalytics,
            ],
            path: SourcesPath.frameworkLayer + "CloudService"
        ),
        
        // DI Layer
        .target(
            name: "DILayer",
            dependencies: [
                .domainLayer,
                .licenseFramework,
                .loggerFramework,
                .cloudServiceFramework,
            ],
            path: SourcesPath.diLayer
        ),
        
    ]
)
