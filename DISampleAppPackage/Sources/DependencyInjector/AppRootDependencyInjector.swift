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

public class AppRootDependencyInjector: AppRootRouterDependency {
    /// private
    private let deviceNameDriver: DeviceNameDriver

    /// DataStore
    public let cacheDataStore: CacheDataStore

    /// Driver
    public let buildEnvDriver: BuildEnvDriver
    public let deviceInfoDriver: DeviceInfoDriver<DeviceNameDriver>
    public let clipboardDriver: ClipboardDriver
    public let libraryLicenseDriver: LibraryLicenseDriver

    /// Firenbase Driver
    public let firebaseSetupDriver: FirebaseSetupDriver
    public let firebaseLogDriver: FirebaseLogDriver
    public let firebaseRemoteConfigDriver: FirebaseRemoteConfigDriver<CacheDataStore>

    public init(buildScheme: BuildScheme) {
        LogDriver.initLog()

        // private
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
    }
}
