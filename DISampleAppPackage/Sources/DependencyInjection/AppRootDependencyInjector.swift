//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DeviceFramework
import DomainLayer
import FirebaseFramework
import Foundation
import LicenseFramework
import PresentationLayer

/// ※ UseCase は Presenter の拡張のため DI 層では保持しない
public final class AppRootDependencyInjector: AppRootRouterDependency, AppRootDependencyInjectorDependency, LogDriverDependency {
    /// Internal DependencyInjector
    public final class LogDriverDependencyInjector: LogDriverDependency {
        public let osLogDriver: OSLogDriver
        public let firebaseAnalyticsLogDriver: FirebaseAnalyticsLogDriver
        public let firebaseCrashlyticsLogDriver: FirebaseCrashlyticsLogDriver<DeviceInfoDriver<DeviceNameDriver>>

        public init(osLogDriver: OSLogDriver, firebaseAnalyticsLogDriver: FirebaseAnalyticsLogDriver, firebaseCrashlyticsLogDriver: FirebaseCrashlyticsLogDriver<DeviceInfoDriver<DeviceNameDriver>>) {
            self.osLogDriver = osLogDriver
            self.firebaseAnalyticsLogDriver = firebaseAnalyticsLogDriver
            self.firebaseCrashlyticsLogDriver = firebaseCrashlyticsLogDriver
        }
    }

    /// Data Store
    public let cacheDataStore: CacheDataStore
    public let localDataStore: LocalDataStore

    /// Internal Driver
    let deviceNameDriver: DeviceNameDriver

    /// Generic Driver
    public let buildEnvDriver: BuildEnvDriver
    public let deviceInfoDriver: DeviceInfoDriver<DeviceNameDriver>
    public let clipboardDriver: ClipboardDriver
    public let libraryLicenseDriver: LibraryLicenseDriver

    /// Firenbase Driver
    let firebaseSetupDriver: FirebaseSetupDriver<BuildEnvDriver>
    let firebaseRemoteConfigDriver: FirebaseRemoteConfigDriver<CacheDataStore>

    /// Log Driver
    public let logDriver: LogDriver<LogDriverDependencyInjector>
    public let osLogDriver: OSLogDriver
    public let firebaseAnalyticsLogDriver: FirebaseAnalyticsLogDriver
    public let firebaseCrashlyticsLogDriver: FirebaseCrashlyticsLogDriver<DeviceInfoDriver<DeviceNameDriver>>

    /// テストする想定がないため、Driver の生成以外の処理が大きくなりすぎないように注意すること
    @MainActor
    public init(buildScheme: BuildScheme) {
        precondition(buildScheme != .development, "Unexpected")

        OSLogDriver.initLog()

        // DataStore
        cacheDataStore = CacheDataStore()
        localDataStore = LocalDataStore()

        // Internal Driver
        deviceNameDriver = DeviceNameDriver()

        // Public Driver
        buildEnvDriver = BuildEnvDriver(buildScheme: buildScheme)
        deviceInfoDriver = DeviceInfoDriver(deviceNameDriver: deviceNameDriver)
        clipboardDriver = ClipboardDriver()
        libraryLicenseDriver = LibraryLicenseDriver()

        // Firenbase Driver
        firebaseSetupDriver = FirebaseSetupDriver(buildEnvDriver: buildEnvDriver)
        // FirebaseApp.configure() を実行しなければ、その他の Firebase 関連の API が使用できずエラーが発生するため
        firebaseSetupDriver.configure()
        firebaseRemoteConfigDriver = FirebaseRemoteConfigDriver(cacheDataStore: cacheDataStore)

        // Setup LogDriver
        osLogDriver = OSLogDriver()
        firebaseAnalyticsLogDriver = FirebaseAnalyticsLogDriver()
        firebaseCrashlyticsLogDriver = FirebaseCrashlyticsLogDriver(deviceInfoDriver: deviceInfoDriver)
        logDriver = LogDriver(dependency: LogDriverDependencyInjector(osLogDriver: osLogDriver, firebaseAnalyticsLogDriver: firebaseAnalyticsLogDriver, firebaseCrashlyticsLogDriver: firebaseCrashlyticsLogDriver))
        logDriver.debugLog("Completed setup LogDriver")

        guard !buildEnvDriver.buildScheme.isTesting else {
            // テスト用の Bundle ID と GoogleService-Info.plist が一致しないせいか FirebaseRemoteConfigDriver.setUp() がたまに失敗するので、現状、影響ない処理のためスキップする（要検討）
            OSLogDriver.debugLog("Skip setup FirebaseRemoteConfigDriver for test")
            return
        }

        Task {
            do {
                try await firebaseRemoteConfigDriver.setUp()
                OSLogDriver.debugLog("Completed setup FirebaseRemoteConfigDriver")
            } catch {
                OSLogDriver.errorLog(error.toAppError)
                assertionFailure("\(error.toAppError))")
            }
        }
    }
}
