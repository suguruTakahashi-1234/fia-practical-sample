//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer
import LoggerFramework

@MainActor
final class LicenseDetailPresenter: ObservableObject {
    let license: License

    init(license: License) {
        LoggerContainer.initLog()

        self.license = license
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
