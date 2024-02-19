//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public struct LibraryLicenseDriverProtocolStub: LibraryLicenseDriverProtocol {
    public var licenseList: [License] {
        .randoms
    }
    
    public init() {}
}
