//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import LicensePresentation
import DomainLayer
import DISampleAppRootPresentation

public struct UICatalogRouter: AppRootWireframe, LicenseListWireframe {
    public static let shared = UICatalogRouter()

    private init() {}
    
    public func createLicenseListView() -> LicensePresentation.LicenseListView {
        .init(router: self, dependency: StubDependencyInjector.random)
    }

    public func createLicenseDetailView(license: DomainLayer.License) -> LicensePresentation.LicenseDetailView {
        .init(license: .random)
    }
}
