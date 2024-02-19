//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol LicenseListPresenterDependency {
    var libraryLicenseDriver: LibraryLicenseDriverProtocol { get }
}
