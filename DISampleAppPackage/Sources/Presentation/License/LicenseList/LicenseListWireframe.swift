//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

public protocol LicenseListWireframe {
    func createLicenseDetailView(license: License) -> LicenseDetailView
}
