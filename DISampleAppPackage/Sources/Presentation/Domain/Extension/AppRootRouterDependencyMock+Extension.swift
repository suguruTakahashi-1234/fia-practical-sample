//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

public extension AppRootRouterDependencyMock {
    static var buildConfiguration: BuildConfiguration {
        #if DEBUG
            .debug
        #else
            .release
        #endif
    }

    /// 生成された init() だと nil が代入されてしまうため、デフォルト引数を設定した create を用意する
    static func create(
        libraryLicenseDriver: LibraryLicenseDriverProtocolMock = LibraryLicenseDriverProtocolMock(),
        deviceInfoDriver: DeviceInfoDriverProtocolMock = DeviceInfoDriverProtocolMock(),
        buildEnvRepository: BuildEnvRepositoryProtocolMock = BuildEnvRepositoryProtocolMock(buildScheme: .mock, buildConfiguration: AppRootRouterDependencyMock.buildConfiguration),
        osLogDriver: OSLogDriverProtocolMock = OSLogDriverProtocolMock(),
        firebaseSetupDriver: FirebaseSetupDriverProtocolMock = FirebaseSetupDriverProtocolMock()
    ) -> Self {
        .init(
            libraryLicenseDriver: libraryLicenseDriver,
            deviceInfoDriver: deviceInfoDriver,
            buildEnvRepository: buildEnvRepository,
            osLogDriver: osLogDriver,
            firebaseSetupDriver: firebaseSetupDriver
        )
    }

    static var empty: Self {
        .create()
    }

    static var random: Self {
        .create(
            libraryLicenseDriver: .init(licenseList: .randoms)
        )
    }

    static var sizeS: Self {
        .create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeS)
        )
    }

    static var sizeM: Self {
        .create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeM)
        )
    }

    static var sizeL: Self {
        .create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeL)
        )
    }
}