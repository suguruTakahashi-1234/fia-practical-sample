// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

private extension String {
    /// ex) "dependencyInjection" -> "DependencyInjection"
    var initialUppercased: String {
        guard !isEmpty else {
            return ""
        }
        return prefix(1).uppercased() + dropFirst()
    }
}

let swiftFlags = [
    "-Xfrontend", "-warn-long-expression-type-checking=300",
    "-Xfrontend", "-warn-long-function-bodies=300",
    "-enable-actor-data-race-checks",
]

/// Ref: https://github.com/treastrain/swift-upcomingfeatureflags-cheatsheet
/// Ref: https://zenn.dev/treastrain/articles/d2fd1b44e3ead5
extension SwiftSetting {
    static let strictConcurrency: Self = .enableExperimentalFeature("StrictConcurrency") // https://www.swift.org/documentation/concurrency/
    static let forwardTrailingClosures: Self = .enableUpcomingFeature("ForwardTrailingClosures") // SE-0286, Swift 5.3,  SwiftPM 5.8+
    static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny") // SE-0335, Swift 5.6,  SwiftPM 5.8+
    static let bareSlashRegexLiterals: Self = .enableUpcomingFeature("BareSlashRegexLiterals") // SE-0354, Swift 5.7,  SwiftPM 5.8+
    static let conciseMagicFile: Self = .enableUpcomingFeature("ConciseMagicFile") // SE-0274, Swift 5.8,  SwiftPM 5.8+
    static let importObjcForwardDeclarations: Self = .enableUpcomingFeature("ImportObjcForwardDeclarations") // SE-0384, Swift 5.9,  SwiftPM 5.9+
    static let disableOutwardActorInference: Self = .enableUpcomingFeature("DisableOutwardActorInference") // SE-0401, Swift 5.9,  SwiftPM 5.9+
    static let deprecateApplicationMain: Self = .enableUpcomingFeature("DeprecateApplicationMain") // SE-0383, Swift 5.10, SwiftPM 5.10+
    static let isolatedDefaultValues: Self = .enableUpcomingFeature("IsolatedDefaultValues") // SE-0411, Swift 5.10, SwiftPM 5.10+
    static let globalConcurrency: Self = .enableUpcomingFeature("GlobalConcurrency") // SE-0412, Swift 5.10, SwiftPM 5.10+
    static let otherSwiftFlags: Self = .unsafeFlags(swiftFlags)
}

/// Ref: https://github.com/treastrain/swift-upcomingfeatureflags-cheatsheet
/// Ref: https://zenn.dev/treastrain/articles/d2fd1b44e3ead5
extension SwiftSetting: CaseIterable {
    public static var allCases: [Self] {
        [
            .strictConcurrency,
            .forwardTrailingClosures,
            .existentialAny,
            .bareSlashRegexLiterals,
            .conciseMagicFile,
            .importObjcForwardDeclarations,
            .disableOutwardActorInference,
            .deprecateApplicationMain,
            .isolatedDefaultValues,
            .globalConcurrency,
            .otherSwiftFlags,
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
    case firebase
    case device
    case license

    var folderName: String {
        "\(self)".initialUppercased
    }
}

enum TargetType: CaseIterable {
    case dependencyInjection
    case domain
    case framework(FrameworkTargetType)
    case presentation
    case previewCatalog

    static var allCases: [TargetType] {
        FrameworkTargetType.allCases.map { .framework($0) } + [
            .dependencyInjection,
            .domain,
            .presentation,
            .previewCatalog,
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
            resources: resources,
            plugins: dependencyLibrary.plugins
        )
    }

    var dependency: PackageDescription.Target.Dependency {
        PackageDescription.Target.Dependency(stringLiteral: name)
    }

    var product: PackageDescription.Product {
        .library(name: name, targets: [name])
    }

    var resources: [Resource]? {
        switch self {
        case .domain:
            [
                // この記述がなくても動くが SPM の CLI 上の warning を出なくするために記述している
                .process("Resources"),
            ]
        case .presentation:
            [
                // この記述がなくても動くが SPM の CLI 上の warning を出なくするために記述している
                .process("Resources"),
            ]
        case .framework(.firebase):
            [
                // Staging 環境の GoogleService-Info.plist のコピー (testTarget でインテグレーションテストをしたいときに参照する)
                .process("Resources/GoogleService-Info-For-Testing.plist"),
            ]
        default:
            nil
        }
    }
}

enum TestTargetType: CaseIterable {
    case driverTest
    case interactorTest
    case presenterTest
    case viewSnapshotTest

    var name: String {
        "\(self)".initialUppercased
    }

    private var exclude: [String] {
        switch self {
        case .viewSnapshotTest:
            // この記述がなくても動くが SPM の CLI 上の warning を出なくするために記述している
            ["__Snapshots__"]
        default:
            []
        }
    }

    private var resources: [Resource]? {
        nil
    }

    var target: PackageDescription.Target {
        .testTarget(
            name: name,
            dependencies: dependencyLibrary.dependencies,
            exclude: exclude,
            resources: resources,
            plugins: dependencyLibrary.plugins
        )
    }
}

private extension PackageDescription.Target.Dependency {
    /// Library
    static let firebaseAnalytics: Self = .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
    static let firebaseRemoteConfig: Self = .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk")
    static let firebaseCrashlytics: Self = .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk")
    static let previewSnapshots: Self = .product(name: "PreviewSnapshots", package: "swiftui-preview-snapshots")
    static let previewSnapshotsTesting: Self = .product(name: "PreviewSnapshotsTesting", package: "swiftui-preview-snapshots")
    static let previewGallery: Self = .product(name: "PreviewGallery", package: "SnapshotPreviews-iOS")
    static let swiftSyntaxMacros: Self = .product(name: "SwiftSyntaxMacros", package: "swift-syntax")
    static let swiftCompilerPlugin: Self = .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
    static let deviceKit: Self = .product(name: "DeviceKit", package: "DeviceKit")
    static let licenseList: Self = .product(name: "LicenseList", package: "LicenseList")

    /// Test
    static let testing: Self = .product(name: "Testing", package: "swift-testing")
}

private extension PackageDescription.Target.PluginUsage {
    // static let xxxxPlugin: Self = .plugin(name: "XXXX", package: "XXXX")
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
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.24.0"),
        .package(url: "https://github.com/doordash-oss/swiftui-preview-snapshots", from: "1.1.1"),
        .package(url: "https://github.com/EmergeTools/SnapshotPreviews-iOS", from: "0.8.8"),
        .package(url: "https://github.com/apple/swift-syntax", from: "510.0.1"),
        .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.2.2"),
        .package(url: "https://github.com/cybozu/LicenseList.git", from: "0.6.0"),

        // Test
        .package(url: "https://github.com/apple/swift-testing.git", from: "0.7.0"),

        // for CLI
        .package(url: "https://github.com/yonaskolb/Mint.git", from: "0.17.5"),
        .package(url: "https://github.com/daikimat/depermaid.git", from: "1.1.0"),
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
        case .dependencyInjection:
            .init(FrameworkTargetType.allCases.map { TargetType.framework($0).dependency } + [
                TargetType.presentation.dependency,
            ])
        case .domain:
            .init()
        case .framework(.firebase):
            .init([
                TargetType.domain.dependency,
                .firebaseAnalytics,
                .firebaseRemoteConfig,
                .firebaseCrashlytics,
            ])
        case .framework(.device):
            .init([
                TargetType.domain.dependency,
                .deviceKit,
            ])
        case .framework(.license):
            .init([
                TargetType.domain.dependency,
                .licenseList,
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
        }
    }
}

// MARK: - Test

// TODO: swift-testing が Xcode のコンソール上で細かくテスト対象が選択できるようになったらテストターゲット分割を見直す
extension TestTargetType {
    var dependencyLibrary: DependencyLibrary {
        switch self {
        case .driverTest:
            .init(FrameworkTargetType.allCases.map { TargetType.framework($0).dependency } + [
                .testing,
            ])
        case .interactorTest:
            .init([
                TargetType.dependencyInjection.dependency,
                .testing,
            ])
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
