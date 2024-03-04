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
    
    // DeviceNameDriver のみを Mock に差し替える（ライブラリ依存部分のみを Mock を使うようにしている）
    static var deviceInfoDriver: DeviceInfoDriver<DeviceNameDriverProtocolMock> {
        DeviceInfoDriver(deviceNameDriver: DeviceNameDriverProtocolMock(deviceName: "Mock"))
    }

    /// 生成された init() だと nil が代入されてしまうため、デフォルト引数を設定した create を用意する
    static func create(
        libraryLicenseDriver: LibraryLicenseDriverProtocolMock = LibraryLicenseDriverProtocolMock(),
        deviceInfoDriver: DeviceInfoDriverProtocolMock = DeviceInfoDriverProtocolMock(deviceInfoDriver: AppRootRouterDependencyMock.deviceInfoDriver),
        buildEnvRepository: BuildEnvRepositoryProtocolMock = BuildEnvRepositoryProtocolMock(buildScheme: .mock, buildConfiguration: AppRootRouterDependencyMock.buildConfiguration),
        firebaseLogDriver: FirebaseLogDriverProtocolMock = FirebaseLogDriverProtocolMock(),
        firebaseSetupDriver: FirebaseSetupDriverProtocolMock = FirebaseSetupDriverProtocolMock(),
        clipboardDriver: ClipboardDriver = ClipboardDriver() // テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mock に差し替えてますが通常は本物を使う
    ) -> Self {
        .init(
            libraryLicenseDriver: libraryLicenseDriver,
            firebaseLogDriver: firebaseLogDriver,
            deviceInfoDriver: deviceInfoDriver,
            firebaseSetupDriver: firebaseSetupDriver,
            buildEnvRepository: buildEnvRepository,
            clipboardDriver: clipboardDriver
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
