//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

@MainActor
final class AppRootPresenter: ObservableObject {

    init(
        osLogDriver: some OSLogDriverProtocol,
        firebaseSetupDriver: some FirebaseSetupDriverProtocol
    ) {
        // Setup Logger
        LoggerContainer.append(logger: osLogDriver)
        LoggerContainer.debugLog("completed setup LoggerContainer")
        
        LoggerContainer.initLog()
        
        // Setup Firebase
        firebaseSetupDriver.configure()
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
