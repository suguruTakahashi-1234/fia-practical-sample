//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

extension AppRootRouterDependencyMock {
    public static var empty: Self {
        .init()
    }

    public static var random: Self {
        .init(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .randoms)
        )
    }
    
    public static var sizeS: Self {
        .init(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeS)
        )
    }
    
    public static var sizeM: Self {
        .init(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeM)
        )
    }
    
    public static var sizeL: Self {
        .init(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeL)
        )
    }
}
