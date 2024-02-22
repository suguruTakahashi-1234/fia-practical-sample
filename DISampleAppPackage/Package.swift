// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension String {
    /// ex) "dependencyInjector" -> "DependencyInjector"
    var initialUppercased: String {
        guard !isEmpty else {
            return ""
        }
        return prefix(1).uppercased() + dropFirst()
    }
}

enum FrameworkTargetType: CaseIterable {
    case cloudService
    case license
    case logger
    
    var folderName: String {
        "\(self)".initialUppercased
    }
}

enum TargetType {
    case dependencyInjector
    case domain
    case framework(FrameworkTargetType)
    case presentation
    case previewCatalog
    case scenarioCatalog
    
    var folderName: String {
        switch self {
        case .framework:
            "Framework"
        default:
            "\(self)".initialUppercased
        }
    }
    
    var path: String {
        switch self {
        case .framework(let frameworkTargetType):
            "./Sources/\(folderName)/\(frameworkTargetType.folderName)"
        default:
            "./Sources/\(folderName)/"
        }
    }
    
    var name: String {
        switch self {
        case .framework(let frameworkTargetType):
            "\(frameworkTargetType.folderName)Framework"
        default:
            "\(folderName)Layer"
        }
        
    }
    
    var dependencies: [PackageDescription.Target.Dependency] {
        switch self {
        case .dependencyInjector:
            [
                .domainLayer,
                .presentationLayer,
                .licenseFramework,
                .loggerFramework,
                .cloudServiceFramework,
            ]
        case .domain:
            []
        case .framework(let frameworkTargetType):
            switch frameworkTargetType {
            case .cloudService:
                [
                    .domainLayer,
                    .cloudServiceFramework,
                ]
            case .license:
                [
                    .domainLayer,
                ]
            case .logger:
                [
                    .domainLayer,
                ]
            }
        case .presentation:
            [
                .domainLayer,
                .previewSnapshots,
            ]
        case .previewCatalog:
            [
                .presentationLayer, // PreviewGallery() 行うモジュールに依存させるとその Preview が生成される
                .previewGallery,
            ]
        case .scenarioCatalog:
            [
                .playbook,
                .playbookUI,
                .domainLayer,
                .presentationLayer,
            ]
        }
    }
    
    var plugins: [PackageDescription.Target.PluginUsage] {
        switch self {
        case .framework(let frameworkTargetType):
            switch frameworkTargetType {
            case .license:
                [.licensesPlugin]
            default:
                []
            }
        default:
            []
        }
    }

    var value: Target {
        .target(
            name: name,
            dependencies: dependencies,
            path: path,
            plugins: plugins
        )
    }
}

extension TargetType: CaseIterable {
    static var allCases: [TargetType] {
        FrameworkTargetType.allCases.map { .framework($0) } + [
            .dependencyInjector,
            .domain,
            .presentation,
            .previewCatalog,
            .scenarioCatalog
        ]
    }
}

func sourcesPath(_ targetType: TargetType) -> String {
    targetType.path
}

func targetName(_ targetType: TargetType) -> String {
    targetType.name
}

// Ref: 【Swift】Package.swiftのdependenciesをタイプセーフに扱う https://qiita.com/SNQ-2001/items/ed068414747e28999415
private extension PackageDescription.Target.Dependency {
    /// Third party SDK
    static let firebaseAnalytics: Self = .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
    static let playbook: Self = .product(name: "Playbook", package: "playbook-ios")
    static let playbookUI: Self = .product(name: "PlaybookUI", package: "playbook-ios")
    static let previewSnapshots: Self = .product(name: "PreviewSnapshots", package: "swiftui-preview-snapshots")
    static let previewSnapshotsTesting: Self = .product(name: "PreviewSnapshotsTesting", package: "swiftui-preview-snapshots")
    static let previewGallery: Self = .product(name: "PreviewGallery", package: "SnapshotPreviews-iOS")
    static let snapshotting: Self = .product(name: "Snapshotting", package: "SnapshotPreviews-iOS")
    static let snapshottingTests: Self = .product(name: "SnapshottingTests", package: "SnapshotPreviews-iOS")

    // DISample target
    static let domainLayer: Self = "DomainLayer"
    static let presentationLayer: Self = "PresentationLayer"
    static let scenarioCatalogLayer: Self = "ScenarioCatalogLayer"
    static let previewCatalogLayer: Self = "PreviewCatalog"
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
        .library(name: "DependencyInjectorLayer", targets: ["DependencyInjectorLayer"]),
        .library(name: "DomainLayer", targets: ["DomainLayer"]),
        .library(name: "PresentationLayer", targets: ["PresentationLayer"]),
        .library(name: "PreviewCatalogLayer", targets: ["PreviewCatalogLayer"]),
        .library(name: "ScenarioCatalogLayer", targets: ["ScenarioCatalogLayer"]),
    ],
    dependencies: [
        // Library
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.19.0"), // TODO: 10.22 以上がリリースされたらアップデートする（直らないかもしれないが） https://github.com/firebase/firebase-ios-sdk/issues/12390
        .package(url: "https://github.com/playbook-ui/playbook-ios.git", from: "0.3.5"),
        .package(url: "https://github.com/doordash-oss/swiftui-preview-snapshots", from: "1.1.1"),
        .package(url: "https://github.com/EmergeTools/SnapshotPreviews-iOS", from: "0.8.4"),

        // Plugin
        .package(url: "https://github.com/maiyama18/LicensesPlugin", from: "0.1.6"),
        
        // CLI
        .package(url: "https://github.com/uber/mockolo", from: "2.0.1"),
    ],
    targets: [
        // MARK: Dependency Injector layer
        .target(
            name: targetName(.dependencyInjector),
            dependencies: [
                .presentationLayer,
                .licenseFramework,
                .loggerFramework,
                .cloudServiceFramework,
            ],
            path: sourcesPath(.dependencyInjector)
        ),
        
        // MARK: Domain layer
        .target(
            name: targetName(.domain),
            dependencies: [],
            path: sourcesPath(.domain)
        ),

        // MARK: Framework layer
        .target(
            name: targetName(.framework(.cloudService)),
            dependencies: [
                .domainLayer,
                .firebaseAnalytics,
            ],
            path: sourcesPath(.framework(.cloudService))
        ),
        .target(
            name: targetName(.framework(.license)),
            dependencies: [
                .domainLayer,
            ],
            path: sourcesPath(.framework(.license)),
            plugins: [
                .licensesPlugin,
            ]
        ),
        .target(
            name: targetName(.framework(.logger)),
            dependencies: [
                .domainLayer,
            ],
            path: sourcesPath(.framework(.logger))
        ),

        // MARK: Presentation layer
        .target(
            name: targetName(.presentation),
            dependencies: [
                .domainLayer,
                .previewSnapshots,
            ],
            path: sourcesPath(.presentation)
        ),
        
        // MARK: Preview Catalog layer
        .target(
            name: targetName(.previewCatalog),
            dependencies: [
                .presentationLayer, // PreviewGallery() 行うモジュールに依存させるとその Preview が生成される
                .previewGallery,
            ],
            path: sourcesPath(.previewCatalog)
        ),
        
        // MARK: Scenario Catalog layer
        .target(
            name: targetName(.scenarioCatalog),
            dependencies: [
                .playbook,
                .playbookUI,
                .presentationLayer,
            ],
            path: sourcesPath(.scenarioCatalog)
        ),

        // MARK: Tests
        .testTarget(
            name: "SnapshotTests",
            dependencies: [
                .presentationLayer,
                .previewSnapshotsTesting,
            ]
        ),
    ]
)
