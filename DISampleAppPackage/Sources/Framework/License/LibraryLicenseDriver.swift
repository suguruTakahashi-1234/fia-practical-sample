//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

public struct LibraryLicenseDriver: LibraryLicenseDriverProtocol {    
    public init() {}

    public var licenseList: [License] {
        LicensesPlugin.licenses.map { License(from: $0) }.filter { !$0.text.isEmpty }
    }
}

extension License {
    init(from licensesPluginLicense: LicensesPlugin.License) {
        self.init(id: licensesPluginLicense.id, name: licensesPluginLicense.name, text: licensesPluginLicense.licenseText ?? "")
    }
}
