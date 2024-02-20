//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import PresentationLayer

@main
struct ProductionApp: App {
    private let router = AppRootRouter.random
    
    var body: some Scene {
        WindowGroup {
            router.createAppRootView()
        }
    }
}
