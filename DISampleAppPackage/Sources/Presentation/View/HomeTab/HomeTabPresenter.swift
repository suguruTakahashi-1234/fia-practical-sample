
import DomainLayer
import Foundation

@MainActor
final class HomeTabPresenter<Dependency: HomeTabPresenterDependency>: ObservableObject {
    @Published var selectedTab: HomeTab

    private let dependency: Dependency

    init(dependency: Dependency, selectedTab: HomeTab) {
        dependency.logDriver.initLog()

        self.dependency = dependency
        self.selectedTab = selectedTab
    }

    deinit {
        dependency.logDriver.deinitLog()
    }

    func onAppear() async {
        dependency.logDriver.onAppearLog()
    }

    func onDisappear() {
        dependency.logDriver.onDisappearLog()
    }
}
