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
        logDriver: LogDriver<LogDriverDependencyMock> = .init(dependency: .init(osLogDriver: OSLogDriver(), firebaseAnalyticsLogDriver: .init(), firebaseCrashlyticsLogDriver: .init())), // OSLogDriver は本物を使う
        clipboardDriver: ClipboardDriver = .init() // テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mock に差し替え可能にしているが通常は本物を使う
    ) -> Self {
        Self(
            cacheDataStore: cacheDataStore,
            localDataStore: localDataStore,
            logDriver: logDriver,
            libraryLicenseDriver: libraryLicenseDriver,
            buildEnvDriver: buildEnvDriver,
            clipboardDriver: clipboardDriver,
            deviceInfoDriver: deviceInfoDriver
        )
    }

    /// UseDefaults を指定したいケースが多々あるため設置している
    static func random(localDataStore: LocalDataStore = .init()) -> Self {
        create(
            localDataStore: localDataStore,
            libraryLicenseDriver: .init(licenseList: .randoms)
        )
    }

    static var empty: Self {
        create()
    }

    static var random: Self {
        Self.random()
    }

    static var sizeS: Self {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeS)
        )
    }

    static var sizeM: Self {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeM)
        )
    }

    static var sizeL: Self {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeL)
        )
    }

    static var randomForSnapshotTest: Self {
        let localDataStore: LocalDataStore = .init()

        // スナップショットテスト時に固定値でないと困るのでlaunchAppCountを毎回リセットする
        localDataStore.launchAppCount = .placeholder

        // スナップショットテスト時はオンボーディングは済んでいるものとする
        localDataStore.isCompletedOnboarding = true

        return Self.random(localDataStore: localDataStore)
    }
}
