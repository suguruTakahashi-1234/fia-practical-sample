
import DomainLayer
import Foundation

@MainActor @Observable
final class DebugMenuPresenter<Dependency: DebugMenuPresenterDependency> {
    private(set) var selectedDebugActionType: DebugActionType?
    var shouldShowAlert: Bool = false

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

    func onTapDebugAction(_ debugActionType: DebugActionType) {
        selectedDebugActionType = debugActionType
        shouldShowAlert = true
    }

    func onTapAlertOk(_ debugActionType: DebugActionType) {
        switch debugActionType {
        case .forceCrash:
            fatalError("Force Crash!!")
        case .clearUserDefaults:
            dependency.localDataStore.allClear()
        }
    }
}
