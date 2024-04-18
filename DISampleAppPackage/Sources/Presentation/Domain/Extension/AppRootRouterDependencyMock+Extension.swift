//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine
import DomainLayer
import Foundation

public extension AppRootDIContainerDependencyMock {
    static var buildConfiguration: BuildConfiguration {
        #if DEBUG
            .debug
        #else
            .release
        #endif
    }

    /// 生成された init() だと nil が代入されてしまうため、デフォルト引数を設定した create を用意する
    static func create(
        localDataStoreDriver: LocalDataStoreDriver = .init(),
        cacheDataStoreDriver: CacheDataStoreDriverProtocolMock = .init(remoteConfigUpdateErrorSubjecter: .init(), appInfoSubjecter: .init(.defaultValue), variantTestSubjecter: .init(.defaultValue)),
        libraryLicenseDriver: LibraryLicenseDriverProtocolMock = .init(),
        deviceInfoDriver: DeviceInfoDriver<DeviceNameDriverProtocolMock> = .init(deviceNameDriver: .init(deviceName: "Mock")),
        buildEnvDriver: BuildEnvDriverProtocolMock = .init(buildScheme: .development, buildConfiguration: AppRootDIContainerDependencyMock.buildConfiguration),
        logDriver: LogDriver<LogDriverDependencyMock> = .init(dependency: .init(osLogDriver: OSLogDriver(), firebaseAnalyticsLogDriver: .init(), firebaseCrashlyticsLogDriver: .init())), // OSLogDriver は本物を使う
        clipboardDriver: ClipboardDriver = .init() // テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mock に差し替え可能にしているが通常は本物を使う
    ) -> AppRootDIContainerDependencyMock {
        AppRootDIContainerDependencyMock(
            cacheDataStoreDriver: cacheDataStoreDriver,
            logDriver: logDriver,
            buildEnvDriver: buildEnvDriver,
            localDataStoreDriver: localDataStoreDriver,
            libraryLicenseDriver: libraryLicenseDriver,
            deviceInfoDriver: deviceInfoDriver,
            clipboardDriver: clipboardDriver
        )
    }

    static var empty: AppRootDIContainerDependencyMock {
        create()
    }

    static var sizeS: AppRootDIContainerDependencyMock {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeS)
        )
    }

    static var sizeM: AppRootDIContainerDependencyMock {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeM)
        )
    }

    static var sizeL: AppRootDIContainerDependencyMock {
        create(
            libraryLicenseDriver: .init(licenseList: .multipleSizeL)
        )
    }

    static var placeholder: AppRootDIContainerDependencyMock {
        create(
            libraryLicenseDriver: .init(licenseList: .placeholders)
        )
    }

    static var releaseBuildConfiguration: AppRootDIContainerDependencyMock {
        create(
            buildEnvDriver: .init(buildScheme: .development, buildConfiguration: .release)
        )
    }

    /// UseDefaults を指定したいケースが多々あるため設置している
    static func random(localDataStoreDriver: LocalDataStoreDriver = .init()) -> AppRootDIContainerDependencyMock {
        create(
            localDataStoreDriver: localDataStoreDriver,
            libraryLicenseDriver: .init(licenseList: .randoms)
        )
    }

    static var random: AppRootDIContainerDependencyMock {
        AppRootDIContainerDependencyMock.random()
    }

    static var randomForSnapshotTest: AppRootDIContainerDependencyMock {
        let localDataStoreDriver: LocalDataStoreDriver = .init()

        // スナップショットテスト時に固定値でないと困るのでlaunchAppCountを毎回リセットする
        localDataStoreDriver.launchAppCount = .placeholder

        // スナップショットテスト時はオンボーディングは済んでいるものとする
        localDataStoreDriver.isCompletedOnboarding = true

        return AppRootDIContainerDependencyMock.random(localDataStoreDriver: localDataStoreDriver)
    }
}
