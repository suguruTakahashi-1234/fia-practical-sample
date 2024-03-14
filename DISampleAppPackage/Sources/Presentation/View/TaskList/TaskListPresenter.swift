
import DomainLayer
import Foundation

@MainActor
final class TaskListPresenter<Dependency: TaskListPresenterDependency>: ObservableObject {
    @Published private(set) var isEnabledNewFeature: Bool = false

    private let dependency: Dependency

    init(dependency: Dependency) {
        dependency.logDriver.initLog()

        self.dependency = dependency

        dependency.cacheDataStore.variantTestSubjecter
            .receive(on: RunLoop.main)
            .map { $0.isEnabledNewFeature }
            .assign(to: &$isEnabledNewFeature)
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
