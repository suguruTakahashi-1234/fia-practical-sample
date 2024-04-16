
import DomainLayer
import Foundation

@MainActor @Observable
final class SettingPresenter<Dependency: SettingPresenterDependency> {
    private let dependency: Dependency

    var shouldShowDebugMenu = false

    var isDebugBuild: Bool {
        dependency.buildEnvDriver.buildConfiguration.isDebug
    }

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

    func onTapDebugMenu() {
        shouldShowDebugMenu = true
    }
}
