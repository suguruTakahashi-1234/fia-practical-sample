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

    deinit {
        OSLogDriver.deinitLog()
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
