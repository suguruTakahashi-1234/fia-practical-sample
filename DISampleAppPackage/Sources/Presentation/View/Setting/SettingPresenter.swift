
import DomainLayer
import Foundation

@MainActor @Observable
final class SettingPresenter<Dependency: SettingPresenterDependency> {
    private let dependency: Dependency

    init(dependency: Dependency) {
        dependency.logDriver.initLog()

        self.dependency = dependency
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
}
