//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor
final class LicenseListPresenter<Dependency: LicenseListPresenterDependency>: ObservableObject {
    @Published private(set) var licenseList: [License] = []
    @Published var selectedLicense: License?

    private let libraryLicenseDriver: Dependency.LibraryLicenseDriverProtocolAT

    init(dependency: Dependency) {
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
