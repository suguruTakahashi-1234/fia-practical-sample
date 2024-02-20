//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DISampleAppRootPresentation
import DomainLayer

@main
struct ProductionApp: App {
    private let router = AppRootRouter(dependency: StubDependencyInjector.random)
    
    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
