//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class LicenseListPresenter: ObservableObject {
    @Published private(set) var licenseList: [License] = []
    @Published var selectedLicense: License?

    private let libraryLicenseDriver: LibraryLicenseDriverProtocol

    init(dependency: some LicenseListPresenterDependency) {
        LoggerContainer.initLog()
        libraryLicenseDriver = dependency.libraryLicenseDriver
    }

    deinit {
        LoggerContainer.deinitLog()
    }

    func onAppear() async {
        LoggerContainer.logOnAppear()
        licenseList = libraryLicenseDriver.licenseList
    }

    func onDisappear() {
        LoggerContainer.logOnDisappear()
    }

    func onTapLicense(license: License) {
        selectedLicense = license
    }
}
