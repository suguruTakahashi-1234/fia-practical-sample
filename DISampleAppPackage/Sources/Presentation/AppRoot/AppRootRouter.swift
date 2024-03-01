//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

/// Note: Wireframeをまとめたプロトコルは今のところ作成する必要はなさそう。AppRootRouterがPresentation層にあるため、それぞれのWireframeのMockも必要なく、スタブもAppRootRouter.emptyで間に合っている
public struct AppRootRouter<Dependency: AppRootRouterDependency>: AppRootWireframe, HomeTabWireframe, LicenseListWireframe, SettingWireframe {
    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    @MainActor
    public func createAppRootView() -> AppRootView<Self, Dependency> {
        AppRootView(router: self, dependency: dependency)
    }

    @MainActor
    public func createHomeTabView() -> HomeTabView<Self> {
        HomeTabView(router: self)
    }

    @MainActor
    public func createLicenseListView() -> LicenseListView<Self, Dependency> {
        LicenseListView(router: self, dependency: dependency)
    }

    @MainActor
    public func createLicenseDetailView(license: License) -> LicenseDetailView {
        LicenseDetailView(license: license)
    }
    
    @MainActor
    public func createSettingView() -> SettingView<Self, Dependency> {
        SettingView(router: self, dependency: dependency)
    }
}
