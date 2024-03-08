
import DomainLayer
import SwiftUI

@MainActor
public struct HomeTabView<Router: AppRootWireframe>: View {
    private let router: Router
    @State private var selectedTab: HomeTab

    public init(router: Router, selectedTab: HomeTab = .task) {
        self.selectedTab = selectedTab
        self.router = router
    }

    public var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(HomeTab.allCases) { tab in
                tab.contentView(router: router)
                    .tabItem {
                        tab.label
                    }
                    .tag(tab)
            }
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

    @ViewBuilder
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
                HomeTabView(router: AppRootRouter.empty, selectedTab: homeTab)
            }
        )
    }
}
