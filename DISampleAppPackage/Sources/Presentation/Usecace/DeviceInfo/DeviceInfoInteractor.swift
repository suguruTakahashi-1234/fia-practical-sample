//
//  Created by sugurutakahashi on 2024/03/06
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

public struct DeviceInfoInteractor<BuildEnvRepository: BuildEnvRepositoryProtocol, DeviceInfoDriver: DeviceInfoDriverProtocol>: DeviceInfoUseCase {
    private let buildEnvRepository: BuildEnvRepository
    private let deviceInfoDriver: DeviceInfoDriver
    
    public init(buildEnvRepository: BuildEnvRepository, deviceInfoDriver: DeviceInfoDriver) {
        LogDriver.initLog()

        self.buildEnvRepository = buildEnvRepository
        self.deviceInfoDriver = deviceInfoDriver
    }
    
    public func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String {
        switch deviceInfoType {
        case .appVersion:
            "\(deviceInfoDriver.appVersion) (\(deviceInfoDriver.appBuildNumber))"
        case .buildScheme:
            buildEnvRepository.buildScheme.name
        case .buildConfiguration:
            buildEnvRepository.buildConfiguration.name
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
