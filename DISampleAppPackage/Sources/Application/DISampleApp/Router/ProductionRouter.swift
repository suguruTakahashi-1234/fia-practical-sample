//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer
import LicensePresentation
import LicenseFramework

final public class ProductionRouter: RootWireframe, LicenseListWireframe {
    private let libraryLicenseDriver: some LibraryLicenseDriverProtocol = LibraryLicenseDriverProtocolMock()
    
    public init() {}
    
    public func createLicenseListView() -> LicenseListView {
        LicenseListView(viewFactory: self, libraryLicenseDriver: self.libraryLicenseDriver)
    }
    
    public func createLicenseDetailView(license: License) -> LicenseDetailView {
        LicenseDetailView(license: license)
    }
}
