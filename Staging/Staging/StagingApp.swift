//
//  Created by sugurutakahashi on 2024/02/18
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DISampleAppRootPresentation
import DILayer

@main
struct ProductionApp: App {
    private let router = RootRouter(dependencyInjector: RootDependencyInjector())
    
    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
