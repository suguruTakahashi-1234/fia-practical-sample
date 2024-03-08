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
        LogDriver.initLog()
        libraryLicenseDriver = dependency.libraryLicenseDriver
    }

    deinit {
        LogDriver.deinitLog()
    }

    func onAppear() async {
        LogDriver.onAppearLog()
        licenseList = libraryLicenseDriver.licenseList
    }

    func onDisappear() {
        LogDriver.onDisappearLog()
    }

    func onTapLicense(license: License) {
        selectedLicense = license
    }
}
