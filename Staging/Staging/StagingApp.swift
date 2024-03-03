//
//  Created by sugurutakahashi on 2024/02/18
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectorLayer
import PresentationLayer
import SwiftUI

@main
struct ProductionApp: App {
    private let router = AppRootRouter(dependency: AppRootDependencyInjector(buildScheme: .staging))

    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
