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
    private let router: AppRootRouter<AppRootDependencyInjector>

    init() {
        LocalDataStore.allClearForFirstLaunchUITest()
        router = AppRootRouter(dependency: AppRootDependencyInjector(buildScheme: .production))
    }

    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
