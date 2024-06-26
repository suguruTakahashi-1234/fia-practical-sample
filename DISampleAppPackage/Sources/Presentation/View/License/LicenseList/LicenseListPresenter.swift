//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

@MainActor @Observable
final class LicenseListPresenter<Dependency: LicenseListPresenterDependency> {
    private(set) var licenseList: [License] = []
    var selectedLicense: License?

    var isEmptyLicense: Bool {
        licenseList.isEmpty
    }

    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency

        dependency.logDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    func onAppear() async {
        dependency.logDriver.onAppearLog()
        licenseList = dependency.libraryLicenseDriver.licenseList
    }

    func onDisappear() {
        dependency.logDriver.onDisappearLog()
    }

    func onTapLicense(license: License) {
        selectedLicense = license
    }
}
