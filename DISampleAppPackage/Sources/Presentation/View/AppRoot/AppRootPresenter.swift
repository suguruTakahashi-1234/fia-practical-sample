//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class AppRootPresenter<Dependency: AppRootPresenterDependency>: ObservableObject {
    init(dependency: Dependency) {
        // Setup Logger
        LogDriver.setDriver(firebaseLogDriver: dependency.firebaseLogDriver)
        // LoggerContainer.append(osLogDriver: dependency.firebaseLogDriver)
        LoggerContainer.debugLog("completed setup LoggerContainer")

        LoggerContainer.initLog()

        // Setup Firebase
        dependency.firebaseSetupDriver.configure()
    }

    deinit {
        LoggerContainer.deinitLog()
    }

    func onAppear() async {
        LoggerContainer.logOnAppear()
    }

    func onDisappear() {
        LoggerContainer.logOnDisappear()
    }
}
