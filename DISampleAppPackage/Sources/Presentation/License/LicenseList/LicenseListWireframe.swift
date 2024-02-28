//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

public protocol LicenseListWireframe {
    func createLicenseDetailView(license: License) -> LicenseDetailView
}
