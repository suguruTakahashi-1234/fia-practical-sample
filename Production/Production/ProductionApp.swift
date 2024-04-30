//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DependencyInjectionLayer
import DomainLayer
import PresentationLayer
import SwiftUI

@main
struct ProductionApp: App {
    private let dependency: AppRootDIContainer

    init() {
        // コマンドライン引数で初回起動UIテストモードが有効であれば UserDefaults をクリアにする
        LocalDataStoreDriver.allClearForFirstLaunchUITest()

        dependency = AppRootDIContainer(buildScheme: .production)
    }

    var body: some Scene {
        WindowGroup {
            AppRootView(dependency: dependency)
        }
    }
}
