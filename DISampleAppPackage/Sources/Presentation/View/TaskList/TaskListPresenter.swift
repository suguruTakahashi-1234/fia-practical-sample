
import Combine
import DomainLayer
import Foundation
import Observation

@MainActor @Observable
final class TaskListPresenter<Dependency: TaskListPresenterDependency> {
    private(set) var isEnabledNewFeature: Bool = false

    private let dependency: Dependency
    private var cancellables = Set<AnyCancellable>()

    init(dependency: Dependency) {
        dependency.logDriver.initLog()

        self.dependency = dependency

        dependency.cacheDataStore.variantTestSubjecter
            .receive(on: RunLoop.main)
            .map { $0.isEnabledNewFeature }
            .assign(to: \.isEnabledNewFeature, on: self)
            .store(in: &cancellables)
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
