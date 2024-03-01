// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport // for Swift Macros
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

/// Ref: https://github.com/treastrain/swift-upcomingfeatureflags-cheatsheet
extension SwiftSetting {
    static let forwardTrailingClosures: Self = .enableUpcomingFeature("ForwardTrailingClosures") // SE-0286, Swift 5.3,  SwiftPM 5.8+
    static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny") // SE-0335, Swift 5.6,  SwiftPM 5.8+
    static let bareSlashRegexLiterals: Self = .enableUpcomingFeature("BareSlashRegexLiterals") // SE-0354, Swift 5.7,  SwiftPM 5.8+
    static let conciseMagicFile: Self = .enableUpcomingFeature("ConciseMagicFile") // SE-0274, Swift 5.8,  SwiftPM 5.8+
    static let importObjcForwardDeclarations: Self = .enableUpcomingFeature("ImportObjcForwardDeclarations") // SE-0384, Swift 5.9,  SwiftPM 5.9+
    static let disableOutwardActorInference: Self = .enableUpcomingFeature("DisableOutwardActorInference") // SE-0401, Swift 5.9,  SwiftPM 5.9+
    static let deprecateApplicationMain: Self = .enableUpcomingFeature("DeprecateApplicationMain") // SE-0383, Swift 5.10, SwiftPM 5.10+
    static let isolatedDefaultValues: Self = .enableUpcomingFeature("IsolatedDefaultValues") // SE-0411, Swift 5.10, SwiftPM 5.10+
    static let globalConcurrency: Self = .enableUpcomingFeature("GlobalConcurrency") // SE-0412, Swift 5.10, SwiftPM 5.10+
}

/// Ref: https://github.com/treastrain/swift-upcomingfeatureflags-cheatsheet
extension SwiftSetting: CaseIterable {
    public static var allCases: [Self] {
        [
            .forwardTrailingClosures,
            .existentialAny,
            .bareSlashRegexLiterals,
            .conciseMagicFile,
            .importObjcForwardDeclarations,
            .disableOutwardActorInference,
            .deprecateApplicationMain,
            .isolatedDefaultValues,
            .globalConcurrency,
        ]
    }
}

struct DependencyLibrary {
    let dependencies: [PackageDescription.Target.Dependency]
    let plugins: [PackageDescription.Target.PluginUsage]

    init(_ dependencies: [PackageDescription.Target.Dependency] = [], plugins: [PackageDescription.Target.PluginUsage] = []) {
        self.dependencies = dependencies
        self.plugins = plugins
    }
}

enum MacroTargetType: CaseIterable {
    case swiftMacroSample

    private var name: String {
        "\(self)".initialUppercased
    }

    var target: PackageDescription.Target {
        .macro(
            name: name,
            dependencies: dependencyLibrary.dependencies,
            plugins: dependencyLibrary.plugins
        )
    }

    var dependency: PackageDescription.Target.Dependency {
        PackageDescription.Target.Dependency(stringLiteral: name)
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
            .scenarioCatalog,
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

    var target: PackageDescription.Target {
        .target(
            name: name,
            dependencies: dependencyLibrary.dependencies,
            path: path,
            plugins: dependencyLibrary.plugins
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
    case presenterTest
    case viewSnapshotTest

    private var name: String {
        "\(self)".initialUppercased
    }

    var target: PackageDescription.Target {
        .testTarget(
            name: name,
            dependencies: dependencyLibrary.dependencies,
            plugins: dependencyLibrary.plugins
        )
    }
}

private extension PackageDescription.Target.Dependency {
    /// Library
    static let firebaseAnalytics: Self = .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
    static let playbook: Self = .product(name: "Playbook", package: "playbook-ios")
    static let playbookUI: Self = .product(name: "PlaybookUI", package: "playbook-ios")
    static let previewSnapshots: Self = .product(name: "PreviewSnapshots", package: "swiftui-preview-snapshots")
    static let previewSnapshotsTesting: Self = .product(name: "PreviewSnapshotsTesting", package: "swiftui-preview-snapshots")
    static let previewGallery: Self = .product(name: "PreviewGallery", package: "SnapshotPreviews-iOS")
    static let swiftSyntaxMacros: Self = .product(name: "SwiftSyntaxMacros", package: "swift-syntax")
    static let swiftCompilerPlugin: Self = .product(name: "SwiftCompilerPlugin", package: "swift-syntax")

    /// Test
    static let testing: Self = .product(name: "Testing", package: "swift-testing")

    // TODO: "0.8.4" のバージョンでは、以下のSDKに依存したテスコードを作成しようとしたがビルドに失敗したため、バージョンが上がったら再度確認する（おそらくSDK側のバグ）
//    static let snapshotting: Self = .product(name: "Snapshotting", package: "SnapshotPreviews-iOS")
//    static let snapshottingTests: Self = .product(name: "SnapshottingTests", package: "SnapshotPreviews-iOS")
}

private extension PackageDescription.Target.PluginUsage {
    static let licensesPlugin: Self = .plugin(name: "LicensesPlugin", package: "LicensesPlugin")
}

// MARK: - Package

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
        .package(url: "https://github.com/apple/swift-syntax", from: "509.1.1"), // SwiftSyntax の競合に注意

        // Test
        .package(url: "https://github.com/apple/swift-testing.git", from: "0.5.0"),

        // Plugin
        .package(url: "https://github.com/maiyama18/LicensesPlugin", from: "0.1.6"),

        // for CLI
        .package(url: "https://github.com/yonaskolb/Mint.git", from: "0.17.5"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", exact: "0.53.2"), // バージョンを変更した場合は .swiftformat ファイルを修正する

        // DocC
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
    ],
    targets: MacroTargetType.allCases.map { $0.target } + TargetType.allCases.map { $0.target } + TestTargetType.allCases.map { $0.target }
)

/// Ref: https://github.com/treastrain/swift-upcomingfeatureflags-cheatsheet
package.targets.filter { ![.system, .binary, .plugin, .macro].contains($0.type) }.forEach { $0.swiftSettings = SwiftSetting.allCases }

// MARK: - Macro

extension MacroTargetType {
    var dependencyLibrary: DependencyLibrary {
        switch self {
        case .swiftMacroSample:
            .init([
                .swiftSyntaxMacros,
                .swiftCompilerPlugin,
            ])
        }
    }
}

// MARK: - Target

extension TargetType {
    var dependencyLibrary: DependencyLibrary {
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
                .licensesPlugin,
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

// MARK: - Test

extension TestTargetType {
    var dependencyLibrary: DependencyLibrary {
        switch self {
        case .presenterTest:
            .init([
                TargetType.presentation.dependency,
                .testing,
            ])
        case .viewSnapshotTest:
            .init([
                TargetType.presentation.dependency,
                .previewSnapshotsTesting,
                .testing,
            ])
        }
    }
}
