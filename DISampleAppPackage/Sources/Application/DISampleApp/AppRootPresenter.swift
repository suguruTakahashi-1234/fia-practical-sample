//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer
import LoggerFramework

@MainActor
final class AppRootPresenter: ObservableObject {

    init() {
        LoggerContainer.initLog()
        
        LoggerContainer.append(logger: OSLogger(subsystem: Bundle.main.bundleIdentifier!, category: Constants.Logger.categoryName))
        LoggerContainer.debugLog("completed setup LoggerContainer")
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
