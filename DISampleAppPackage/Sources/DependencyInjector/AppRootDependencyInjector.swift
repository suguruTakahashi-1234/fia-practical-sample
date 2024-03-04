//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import CloudServiceFramework
import DomainLayer
import Foundation
import LicenseFramework
import PresentationLayer
import DeviceFramework

public struct AppRootDependencyInjector: AppRootRouterDependency {
    public let buildEnvRepository: BuildEnvRepository

    public init(buildScheme: BuildScheme) {
        LogDriver.initLog()

        buildEnvRepository = BuildEnvRepository(buildScheme: buildScheme)
    }

    public var firebaseSetupDriver: some FirebaseSetupDriverProtocol {
        FirebaseSetupDriver()
    }

    public var firebaseLogDriver: some FirebaseLogDriverProtocol {
        FirebaseLogDriver()
    }
    
    public var deviceInfoDriver: some DeviceInfoDriverProtocol {
        DeviceInfoDriver(deviceNameDriver: DeviceNameDriver())
    }
    
    public var libraryLicenseDriver: some LibraryLicenseDriverProtocol {
        LibraryLicenseDriver()
    }
}
