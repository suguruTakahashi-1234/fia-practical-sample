
import DomainLayer
import Foundation

@MainActor
final class SettingPresenter: ObservableObject {
    init(dependency _: some SettingPresenterDependency) {
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
