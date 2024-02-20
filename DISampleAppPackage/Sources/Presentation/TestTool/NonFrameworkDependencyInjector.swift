//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

public struct NonFrameworkDependencyInjector: AppRootRouterDependency {
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

    public static var empty: Self {
        .init()
    }

    public static var random: Self {
        .init(
            libraryLicenseDriver: .init(licenseList: .randoms)
        )
    }
    
    public static var sizeS: Self {
        .init(
            libraryLicenseDriver: .init(licenseList: .multipleSizeS)
        )
    }
    
    public static var sizeM: Self {
        .init(
            libraryLicenseDriver: .init(licenseList: .multipleSizeM)
        )
    }
    
    public static var sizeL: Self {
        .init(
            libraryLicenseDriver: .init(licenseList: .multipleSizeL)
        )
    }
}
