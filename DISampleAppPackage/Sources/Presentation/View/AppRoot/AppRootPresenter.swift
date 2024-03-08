//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class AppRootPresenter<Dependency: AppRootPresenterDependency>: ObservableObject {
    private let firebaseRemoteConfigDriver: Dependency.FirebaseRemoteConfigDriverProtocolAT

    init(dependency: Dependency) {
        // Setup Firebase
        dependency.firebaseSetupDriver.configure()

        firebaseRemoteConfigDriver = dependency.firebaseRemoteConfigDriver

        // Setup Logger
        LogDriver.setDriver(firebaseLogDriver: dependency.firebaseLogDriver)
        LogDriver.debugLog("completed setup LogDriver")

        LogDriver.initLog()
    }

    deinit {
        LogDriver.deinitLog()
    }

    func onAppear() async {
        LogDriver.onAppearLog()

        do {
            try await firebaseRemoteConfigDriver.fetchAndActivate()
        } catch {
            LogDriver.errorLog(error.toAppError)
        }
    }

    func onDisappear() {
        LogDriver.onDisappearLog()
    }
}
