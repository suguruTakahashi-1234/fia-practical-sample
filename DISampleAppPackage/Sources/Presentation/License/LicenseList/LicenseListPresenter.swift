//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class LicenseListPresenter: ObservableObject {
    @Published private(set) var licenseList: [License]
    @Published var selectedLicense: License?

    init(dependency: some LicenseListPresenterDependency) {
        LoggerContainer.initLog()

        licenseList = dependency.libraryLicenseDriver.licenseList
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

    func onTapLicense(license: License) {
        selectedLicense = license
    }
}
