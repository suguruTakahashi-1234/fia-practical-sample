//
//  Created by sugurutakahashi on 2024/02/18
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import PresentationLayer
import SwiftUI

@main
struct StagingApp: App {
    private let router: AppRootRouter<AppRootDependencyInjector>

    init() {
        router = AppRootRouter(dependency: AppRootDependencyInjector(buildScheme: .staging))
    }

    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
