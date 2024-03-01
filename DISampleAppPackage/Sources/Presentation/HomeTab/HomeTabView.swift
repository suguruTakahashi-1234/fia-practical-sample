
import DomainLayer
import SwiftUI

@MainActor
public struct HomeTabView<Router: HomeTabWireframe>: View {
    private let router: Router
    @State private var selectedTab: HomeTab = .home
    
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

// MARK: - Preview

import PreviewSnapshots

struct HomeTabView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: configurationAllSizesWithEmpty,
            configure: { state in
                HomeTabView(router: AppRootRouter(dependency: AppRootRouterDependencyMock.empty))
            }
        )
    }
}

                
private extension HomeTab {
    @ViewBuilder
    var label: some View {
        switch self {
        case.home:
            Label(title: { Text("ホーム") }, icon: { Image(systemName: "house.fill") })
        case .setting:
            Label(title: { Text("設定") }, icon: { Image(systemName: "gearshape.fill") })
        }
    }

    @ViewBuilder
    func contentView(router: some HomeTabWireframe) -> some View {
        switch self {
        case .home:
            router.createSettingView()
        case .setting:
            router.createSettingView()
        }
    }
}

