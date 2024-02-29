//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

public extension AppRootRouterDependencyMock {
    /// 生成された init() だと nil が代入されてしまうため、デフォルト引数を設定した create を用意する
    static func create(
        libraryLicenseDriver: some LibraryLicenseDriverProtocolMock = LibraryLicenseDriverProtocolMock(),
        osLogDriver: some OSLogDriverProtocolMock = OSLogDriverProtocolMock(),
        firebaseSetupDriver: some FirebaseSetupDriverProtocolMock = FirebaseSetupDriverProtocolMock()
    ) -> Self {
        .init(
            libraryLicenseDriver: libraryLicenseDriver,
            osLogDriver: osLogDriver,
            firebaseSetupDriver: firebaseSetupDriver
        )
    }
    
    static var empty: Self {
        .create(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock()
        )
    }

    static var random: Self {
        .create(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .randoms)
        )
    }

    static var sizeS: Self {
        .create(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeS)
        )
        
    }

    static var sizeM: Self {
        .create(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeM)
        )
    }

    static var sizeL: Self {
        .create(
            libraryLicenseDriver: LibraryLicenseDriverProtocolMock(licenseList: .multipleSizeL)
        )
    }
}
