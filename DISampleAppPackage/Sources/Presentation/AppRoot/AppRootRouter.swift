//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

/// Note: Wireframeをまとめたプロトコルは今のところ作成する必要はなさそう。AppRootRouterがPresentation層にあるため、それぞれのWireframeのMockも必要なく、スタブもAppRootRouter.emptyで間に合っている
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
