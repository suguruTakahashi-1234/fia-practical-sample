
import DomainLayer
import SwiftUI

@MainActor
public struct HomeTabView<Router: AppRootWireframe>: View {
    private let router: Router
    @State private var selectedTab: HomeTab = .setting

    public init(router: Router) {
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
        case .home:
            Label(title: { Text("ホーム") }, icon: { Image(systemName: "house.fill") })
        case .setting:
            Label(title: { Text("設定") }, icon: { Image(systemName: "gearshape.fill") })
        }
    }

    @ViewBuilder
    func contentView(router: some AppRootWireframe) -> some View {
        switch self {
        case .home:
            router.createSettingView()
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

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: configurationAllSizesWithEmpty,
            configure: { _ in
                HomeTabView(router: AppRootRouter.empty)
            }
        )
    }
}
