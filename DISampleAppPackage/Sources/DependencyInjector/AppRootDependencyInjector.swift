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

public class AppRootDependencyInjector: AppRootRouterDependency, AppRootDependencyInjectorDependency {
    /// Internal Driver
    let deviceNameDriver: DeviceNameDriver

    /// Data Store
    public let cacheDataStore: CacheDataStore

    /// Driver
    public let buildEnvDriver: BuildEnvDriver
    public let deviceInfoDriver: DeviceInfoDriver<DeviceNameDriver>
    public let clipboardDriver: ClipboardDriver
    public let libraryLicenseDriver: LibraryLicenseDriver

    /// Firenbase Driver（今のところ、internal Driver しかないが、今後 Preseter で直接使うケースがあれば public とする Driver も追加される）
    let firebaseSetupDriver: FirebaseSetupDriver
    let firebaseLogDriver: FirebaseLogDriver
    let firebaseRemoteConfigDriver: FirebaseRemoteConfigDriver<CacheDataStore>

    public init(buildScheme: BuildScheme) {
        LogDriver.initLog()

        // Internal Driver
        deviceNameDriver = DeviceNameDriver()

        // DataStore
        cacheDataStore = CacheDataStore()

        // Driver
        buildEnvDriver = BuildEnvDriver(buildScheme: buildScheme)
        deviceInfoDriver = DeviceInfoDriver(deviceNameDriver: deviceNameDriver)
        clipboardDriver = ClipboardDriver()
        libraryLicenseDriver = LibraryLicenseDriver()

        // Firenbase Driver
        firebaseSetupDriver = FirebaseSetupDriver()
        firebaseLogDriver = FirebaseLogDriver()
        firebaseRemoteConfigDriver = FirebaseRemoteConfigDriver(cacheDataStore: cacheDataStore)

        // Setup LogDriver
        LogDriver.setDriver(firebaseLogDriver: firebaseLogDriver)
        LogDriver.debugLog("Completed setup LogDriver")
    }
}
