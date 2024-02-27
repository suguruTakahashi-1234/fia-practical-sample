//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

/// @mockable
public protocol LicenseListPresenterDependency {
    var libraryLicenseDriver: LibraryLicenseDriverProtocol { get }
}
