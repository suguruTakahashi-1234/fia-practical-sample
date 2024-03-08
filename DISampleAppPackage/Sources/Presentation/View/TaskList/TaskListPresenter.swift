
import DomainLayer
import Foundation

@MainActor
final class TaskListPresenter<Dependency: TaskListPresenterDependency>: ObservableObject {
    @Published private(set) var isEnabledNewFeature: Bool = false

    private let cacheDataStore: Dependency.CacheDataStoreProtocolAT

    init(dependency: Dependency) {
        LogDriver.initLog()

        cacheDataStore = dependency.cacheDataStore

        cacheDataStore.variantTestSubject
            .receive(on: RunLoop.main)
            .map { $0.isEnabledNewFeature }
            .assign(to: &$isEnabledNewFeature)
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
