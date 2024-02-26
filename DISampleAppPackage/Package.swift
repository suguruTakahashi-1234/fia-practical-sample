// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private extension String {
    /// ex) "dependencyInjector" -> "DependencyInjector"
    var initialUppercased: String {
        guard !isEmpty else {
            return ""
        }
        return prefix(1).uppercased() + dropFirst()
    }
}

struct DependencySDK {
    let dependencies: [PackageDescription.Target.Dependency]
    let plugins: [PackageDescription.Target.PluginUsage]
    
    init(_ dependencies: [PackageDescription.Target.Dependency] = [], plugins: [PackageDescription.Target.PluginUsage] = []) {
        self.dependencies = dependencies
        self.plugins = plugins
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

enum TargetType: CaseIterable {
    case dependencyInjector
    case domain
    case framework(FrameworkTargetType)
    case presentation
    case previewCatalog
    case scenarioCatalog

    static var allCases: [TargetType] {
        FrameworkTargetType.allCases.map { .framework($0) } + [
            .dependencyInjector,
            .domain,
            .presentation,
            .previewCatalog,
            .scenarioCatalog
        ]
    }

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

    var target: Target {
        .target(
            name: name,
            dependencies: sdk.dependencies,
            path: path,
            plugins: sdk.plugins
        )
    }

    var dependency: PackageDescription.Target.Dependency {
        PackageDescription.Target.Dependency(stringLiteral: name)
    }

    var product: PackageDescription.Product {
        .library(name: name, targets: [name])
    }
}

enum TestTargetType: CaseIterable {
    case previewSnapshotTest

    private var name: String {
        "\(self)".initialUppercased
    }

    var target: Target {
        .testTarget(
            name: name,
            dependencies: sdk.dependencies,
            plugins: sdk.plugins
        )
    }
}

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
    products: TargetType.allCases.map { $0.product },
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
    targets: TargetType.allCases.map { $0.target } + TestTargetType.allCases.map { $0.target }
)

/// 以下を主に編集する
extension TargetType {
    var sdk: DependencySDK {
        switch self {
        case .dependencyInjector:
                .init([
                    TargetType.domain.dependency,
                    TargetType.presentation.dependency,
                    TargetType.framework(.cloudService).dependency,
                    TargetType.framework(.license).dependency,
                    TargetType.framework(.logger).dependency,
                ])
        case .domain:
                .init()
        case .framework(.cloudService):
                .init([
                    TargetType.domain.dependency,
                    .firebaseAnalytics,
                ])
        case .framework(.license):
                .init([
                    TargetType.domain.dependency,
                ], plugins: [
                    .licensesPlugin
                ])
        case .framework(.logger):
                .init([
                    TargetType.domain.dependency,
                ])
        case .presentation:
                .init([
                    TargetType.domain.dependency,
                    .previewSnapshots,
                ])
        case .previewCatalog:
                .init([
                    TargetType.presentation.dependency, // PreviewGallery() 行うモジュールに依存させるとその Preview が生成される
                    .previewGallery,
                ])
        case .scenarioCatalog:
                .init([
                    TargetType.presentation.dependency,
                    .playbook,
                    .playbookUI,
                ])
        }
    }
}

/// 以下を主に編集する
extension TestTargetType {
    var sdk: DependencySDK {
        switch self {
        case .previewSnapshotTest:
            .init([
                TargetType.presentation.dependency,
                .previewSnapshotsTesting,
//                .snapshotting,
//                .snapshottingTests,
            ])
        }
    }
}
