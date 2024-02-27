//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

public struct AppRootRouter: AppRootWireframe, LicenseListWireframe, SettingWireframe {
    private let dependency: AppRootRouterDependency
    
    public init(dependency: some AppRootRouterDependency) {
        self.dependency = dependency
    }
    
    public func createAppRootView() -> AppRootView {
        AppRootView(router: self, dependency: dependency)
    }
    
    public func createLicenseListView() -> LicenseListView {
        LicenseListView(router: self, dependency: dependency)
    }
    
    public func createLicenseDetailView(license: License) -> LicenseDetailView {
        LicenseDetailView(license: license)
    }
}
