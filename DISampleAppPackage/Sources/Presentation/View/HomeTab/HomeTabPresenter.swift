
import DomainLayer
import Foundation

@MainActor
final class HomeTabPresenter<Dependency: HomeTabPresenterDependency>: ObservableObject {
    init(dependency _: some HomeTabPresenterDependency) {
        LogDriver.initLog()
    }

    deinit {
        LogDriver.deinitLog()
    }

    func onAppear() async {
        LogDriver.logOnAppear()
    }

    func onDisappear() {
        LogDriver.logOnDisappear()
    }
}
