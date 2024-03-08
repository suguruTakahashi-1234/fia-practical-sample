
import DomainLayer
import Foundation

@MainActor
final class SettingPresenter<Dependency: SettingPresenterDependency>: ObservableObject {
    init(dependency _: some SettingPresenterDependency) {
        LogDriver.initLog()
    }

    deinit {
        LogDriver.deinitLog()
    }

    func onAppear() async {
        LogDriver.onAppearLog()
    }

    func onDisappear() {
        LogDriver.onDisappearLog()
    }
}
