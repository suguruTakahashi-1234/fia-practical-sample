//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import LicensePresentation
import DomainLayer

public struct UICatalogRouter: LicenseListWireframe {
    public static let shared = UICatalogRouter()

    private init() {}
    
    public func createLicenseDetailView(license: DomainLayer.License) -> LicensePresentation.LicenseDetailView {
        LicenseDetailView(license: .random)
    }
}
