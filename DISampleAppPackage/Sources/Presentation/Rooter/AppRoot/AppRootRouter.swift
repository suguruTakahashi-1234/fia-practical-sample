//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

@MainActor
public final class AppRootRouter<Dependency: AppRootRouterDependency> {
    public let dependency: Dependency

    public init(dependency: Dependency) {
        dependency.logDriver.initLog()

        self.dependency = dependency
    }

    public func createAppRootView() -> AppRootView<Dependency> {
        AppRootView(router: self, dependency: dependency)
    }

    public func createOnboardingView() -> OnboardingView<Dependency> {
        OnboardingView(router: self, dependency: dependency)
    }

    public func createHomeTabView() -> HomeTabView<Dependency> {
        HomeTabView(router: self, dependency: dependency)
    }

    public func createTaskListView() -> TaskListView<Dependency> {
        TaskListView(router: self, dependency: dependency)
    }

    public func createLicenseListView() -> LicenseListView<Dependency> {
        LicenseListView(router: self, dependency: dependency)
    }

    public func createLicenseDetailView(license: License) -> LicenseDetailView<Dependency> {
        LicenseDetailView(dependency: dependency, license: license)
    }

    public func createSettingView() -> SettingView<Dependency> {
        SettingView(router: self, dependency: dependency)
    }

    public func createDeviceInfoView() -> DeviceInfoView<Dependency> {
        DeviceInfoView(router: self, dependency: dependency)
    }

    // MARK: - for Debug

    public func createDebugMenuView() -> DebugMenuView<Dependency> {
        DebugMenuView(router: self, dependency: dependency)
    }

    public func createDebugShortcutViewListView() -> DebugShortcutViewListView<Dependency> {
        DebugShortcutViewListView(router: self, dependency: dependency)
    }
}

// MARK: - AppRootRouterDependencyMock

public extension AppRootRouter where Dependency == AppRootRouterDependencyMock {
    static var empty: AppRootRouter<AppRootRouterDependencyMock> {
        AppRootRouter<AppRootRouterDependencyMock>(dependency: .empty)
    }

    static var random: AppRootRouter<AppRootRouterDependencyMock> {
        AppRootRouter<AppRootRouterDependencyMock>(dependency: .random)
    }
}
