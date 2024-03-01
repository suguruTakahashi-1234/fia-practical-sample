
import DomainLayer
import Foundation

@MainActor
final class DeviceInfoPresenter<Dependency: DeviceInfoPresenterDependency>: ObservableObject {
    init(dependency _: some DeviceInfoPresenterDependency) {
        LoggerContainer.initLog()
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
}
