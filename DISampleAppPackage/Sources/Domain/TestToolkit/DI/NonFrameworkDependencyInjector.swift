//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

final public class NonFrameworkDependencyInjector: RootRouterDependency {
    public let osLogDriver: OSLogDriverProtocol = OSLogDriverProtocolMock()
    public let firebaseSetupDriver: FirebaseSetupDriverProtocol = FirebaseSetupDriverProtocolMock()
    public let libraryLicenseDriver: LibraryLicenseDriverProtocol = LibraryLicenseDriverProtocolStub()
    
    public init() {}
}
