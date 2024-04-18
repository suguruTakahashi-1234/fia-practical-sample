
import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct HomeTabView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    @State private var presenter: HomeTabPresenter<Dependency>

    /// Previews で検証できるように init の引数に tab を設定している（要検討）
    /// SwiftUI の TabView のタップは Binding による更新なので仕方のない側面もある
    public init(dependency: Dependency, homeTab: HomeTab = .task) {
        self.dependency = dependency
        presenter = HomeTabPresenter(dependency: dependency, homeTab: homeTab)
    }

    public var body: some View {
        TabView(selection: $presenter.selectedTab) {
            ForEach(HomeTab.allCases) { tab in
                tab.contentView(dependency: dependency)
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
    func contentView(dependency: some AppRootDIContainerDependency) -> some View {
        switch self {
        case .task:
            TaskListView(dependency: dependency)
        case .setting:
            SettingView(dependency: dependency)
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
                HomeTabView(dependency: AppRootDIContainerDependencyMock.random, homeTab: homeTab)
            }
        )
    }
}
