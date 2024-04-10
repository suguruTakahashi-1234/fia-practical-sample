//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine
import DomainLayer
import Foundation

@MainActor @Observable
final class AppRootPresenter<Dependency: AppRootPresenterDependency> {
    var isCompletedOnboarding: Bool

    private let dependency: Dependency
    private var cancellables = Set<AnyCancellable>()

    init(dependency: Dependency) {
        self.dependency = dependency
        isCompletedOnboarding = dependency.localDataStoreDriver.isCompletedOnboarding

        dependency.logDriver.initLog()

        dependency.localDataStoreDriver.isCompletedOnboardingPublisher
            .assign(to: \.isCompletedOnboarding, on: self)
            .store(in: &cancellables)
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    func onAppear() async {
        dependency.logDriver.onAppearLog()

        dependency.logDriver.logging(.launchApp(.init(count: dependency.localDataStoreDriver.launchAppCount)))
        dependency.localDataStoreDriver.launchAppCount = dependency.localDataStoreDriver.launchAppCount + 1
    }

    func onDisappear() {
        dependency.logDriver.onDisappearLog()
    }
}
