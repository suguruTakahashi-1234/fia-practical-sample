
import DomainLayer
import Foundation
import SwiftUI // for UIPasteboard

@MainActor
final class DeviceInfoPresenter<Dependency: DeviceInfoPresenterDependency>: ObservableObject {
    @Published var shouldShowCopyAlert: Bool = false
    private(set) var selectedDeviceInfoType: DeviceInfoType?

    /// UseCase の Mock を使用する場合はここを書き換える（DI のコードは書き換えず Presenter で直接指定する）
    private let deviceInfoUseCase: DeviceInfoInteractor<Dependency>
    private let dependency: Dependency

    var copiedAlertTitle: String {
        guard let selectedDeviceInfoType else {
            return ""
        }
        return "Copied \"\(getDeviceInfoValue(selectedDeviceInfoType))\""
    }

    init(dependency: Dependency) {
        dependency.logDriver.initLog()

        self.dependency = dependency
        deviceInfoUseCase = DeviceInfoInteractor(dependency: dependency)
    }

    deinit {
        dependency.logDriver.deinitLog()
    }

    func onAppear() async {
        dependency.logDriver.onAppearLog()
    }

    func onDisappear() {
        dependency.logDriver.onDisappearLog()
    }

    func onTapDeviceInfo(_ deviceInfoType: DeviceInfoType) {
        selectedDeviceInfoType = deviceInfoType
        dependency.clipboardDriver.copy(deviceInfoUseCase.getDeviceInfoValue(deviceInfoType))
        shouldShowCopyAlert = true
    }

    func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String {
        deviceInfoUseCase.getDeviceInfoValue(deviceInfoType)
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
