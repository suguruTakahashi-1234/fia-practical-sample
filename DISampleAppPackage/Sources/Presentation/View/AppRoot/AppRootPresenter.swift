//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class AppRootPresenter<Dependency: AppRootPresenterDependency>: ObservableObject {
    init(dependency: Dependency) {
        // Setup Firebase
        dependency.firebaseSetupDriver.configure()

        // Setup Logger
        LogDriver.setDriver(firebaseLogDriver: dependency.firebaseLogDriver)
        LogDriver.debugLog("completed setup LogDriver")

        LogDriver.initLog()
    }

    deinit {
        LogDriver.deinitLog()
    }

    func onAppear() async {
        LogDriver.logOnAppear()
    }

    func onDisappear() {
        LogDriver.logOnDisappear()
    }
}
