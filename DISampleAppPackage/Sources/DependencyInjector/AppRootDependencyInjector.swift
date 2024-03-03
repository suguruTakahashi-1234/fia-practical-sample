//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import CloudServiceFramework
import DomainLayer
import Foundation
import LicenseFramework
import LoggerFramework
import PresentationLayer
import DeviceFramework

public struct AppRootDependencyInjector: AppRootRouterDependency {
    public let buildEnvRepository: BuildEnvRepository

    public let deviceInfoDriver: some DeviceInfoDriverProtocol = DeviceInfoDriver(deviceNameDriver: DeviceNameDriver())
    public let osLogDriver: some OSLogDriverProtocol = OSLogger(subsystem: Bundle.main.bundleIdentifier!, category: Constants.Logger.categoryName)
    public let firebaseSetupDriver: some FirebaseSetupDriverProtocol = FirebaseSetupDriver()
    public let libraryLicenseDriver: some LibraryLicenseDriverProtocol = LibraryLicenseDriver()

    public init(buildScheme: BuildScheme) {
        buildEnvRepository = BuildEnvRepository(buildScheme: buildScheme)
    }
}
