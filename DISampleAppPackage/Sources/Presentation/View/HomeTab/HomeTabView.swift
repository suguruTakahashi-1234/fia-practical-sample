
import DomainLayer
import SwiftUI

@MainActor
public struct HomeTabView<Router: AppRootWireframe, Dependency: HomeTabPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: HomeTabPresenter<Dependency>

    public init(router: Router, dependency: Dependency, selectedTab: HomeTab = .task) {
        self.router = router
        _presenter = .init(wrappedValue: HomeTabPresenter(dependency: dependency, selectedTab: selectedTab))
    }

    public var body: some View {
        TabView(selection: $presenter.selectedTab) {
            ForEach(HomeTab.allCases) { tab in
                tab.contentView(router: router)
                    .navigationStacked()
                    .tabItem {
                        tab.label
                    }
                    .tag(tab)
            }
        }
        .task {
            await presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

// MARK: - HomeTab

private extension HomeTab {
    @ViewBuilder
    var label: some View {
        switch self {
        case .task:
            Label(title: { Text("タスク") }, icon: { Image(systemName: "pencil.and.list.clipboard") })
        case .setting:
            Label(title: { Text("設定") }, icon: { Image(systemName: "gearshape.fill") })
        }
    }

    @MainActor @ViewBuilder
    func contentView(router: some AppRootWireframe) -> some View {
        switch self {
        case .task:
            router.createTaskListView()
        case .setting:
            router.createSettingView()
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct HomeTabView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<HomeTab> {
        .init(
            configurations: HomeTab.allCases.map { tab in .init(name: "\(tab)".initialUppercased, state: tab) },
            configure: { homeTab in
                HomeTabView(router: AppRootRouter.empty, dependency: AppRootRouterDependencyMock.random, selectedTab: homeTab)
            }
        )
    }
}
