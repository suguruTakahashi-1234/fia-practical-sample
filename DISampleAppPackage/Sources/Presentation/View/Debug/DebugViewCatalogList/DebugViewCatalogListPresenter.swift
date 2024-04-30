//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor @Observable
final class DebugViewCatalogListPresenter<Dependency: DebugViewCatalogListPresenterDependency> {
    private let dependency: Dependency

    init(dependency: Dependency) {
        dependency.logDriver.initLog()

        self.dependency = dependency
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    func onAppear() async {
        dependency.logDriver.onAppearLog()
    }

    func onDisappear() {
        dependency.logDriver.onDisappearLog()
    }
}
