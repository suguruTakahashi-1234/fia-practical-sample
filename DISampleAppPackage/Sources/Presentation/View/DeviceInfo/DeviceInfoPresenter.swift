
import DomainLayer
import Foundation
import SwiftUI // for UIPasteboard

@MainActor
final class DeviceInfoPresenter<Dependency: DeviceInfoPresenterDependency>: ObservableObject {
    @Published var shouldShowCopyAlert: Bool = false
    private(set) var selectedDeviceInfoType: DeviceInfoType?

    private let deviceInfoDriver: Dependency.DeviceInfoDriverProtocolAT
    private let buildEnvRepository: Dependency.BuildEnvRepositoryProtocolAT
    private let clipboardDriver: Dependency.ClipboardDriverProtocolAT

    var copiedAlertTitle: String {
        guard let selectedDeviceInfoType else {
            return ""
        }
        return "Copied \"\(getDeviceInfoValue(selectedDeviceInfoType))\""
    }

    init(dependency: Dependency) {
        LogDriver.initLog()
        deviceInfoDriver = dependency.deviceInfoDriver
        buildEnvRepository = dependency.buildEnvRepository
        clipboardDriver = dependency.clipboardDriver
    }

    deinit {
        LogDriver.deinitLog()
    }

    func onAppear() async {
        LogDriver.logOnAppear()
    }

    func onDisappear() {
        LogDriver.logOnDisappear()
    }

    func onTapDeviceInfo(_ debugInfoType: DeviceInfoType) {
        selectedDeviceInfoType = debugInfoType
        clipboardDriver.copy(getDeviceInfoValue(debugInfoType))
        shouldShowCopyAlert = true
    }

    func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String {
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
