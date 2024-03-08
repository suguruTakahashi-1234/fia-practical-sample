//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import PresentationLayer
import SwiftUI

@main
struct DevelopmentApp: App {
    private let router: AppRootRouter<AppRootRouterDependencyMock>

    init() {
        router = AppRootRouter(dependency: AppRootRouterDependencyMock.random)
    }

    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
