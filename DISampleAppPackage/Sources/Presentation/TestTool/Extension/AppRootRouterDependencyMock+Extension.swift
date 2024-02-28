//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

public extension AppRootRouterDependencyMock {
    static var empty: Self {
        .init()
    }

    static var random: Self {
        .init(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .randoms)
        )
    }

    static var sizeS: Self {
        .init(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeS)
        )
    }

    static var sizeM: Self {
        .init(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeM)
        )
    }

    static var sizeL: Self {
        .init(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeL)
        )
    }
}
