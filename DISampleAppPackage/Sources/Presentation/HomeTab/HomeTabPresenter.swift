
import DomainLayer
import Foundation

@MainActor
final class HomeTabPresenter<Dependency: HomeTabPresenterDependency>: ObservableObject {
    init(dependency _: some HomeTabPresenterDependency) {
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
