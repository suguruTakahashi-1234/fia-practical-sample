//
//  Created by sugurutakahashi on 2024/02/18
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import PresentationLayer
import DependencyInjectorLayer

@main
struct ProductionApp: App {
    private let router = AppRootRouter(dependency: AppRootDependencyInjector())
    
    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
