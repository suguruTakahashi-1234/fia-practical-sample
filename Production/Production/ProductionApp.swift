//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright © 2024 sugurutakahashi. All rights reserved.
//

import DependencyInjectorLayer
import PresentationLayer
import SwiftUI

@main
struct ProductionApp: App {
    private let router = AppRootRouter(dependency: AppRootDependencyInjector())

    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
