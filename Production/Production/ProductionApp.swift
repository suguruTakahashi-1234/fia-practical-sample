//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import DomainLayer
import PresentationLayer
import SwiftUI

@main
struct ProductionApp: App {
    private let router: AppRootRouter<AppRootRouterDependencyInjector>

    init() {
        LocalDataStoreDriver.allClearForFirstLaunchUITest()
        router = AppRootRouter(dependency: AppRootRouterDependencyInjector(buildScheme: .production))
    }

    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
