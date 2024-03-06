
import DomainLayer
import Foundation
import SwiftUI // for UIPasteboard

@MainActor
final class DeviceInfoPresenter<Dependency: DeviceInfoPresenterDependency>: ObservableObject {
    @Published var shouldShowCopyAlert: Bool = false
    private(set) var selectedDeviceInfoType: DeviceInfoType?

    private let clipboardDriver: Dependency.ClipboardDriverProtocolAT
    private let deviceInfoUsecase: Dependency.DeviceInfoUsecaseAT

    var copiedAlertTitle: String {
        guard let selectedDeviceInfoType else {
            return ""
        }
        return "Copied \"\(getDeviceInfoValue(selectedDeviceInfoType))\""
    }

    init(dependency: Dependency) {
        LogDriver.initLog()

        clipboardDriver = dependency.clipboardDriver
        deviceInfoUsecase = dependency.deviceInfoUsecase
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

    func onTapDeviceInfo(_ deviceInfoType: DeviceInfoType) {
        selectedDeviceInfoType = deviceInfoType
        clipboardDriver.copy(deviceInfoUsecase.getDeviceInfoValue(deviceInfoType))
        shouldShowCopyAlert = true
    }

    func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String {
        deviceInfoUsecase.getDeviceInfoValue(deviceInfoType)
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
