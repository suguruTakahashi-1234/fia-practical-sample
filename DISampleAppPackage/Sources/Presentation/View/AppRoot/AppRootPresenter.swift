//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class AppRootPresenter<Dependency: AppRootPresenterDependency>: ObservableObject {
    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency

        dependency.logDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    func onAppear() async {
        dependency.logDriver.onAppearLog()

        dependency.logDriver.logging(.launchApp(.init(count: dependency.localDataStore.launchAppCount)))
        dependency.localDataStore.launchAppCount = dependency.localDataStore.launchAppCount + 1

        if !dependency.localDataStore.isFirstLaunch {
            dependency.localDataStore.isFirstLaunch = true
        }
    }

    func onDisappear() {
        dependency.logDriver.onDisappearLog()
    }
}
