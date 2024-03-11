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

    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency

        dependency.logDriver.initLog()
    }

    deinit {
        dependency.logDriver.deinitLog()
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
