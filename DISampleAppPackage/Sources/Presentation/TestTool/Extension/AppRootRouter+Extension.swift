//
//  Created by sugurutakahashi on 2024/02/27
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

extension AppRootRouter {
    public static var empty: Self {
        AppRootRouter(dependency: AppRootRouterDependencyMock.empty)
    }
}
