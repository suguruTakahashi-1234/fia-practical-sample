//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol AppRootWireframe {
    associatedtype T: LicenseListWireframe

    func createLicenseListView() -> LicenseListView<T>
}
