//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer
import LicenseFramework

@MainActor
final class LicenseListPresenter: ObservableObject {
    @Published private(set) var licenseList: [License]
    @Published var selectedLicense: License?

    init(libraryLicenseDriver: some LibraryLicenseDriverProtocol) {
        LoggerContainer.initLog()

        licenseList = libraryLicenseDriver.licenseList
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

    func licenseTapped(license: License) {
        selectedLicense = license
    }
}
