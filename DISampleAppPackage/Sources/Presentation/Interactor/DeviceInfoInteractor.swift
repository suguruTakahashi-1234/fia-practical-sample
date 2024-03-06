//
//  Created by sugurutakahashi on 2024/03/06
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

public struct DeviceInfoInteractor<BuildEnvDriver: BuildEnvDriverProtocol, DeviceInfoDriver: DeviceInfoDriverProtocol>: DeviceInfoUseCase {
    private let buildEnvDriver: BuildEnvDriver
    private let deviceInfoDriver: DeviceInfoDriver

    public init(buildEnvDriver: BuildEnvDriver, deviceInfoDriver: DeviceInfoDriver) {
        LogDriver.initLog()

        self.buildEnvDriver = buildEnvDriver
        self.deviceInfoDriver = deviceInfoDriver
    }

    public func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String {
        switch deviceInfoType {
        case .appVersion:
            "\(deviceInfoDriver.appVersion) (\(deviceInfoDriver.appBuildNumber))"
        case .buildScheme:
            buildEnvDriver.buildScheme.name
        case .buildConfiguration:
            buildEnvDriver.buildConfiguration.name
        case .deviceIdentifier:
            deviceInfoDriver.deviceIdentifier
        case .deviceName:
            deviceInfoDriver.deviceName
        case .isSimulator:
            "\(deviceInfoDriver.isSimulator)"
        case .isPreview:
            "\(deviceInfoDriver.isPreview)"
        case .osVersion:
            "\(deviceInfoDriver.osType) \(deviceInfoDriver.osVersion)"
        case .timezone:
            deviceInfoDriver.timezone
        case .language:
            deviceInfoDriver.language
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
