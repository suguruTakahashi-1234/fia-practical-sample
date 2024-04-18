//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import DomainLayer
import PresentationLayer
import SwiftUI

@main
struct StagingApp: App {
    private let dependency: AppRootRouterDependencyInjector

    init() {
        LocalDataStoreDriver.allClearForFirstLaunchUITest()
        dependency = AppRootRouterDependencyInjector(buildScheme: .staging)
    }

    var body: some Scene {
        WindowGroup {
            AppRootView(dependency: dependency)
        }
    }
}
