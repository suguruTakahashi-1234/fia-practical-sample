//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

public struct UICatalogDependencyInjector: AppRootRouterDependency {
    public let osLogDriver: OSLogDriverProtocol = OSLogDriverProtocolMock()
    public let firebaseSetupDriver: FirebaseSetupDriverProtocol = FirebaseSetupDriverProtocolMock()
    public let libraryLicenseDriver: LibraryLicenseDriverProtocol = LibraryLicenseDriverProtocolStub()
    
    public init() {}
}
