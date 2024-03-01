//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// @mockable(typealias: LibraryLicenseDriverProtocolAT = LibraryLicenseDriverProtocolMock)
public protocol LicenseListPresenterDependency {
    associatedtype LibraryLicenseDriverProtocolAT: LibraryLicenseDriverProtocol

    var libraryLicenseDriver: LibraryLicenseDriverProtocolAT { get }
}
