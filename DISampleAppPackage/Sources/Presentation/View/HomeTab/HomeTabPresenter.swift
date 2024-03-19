
import DomainLayer
import Foundation

@MainActor
final class HomeTabPresenter<Dependency: HomeTabPresenterDependency>: ObservableObject {
    @Published var selectedTab: HomeTab

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
