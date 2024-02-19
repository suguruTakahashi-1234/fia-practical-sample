//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer
import LicenseFramework
import LoggerFramework

final public class RootDependencyInjector: RootRouterDependency {
    public let osLogDriver: OSLogDriverProtocol = OSLogger(subsystem: Bundle.main.bundleIdentifier!, category: Constants.Logger.categoryName)
    public let libraryLicenseDriver: LibraryLicenseDriverProtocol = LibraryLicenseDriver()
    
    public init() {}
}
