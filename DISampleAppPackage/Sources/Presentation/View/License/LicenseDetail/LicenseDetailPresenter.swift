//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class LicenseDetailPresenter: ObservableObject {
    let license: License

    init(license: License) {
        LogDriver.initLog()

        self.license = license
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
