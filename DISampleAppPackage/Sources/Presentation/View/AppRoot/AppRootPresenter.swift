//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class AppRootPresenter<Dependency: AppRootPresenterDependency>: ObservableObject {
    init(dependency _: Dependency) {
        LogDriver.initLog()
    }

    deinit {
        LogDriver.deinitLog()
    }

    func onAppear() async {
        LogDriver.onAppearLog()
    }

    func onDisappear() {
        LogDriver.onDisappearLog()
    }
}
