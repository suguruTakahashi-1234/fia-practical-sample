//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import LicensePresentation
import DomainLayer

final public class RootRouter: AppRootWireframe, LicenseListWireframe {
    private let osLogDriver: OSLogDriverProtocol
    private let libraryLicenseDriver: LibraryLicenseDriverProtocol
    
    public init(dependencyInjector: some RootRouterDependency) {
        osLogDriver = dependencyInjector.osLogDriver
        libraryLicenseDriver = dependencyInjector.libraryLicenseDriver
    }
    
    public func createAppRootView() -> AppRootView {
        AppRootView(router: self, osLogDriver: osLogDriver)
    }
    
    public func createLicenseListView() -> LicenseListView {
        LicenseListView(router: self, libraryLicenseDriver: self.libraryLicenseDriver)
    }
    
    public func createLicenseDetailView(license: License) -> LicenseDetailView {
        LicenseDetailView(license: license)
    }
}
