//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import PresentationLayer
import SwiftUI

@main
struct DevelopmentViewCatalogApp: App {
    private let dependency: AppRootDIContainerDependencyMock

    init() {
        dependency = AppRootDIContainerDependencyMock.random
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DebugViewCatalogListView(dependency: dependency)
            }
        }
    }
}
