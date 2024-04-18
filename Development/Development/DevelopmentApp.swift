//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import PresentationLayer
import SwiftUI

@main
struct DevelopmentApp: App {
    private let router: AppRootRouter<AppRootRouterDependencyMock>

    init() {
        LocalDataStoreDriver.allClearForFirstLaunchUITest()

        // UIテスト時に固定値であるとテストしやすいのでプレースホルダーモードにするときはそれ用のMockを差し込む（通常時はランダムな値を生成するMockを差し込む）
        if ProcessInfo.processInfo.arguments.contains(Constants.Arguments.placeholderUITest) {
            router = AppRootRouter(dependency: AppRootRouterDependencyMock.placeholder)
        } else {
            router = AppRootRouter(dependency: AppRootRouterDependencyMock.random)
        }
    }

    var body: some Scene {
        WindowGroup {
            AppRootView(router: router)
        }
    }
}
