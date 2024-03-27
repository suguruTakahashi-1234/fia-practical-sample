//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright © 2024 sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import PresentationLayer
import SwiftUI

@main
struct ProductionApp: App {
    private let router: AppRootRouter<AppRootDependencyInjector>

    init() {
        router = AppRootRouter(dependency: AppRootDependencyInjector(buildScheme: .production))
    }

    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
