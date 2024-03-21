
import DomainLayer
import Foundation
import SwiftUI // for UIPasteboard

@MainActor @Observable
final class DeviceInfoPresenter<Dependency: DeviceInfoPresenterDependency> {
    var shouldShowCopyAlert: Bool = false
    private(set) var selectedDeviceInfoType: DeviceInfoType?

    /// UseCase の Mock を使用する場合はここを書き換える（DI のコードは書き換えず Presenter で直接指定する）
    private let deviceInfoUseCase: DeviceInfoInteractor<Dependency>
    private let dependency: Dependency

    @ObservationIgnored
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
        OSLogDriver.deinitLog()
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
