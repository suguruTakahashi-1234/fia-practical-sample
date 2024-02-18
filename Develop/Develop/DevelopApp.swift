//
//  Created by sugurutakahashi on 2024/02/18
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import DISampleApp

@main
struct DevelopmentApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView(router: DevelopRouter())
        }
    }
}
