// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private enum SourcesPath {
    static let diLayer = "./Sources/DI/"
    static let domainLayer = "./Sources/Domain/"
    static let frameworkLayer = "./Sources/Framework/"
    static let presentationLayer = "./Sources/Presentation/"
    static let uiCatalogAppLayer = "./Sources/UICatalogApp/"
}

// Ref: 【Swift】Package.swiftのdependenciesをタイプセーフに扱う https://qiita.com/SNQ-2001/items/ed068414747e28999415
private extension PackageDescription.Target.Dependency {
    /// Third party SDK
    static let firebaseAnalytics: Self = .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
    static let playbook: Self = .product(name: "Playbook", package: "playbook-ios")
    static let playbookUI: Self = .product(name: "PlaybookUI", package: "playbook-ios")

    // TODO: PlaybookSnapshot によるテスト
    // static let playbookSnapshot: Self = .product(name: "PlaybookSnapshot", package: "playbook-ios")
    
    // DISample target
    static let domainLayer: Self = "DomainLayer"
    static let presentationLayer: Self = "PresentationLayer"
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
        // Library
        .library(name: "DISampleApp", targets: ["DomainLayer", "PresentationLayer", "DILayer"]),
        .library(name: "NonFrameworkDISampleApp", targets: ["DomainLayer", "PresentationLayer"]), // 開発向け高速ビルド用
        .library(name: "UICatalogApp", targets: ["UICatalogAppLayer"]),

        // Presentation Layer
        .library(name: "PresentationLayer", targets: ["PresentationLayer"]),
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
        // MARK: Domain layer
        .target(
            name: "DomainLayer",
            dependencies: [],
            path: SourcesPath.domainLayer
        ),

        // MARK: Presentation layer
        .target(
            name: "PresentationLayer",
            dependencies: [
                .domainLayer,
            ],
            path: SourcesPath.presentationLayer
        ),

        // MARK: Framework layer
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

        // MARK: DI Layer
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
        
        // MARK: UICatalog App layer
        .target(
            name: "UICatalogAppLayer",
            dependencies: [
                .playbook,
                .playbookUI,
                .domainLayer,
                .presentationLayer,
            ],
            path: SourcesPath.uiCatalogAppLayer
        ),
    ]
)
