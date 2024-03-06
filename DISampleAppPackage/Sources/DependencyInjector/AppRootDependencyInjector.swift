//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import CloudServiceFramework
import DeviceFramework
import DomainLayer
import Foundation
import LicenseFramework
import PresentationLayer



public struct AppRootDependencyInjector: AppRootRouterDependency {
    private let buildScheme: BuildScheme
    
    
    public init(buildScheme: BuildScheme) {
        LogDriver.initLog()

        self.buildScheme = buildScheme
    }

    public var buildEnvDriver: BuildEnvDriver {
        BuildEnvDriver(buildScheme: buildScheme)
    }

    public var firebaseSetupDriver: FirebaseSetupDriver {
        FirebaseSetupDriver()
    }

    public var firebaseLogDriver: FirebaseLogDriver {
        FirebaseLogDriver()
    }

    /// for DeviceInfoDriver
    public var deviceNameDriver: DeviceNameDriver {
        DeviceNameDriver()
    }

    public var deviceInfoDriver: DeviceInfoDriver<DeviceNameDriver> {
        DeviceInfoDriver(deviceNameDriver: deviceNameDriver)
    }

    public var clipboardDriver: ClipboardDriver {
        ClipboardDriver()
    }

    public var libraryLicenseDriver: LibraryLicenseDriver {
        LibraryLicenseDriver()
    }
}
