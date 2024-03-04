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

    public init(buildScheme: BuildScheme) {
        buildEnvRepository = BuildEnvRepository(buildScheme: buildScheme)
    }
    
    public var deviceInfoDriver: some DeviceInfoDriverProtocol {
        DeviceInfoDriver(deviceNameDriver: DeviceNameDriver())
    }
    
    public var osLogDriver: some OSLogDriverProtocol {
        OSLogDriver(subsystem: Bundle.main.bundleIdentifier!, category: Constants.Logger.categoryName)
    }
    
    public var firebaseSetupDriver: some FirebaseSetupDriverProtocol {
        FirebaseSetupDriver()
    }
    
    public var libraryLicenseDriver: some LibraryLicenseDriverProtocol {
        LibraryLicenseDriver()
    }
}
