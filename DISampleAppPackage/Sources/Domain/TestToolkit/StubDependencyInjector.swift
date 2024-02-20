//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public struct StubDependencyInjector: AppRootRouterDependency {
    public let osLogDriver: OSLogDriverProtocol
    public let firebaseSetupDriver: FirebaseSetupDriverProtocol
    public let libraryLicenseDriver: LibraryLicenseDriverProtocol

    public init(
        osLogDriver: OSLogDriverProtocolMock = OSLogDriverProtocolMock(),
        firebaseSetupDriver: FirebaseSetupDriverProtocolMock = FirebaseSetupDriverProtocolMock(),
        libraryLicenseDriver: LibraryLicenseDriverProtocolMock = LibraryLicenseDriverProtocolMock()
    ) {
        self.osLogDriver = osLogDriver
        self.firebaseSetupDriver = firebaseSetupDriver
        self.libraryLicenseDriver = libraryLicenseDriver
    }

    public static var emptyScenario: Self {
        .init()
    }

    public static var randomScenario: Self {
        .init(
            libraryLicenseDriver: .init(licenseList: .randoms)
        )
    }
}
