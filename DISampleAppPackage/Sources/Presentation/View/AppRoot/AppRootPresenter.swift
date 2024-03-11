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
        dependency.logDriver.deinitLog()
    }

    func onAppear() async {
        dependency.logDriver.onAppearLog()
    }

    func onDisappear() {
        dependency.logDriver.onDisappearLog()
    }
}
