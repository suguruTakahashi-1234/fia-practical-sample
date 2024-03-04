
import DomainLayer
import Foundation
import SwiftUI // for UIPasteboard

@MainActor
final class DeviceInfoPresenter<Dependency: DeviceInfoPresenterDependency>: ObservableObject {
    @Published var shouldShowCopyAlert: Bool = false
    private(set) var selectedDeviceInfoType: DeviceInfoType?

    private let deviceInfoDriver: Dependency.DeviceInfoDriverProtocolAT
    private let buildEnvRepository: Dependency.BuildEnvRepositoryProtocolAT
    
    var copiedAlertTitle: String {
        guard let selectedDeviceInfoType else {
            return ""
        }
        return "Copied \"\(getDeviceInfoValue(selectedDeviceInfoType))\""
    }

    init(dependency: Dependency) {
        LoggerContainer.initLog()
        
        deviceInfoDriver = dependency.deviceInfoDriver
        buildEnvRepository = dependency.buildEnvRepository
    }

    deinit {
        LoggerContainer.deinitLog()
    }

    func onAppear() async {
        LoggerContainer.logOnAppear()
    }

    func onDisappear() {
        LoggerContainer.logOnDisappear()
    }
    
    func onTapDeviceInfo(_ debugInfoType: DeviceInfoType) {
        selectedDeviceInfoType = debugInfoType
        UIPasteboard.general.string = getDeviceInfoValue(debugInfoType)
        shouldShowCopyAlert = true
    }
    
    func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String {
        switch deviceInfoType {
        case .appVersion:
            return "\(deviceInfoDriver.appVersion) (\(deviceInfoDriver.appBuildNumber))"
        case .buildScheme:
            return buildEnvRepository.buildScheme.name
        case .buildConfiguration:
            return buildEnvRepository.buildConfiguration.name
        case .deviceIdentifier:
            return deviceInfoDriver.deviceIdentifier
        case .deviceName:
            return deviceInfoDriver.deviceName
        case .isSimulator:
            return "\(deviceInfoDriver.isSimulator)"
        case .isPreview:
            return "\(deviceInfoDriver.isPreview)"
        case .osVersion:
            return "\(deviceInfoDriver.osType) \(deviceInfoDriver.osVersion)"
        case .timezone:
            return deviceInfoDriver.timezone
        case .language:
            return deviceInfoDriver.language
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
