//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

/// Note: Wireframeをまとめたプロトコルは今のところ作成する必要はなさそう。AppRootRouterがPresentation層にあるため、それぞれのWireframeのMockも必要なく、スタブもAppRootRouter.emptyで間に合っている
public struct AppRootRouter<T: AppRootRouterDependency>: AppRootWireframe, LicenseListWireframe, SettingWireframe {
    private let dependency: T

    public init(dependency: T) {
        self.dependency = dependency
    }

    @MainActor
    public func createAppRootView() -> AppRootView {
        AppRootView(router: self, dependency: dependency)
    }

    @MainActor
    public func createLicenseListView() -> LicenseListView {
        LicenseListView(router: self, dependency: dependency)
    }

    @MainActor
    public func createLicenseDetailView(license: License) -> LicenseDetailView {
        LicenseDetailView(license: license)
    }
}
