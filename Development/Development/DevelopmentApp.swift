//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import PresentationLayer
import SwiftUI

@main
struct DevelopmentApp: App {
    private let dependency: AppRootDIContainerDependencyMock

    init() {
        // コマンドライン引数で初回起動UIテストモードが有効であれば UserDefaults をクリアにする
        LocalDataStoreDriver.allClearForFirstLaunchUITest()

        // UIテスト時に固定値であるとテストしやすいのでプレースホルダーモードにするときはそれ用のMockを差し込む（通常時はランダムな値を生成するMockを差し込む）
        if ProcessInfo.processInfo.arguments.contains(Constants.Arguments.placeholderUITest) {
            dependency = AppRootDIContainerDependencyMock.placeholder
        } else {
            dependency = AppRootDIContainerDependencyMock.random
        }
    }

    var body: some Scene {
        WindowGroup {
            AppRootView(dependency: dependency)
        }
    }
}
