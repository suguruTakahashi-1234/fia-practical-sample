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
            dependencies: dependencies,
            path: path,
            plugins: plugins
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
    case previewSnapshotTests

    private var name: String {
        "\(self)".initialUppercased
    }

    var target: Target {
        .testTarget(
            name: name,
            dependencies: dependencies,
            plugins: plugins
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
    var dependencies: [PackageDescription.Target.Dependency] {
        switch self {
        case .dependencyInjector:
            [
                TargetType.domain.dependency,
                TargetType.presentation.dependency,
                TargetType.framework(.cloudService).dependency,
                TargetType.framework(.license).dependency,
                TargetType.framework(.logger).dependency,
            ]
        case .domain:
            []
        case .framework(.cloudService):
            [
                TargetType.domain.dependency,
                .firebaseAnalytics,
            ]
        case .framework(.license):
            [
                TargetType.domain.dependency,
            ]
        case .framework(.logger):
            [
                TargetType.domain.dependency,
            ]
        case .presentation:
            [
                TargetType.domain.dependency,
                .previewSnapshots,
            ]
        case .previewCatalog:
            [
                TargetType.presentation.dependency, // PreviewGallery() 行うモジュールに依存させるとその Preview が生成される
                .previewGallery,
            ]
        case .scenarioCatalog:
            [
                TargetType.presentation.dependency,
                .playbook,
                .playbookUI,
            ]
        }
    }
    
    var plugins: [PackageDescription.Target.PluginUsage] {
        switch self {
        case .framework(.license):
            [.licensesPlugin]
        default:
            []
        }
    }
}

/// 以下を主に編集する
extension TestTargetType {
    var dependencies: [PackageDescription.Target.Dependency] {
        switch self {
        case .previewSnapshotTests:
            [
                TargetType.presentation.dependency,
                .previewSnapshotsTesting,
            ]
        }
    }

    var plugins: [PackageDescription.Target.PluginUsage] {
        switch self {
        default:
            []
        }
    }
}
