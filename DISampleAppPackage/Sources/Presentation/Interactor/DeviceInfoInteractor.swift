//
//  Created by sugurutakahashi on 2024/03/06
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// Interactor は 実質的に Presenter の切り出しなので @MainActor で問題ない
@MainActor
public final class DeviceInfoInteractor<Dependency: DeviceInfoInteractorDependency>: DeviceInfoUseCase {
    private let dependency: Dependency

    public init(dependency: Dependency) {
        dependency.logDriver.initLog()

        self.dependency = dependency
    }

    public func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String {
        switch deviceInfoType {
        case .appVersion:
            "\(dependency.deviceInfoDriver.appVersion) (\(dependency.deviceInfoDriver.appBuildNumber))"
        case .buildScheme:
            dependency.buildEnvDriver.buildScheme.name
        case .buildConfiguration:
            dependency.buildEnvDriver.buildConfiguration.name
        case .deviceIdentifier:
            dependency.deviceInfoDriver.deviceIdentifier
        case .bundleId:
            dependency.deviceInfoDriver.bundleId
        case .deviceName:
            dependency.deviceInfoDriver.deviceName
        case .isSimulator:
            "\(dependency.deviceInfoDriver.isSimulator)"
        case .isPreview:
            "\(dependency.deviceInfoDriver.isPreview)"
        case .osVersion:
            "\(dependency.deviceInfoDriver.osType) \(dependency.deviceInfoDriver.osVersion)"
        case .timezone:
            dependency.deviceInfoDriver.timezone
        case .preferredLanguages:
            dependency.deviceInfoDriver.preferredLanguages
        case .language:
            dependency.deviceInfoDriver.language
        case .launchAppCount:
            "\(dependency.localDataStoreDriver.launchAppCount)"
        case .apnsToken:
            "\(dependency.localDataStoreDriver.apnsToken?.deviceTokenHexString ?? "not set")"
        }
    }
}

private extension BuildScheme {
    var name: String {
        "\(self)".camelCaseToSpaces.localizedCapitalized
    }
}

private extension BuildConfiguration {
    var name: String {
        "\(self)".camelCaseToSpaces.localizedCapitalized
    }
}
