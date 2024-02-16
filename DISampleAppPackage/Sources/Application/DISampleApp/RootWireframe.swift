//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import LicensePresentation

public protocol RootWireframe: AnyObject {
    func createLicenseListView() -> LicenseListView
}
