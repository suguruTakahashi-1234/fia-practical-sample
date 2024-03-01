
import DomainLayer
import Foundation

@MainActor
final class AppRootTabPresenter<Dependency: AppRootTabPresenterDependency>: ObservableObject {
    init(dependency _: some AppRootTabPresenterDependency) {
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
