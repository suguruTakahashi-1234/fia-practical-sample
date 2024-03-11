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
    /// Data Store
    public let cacheDataStore: CacheDataStore

    /// Internal Driver
    let deviceNameDriver: DeviceNameDriver

    /// Public Driver
    public let osLogDriver: OSLogDriver
    public let buildEnvDriver: BuildEnvDriver
    public let deviceInfoDriver: DeviceInfoDriver<DeviceNameDriver>
    public let clipboardDriver: ClipboardDriver
    public let libraryLicenseDriver: LibraryLicenseDriver

    /// Firenbase Driver
    let firebaseSetupDriver: FirebaseSetupDriver
    let firebaseRemoteConfigDriver: FirebaseRemoteConfigDriver<CacheDataStore>
    public let firebaseLogDriver: FirebaseLogDriver

    /// Log Driver
    public let logDriver: LogDriver<OSLogDriver, FirebaseLogDriver>

    public init(buildScheme: BuildScheme) {
        OSLogDriver.initLog()

        // DataStore
        cacheDataStore = CacheDataStore()

        // Internal Driver
        deviceNameDriver = DeviceNameDriver()

        // Public Driver
        osLogDriver = OSLogDriver()
        buildEnvDriver = BuildEnvDriver(buildScheme: buildScheme)
        deviceInfoDriver = DeviceInfoDriver(deviceNameDriver: deviceNameDriver)
        clipboardDriver = ClipboardDriver()
        libraryLicenseDriver = LibraryLicenseDriver()

        // Firenbase Driver
        firebaseSetupDriver = FirebaseSetupDriver()
        firebaseLogDriver = FirebaseLogDriver()
        firebaseRemoteConfigDriver = FirebaseRemoteConfigDriver(cacheDataStore: cacheDataStore)

        // Setup LogDriver
        logDriver = LogDriver(osLogDriver: osLogDriver, firebaseLogDriver: firebaseLogDriver)
        logDriver.debugLog("Completed setup LogDriver")
    }
}
