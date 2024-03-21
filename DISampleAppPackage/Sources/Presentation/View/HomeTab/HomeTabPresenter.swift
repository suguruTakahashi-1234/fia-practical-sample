
import DomainLayer
import Foundation

@MainActor @Observable
final class HomeTabPresenter<Dependency: HomeTabPresenterDependency> {
    var selectedTab: HomeTab

    private let dependency: Dependency

    init(dependency: Dependency, homeTab: HomeTab) {
        dependency.logDriver.initLog()

        self.dependency = dependency
        selectedTab = homeTab
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
