//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol LibraryLicenseDriverProtocol: AnyObject {
    var licenseList: [License] { get }
}
