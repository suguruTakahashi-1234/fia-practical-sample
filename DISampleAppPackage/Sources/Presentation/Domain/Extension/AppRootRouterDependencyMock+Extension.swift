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
    ) -> AppRootRouterDependencyMock {
        AppRootRouterDependencyMock(
            cacheDataStore: cacheDataStore,
            localDataStore: localDataStore,
            logDriver: logDriver,
            buildEnvDriver: buildEnvDriver,
            libraryLicenseDriver: libraryLicenseDriver,
            deviceInfoDriver: deviceInfoDriver,
            clipboardDriver: clipboardDriver
        )
    }

    static var empty: AppRootRouterDependencyMock {
        create()
    }

    static var sizeS: AppRootRouterDependencyMock {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeS)
        )
    }

    static var sizeM: AppRootRouterDependencyMock {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeM)
        )
    }

    static var sizeL: AppRootRouterDependencyMock {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeL)
        )
    }

    static var placeholder: AppRootRouterDependencyMock {
        create(
            libraryLicenseDriver: .init(licenseList: .placeholders)
        )
    }

    static var releaseBuildConfiguration: AppRootRouterDependencyMock {
        create(
            buildEnvDriver: .init(buildScheme: .development, buildConfiguration: .release)
        )
    }

    /// UseDefaults を指定したいケースが多々あるため設置している
    static func random(localDataStore: LocalDataStore = .init()) -> AppRootRouterDependencyMock {
        create(
            localDataStore: localDataStore,
            libraryLicenseDriver: .init(licenseList: .randoms)
        )
    }

    static var random: AppRootRouterDependencyMock {
        AppRootRouterDependencyMock.random()
    }

    static var randomForSnapshotTest: AppRootRouterDependencyMock {
        let localDataStore: LocalDataStore = .init()

        // スナップショットテスト時に固定値でないと困るのでlaunchAppCountを毎回リセットする
        localDataStore.launchAppCount = .placeholder

        // スナップショットテスト時はオンボーディングは済んでいるものとする
        localDataStore.isCompletedOnboarding = true

        return AppRootRouterDependencyMock.random(localDataStore: localDataStore)
    }
}
