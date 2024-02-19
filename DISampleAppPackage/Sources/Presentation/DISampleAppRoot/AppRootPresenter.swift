//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

@MainActor
final class AppRootPresenter: ObservableObject {

    init(dependency: some AppRootPresenterDependency) {
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

    func onAppear() {
        LoggerContainer.logOnAppear()
    }

    func onDisappear() {
        LoggerContainer.logOnDisappear()
    }
}
