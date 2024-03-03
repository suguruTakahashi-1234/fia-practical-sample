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
        LoggerContainer.append(logger: dependency.osLogDriver)
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