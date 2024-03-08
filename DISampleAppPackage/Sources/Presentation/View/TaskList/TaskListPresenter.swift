
import DomainLayer
import Foundation

@MainActor
final class TaskListPresenter<Dependency: TaskListPresenterDependency>: ObservableObject {
    init(dependency _: Dependency) {
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
