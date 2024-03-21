//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor @Observable
public final class LicenseDetailPresenter<Dependency: LicenseDetailPresenterDependency> {
    let license: License
    private let dependency: Dependency

    init(dependency: Dependency, license: License) {
        dependency.logDriver.initLog()

        self.license = license
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
