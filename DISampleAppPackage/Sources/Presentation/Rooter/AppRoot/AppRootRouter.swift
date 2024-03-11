//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

/// Note: Wireframeをまとめたプロトコルは今のところ作成する必要はなさそう。AppRootRouterがPresentation層にあるため、それぞれのWireframeのMockも必要なく、スタブもAppRootRouter.emptyで間に合っている
public final class AppRootRouter<Dependency: AppRootRouterDependency>: AppRootWireframe {
    private let dependency: Dependency

    public init(dependency: Dependency) {
        dependency.logDriver.initLog()

        self.dependency = dependency
    }

    @MainActor
    public func createAppRootView() -> AppRootView<AppRootRouter, Dependency> {
        AppRootView(router: self, dependency: dependency)
    }

    @MainActor
    public func createHomeTabView() -> HomeTabView<AppRootRouter> {
        HomeTabView(router: self)
    }

    @MainActor
    public func createTaskListView() -> TaskListView<AppRootRouter, Dependency> {
        TaskListView(router: self, dependency: dependency)
    }

    @MainActor
    public func createLicenseListView() -> LicenseListView<AppRootRouter, Dependency> {
        LicenseListView(router: self, dependency: dependency)
    }

    @MainActor
    public func createLicenseDetailView(license: License) -> LicenseDetailView<Dependency> {
        LicenseDetailView(dependency: dependency, license: license)
    }

    @MainActor
    public func createSettingView() -> SettingView<AppRootRouter, Dependency> {
        SettingView(router: self, dependency: dependency)
    }

    @MainActor
    public func createDeviceInfoView() -> DeviceInfoView<AppRootRouter, Dependency> {
        DeviceInfoView(router: self, dependency: dependency)
    }
}

extension AppRootRouter where Dependency == AppRootRouterDependencyMock {
    static var empty: AppRootRouter<AppRootRouterDependencyMock> {
        AppRootRouter<AppRootRouterDependencyMock>(dependency: .empty)
    }

    static var random: AppRootRouter<AppRootRouterDependencyMock> {
        AppRootRouter<AppRootRouterDependencyMock>(dependency: .random)
    }
}
