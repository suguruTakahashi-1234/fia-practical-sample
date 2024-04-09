
import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct HomeTabView<Dependency: AppRootRouterDependency>: View {
    private let router: AppRootRouter<Dependency>
    @State private var presenter: HomeTabPresenter<Dependency>

    /// Previews で検証できるように init の引数に tab を設定している（要検討）
    /// SwiftUI の TabView のタップは Binding による更新なので仕方のない側面もある
    public init(router: AppRootRouter<Dependency>, dependency: Dependency, homeTab: HomeTab = .task) {
        self.router = router
        presenter = HomeTabPresenter(dependency: dependency, homeTab: homeTab)
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
            Label(title: { Text("タスク", bundle: .module) }, icon: { SFSymbols.pencilAndListClipboard.image })
        case .setting:
            Label(title: { Text("設定", bundle: .module) }, icon: { SFSymbols.gearshapeFill.image })
        }
    }

    @MainActor @ViewBuilder
    func contentView(router: AppRootRouter<some AppRootRouterDependency>) -> some View {
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
    static var snapshots: PreviewSnapshots<HomeTab> {
        .init(
            configurations: HomeTab.allCases.map { tab in .init(name: "\(tab)".initialUppercased, state: tab) },
            configure: { homeTab in
                HomeTabView(router: AppRootRouter.empty, dependency: AppRootRouterDependencyMock.random, homeTab: homeTab)
            }
        )
    }
}
