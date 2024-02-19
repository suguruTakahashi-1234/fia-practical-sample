//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer
import LicenseFramework
import LoggerFramework
import CloudServiceFramework

public struct AppRootDependencyInjector: AppRootRouterDependency {
    public let osLogDriver: OSLogDriverProtocol = OSLogger(subsystem: Bundle.main.bundleIdentifier!, category: Constants.Logger.categoryName)
    public let firebaseSetupDriver: FirebaseSetupDriverProtocol = FirebaseSetupDriver()
    public let libraryLicenseDriver: LibraryLicenseDriverProtocol = LibraryLicenseDriver()
    
    public init() {}
}
