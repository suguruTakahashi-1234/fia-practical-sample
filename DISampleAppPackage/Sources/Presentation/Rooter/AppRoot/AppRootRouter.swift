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
        AppRootView(router: self)
    }

    public func createOnboardingView() -> OnboardingView<Dependency> {
        OnboardingView(router: self)
    }

    public func createHomeTabView() -> HomeTabView<Dependency> {
        HomeTabView(router: self)
    }

    public func createTaskListView() -> TaskListView<Dependency> {
        TaskListView(router: self)
    }

    public func createLicenseListView() -> LicenseListView<Dependency> {
        LicenseListView(router: self)
    }

    public func createLicenseDetailView(license: License) -> LicenseDetailView<Dependency> {
        // その画面から遷移はなく router を使うことが明らかでない場合はわざわざ router を View に渡す必要はない例
        LicenseDetailView(dependency: dependency, license: license)
    }

    public func createSettingView() -> SettingView<Dependency> {
        SettingView(router: self)
    }

    public func createDeviceInfoView() -> DeviceInfoView<Dependency> {
        DeviceInfoView(router: self)
    }

    // MARK: - for Debug

    public func createDebugMenuView() -> DebugMenuView<Dependency> {
        DebugMenuView(router: self)
    }

    public func createDebugShortcutViewListView() -> DebugShortcutViewListView<Dependency> {
        DebugShortcutViewListView(router: self)
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
