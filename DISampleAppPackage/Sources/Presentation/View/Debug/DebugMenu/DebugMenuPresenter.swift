
import DomainLayer
import Foundation

@MainActor
final class DebugMenuPresenter<Dependency: DebugMenuPresenterDependency>: ObservableObject {
    @Published private(set) var selectedDebugActionType: DebugActionType?
    @Published var shouldShowAlert: Bool = false

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
