//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine
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
        localDataStore: LocalDataStore = .init(),
        cacheDataStore: CacheDataStoreProtocolMock = .init(remoteConfigUpdateErrorSubjecter: .init(), appInfoSubjecter: .init(.defaultValue), variantTestSubjecter: .init(.defaultValue)),
        libraryLicenseDriver: LibraryLicenseDriverProtocolMock = .init(),
        deviceInfoDriver: DeviceInfoDriver<DeviceNameDriverProtocolMock> = .init(deviceNameDriver: .init(deviceName: "Mock")),
        buildEnvDriver: BuildEnvDriverProtocolMock = .init(buildScheme: .development, buildConfiguration: AppRootRouterDependencyMock.buildConfiguration),
        logDriver: LogDriver<OSLogDriver, FirebaseLogDriverProtocolMock> = .init(osLogDriver: .init(), firebaseLogDriver: .init()),
        clipboardDriver: ClipboardDriver = .init() // テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mock に差し替え可能にしているが通常は本物を使う
    ) -> Self {
        // テスト時に困るのでlaunchAppCountを毎回リセットする
        localDataStore.launchAppCount = .placeholder

        return .init(
            cacheDataStore: cacheDataStore,
            logDriver: logDriver,
            localDataStore: localDataStore,
            libraryLicenseDriver: libraryLicenseDriver,
            clipboardDriver: clipboardDriver,
            buildEnvDriver: buildEnvDriver,
            deviceInfoDriver: deviceInfoDriver
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
