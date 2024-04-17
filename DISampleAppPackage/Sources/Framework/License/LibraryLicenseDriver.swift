//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation
import LicenseList

public final class LibraryLicenseDriver: LibraryLicenseDriverProtocol {
    public init() {
        OSLogDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public var licenseList: [License] {
        Library.libraries.map { License(from: $0) }.filter { !$0.text.isEmpty }
    }
}

extension License {
    init(from licenseListLibrary: LicenseList.Library) {
        self.init(id: licenseListLibrary.id.uuidString, name: licenseListLibrary.name, text: licenseListLibrary.licenseBody)
    }
}
