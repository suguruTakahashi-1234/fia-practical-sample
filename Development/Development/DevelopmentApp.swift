//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import PresentationLayer
import SwiftUI

@main
struct DevelopmentApp: App {
    private let router: AppRootRouter<AppRootRouterDependencyMock>

    init() {
        LocalDataStore.allClearForFirstLaunchUITest()
        router = AppRootRouter(dependency: AppRootRouterDependencyMock.random)
    }

    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
