
import DomainLayer
import SwiftUI

@MainActor
public struct AppRootTabView<Router: AppRootTabWireframe, Dependency: AppRootTabPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: AppRootTabPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: AppRootTabPresenter(dependency: dependency))
    }

    public var body: some View {
        Text("AppRootTabView")
            .task {
                await presenter.onAppear()
            }
            .onDisappear {
                presenter.onDisappear()
            }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct AppRootTabView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: configurationAllSizesWithEmpty,
            configure: { state in
                AppRootTabView(router: AppRootRouter(dependency: AppRootRouterDependencyMock.empty), dependency: state)
            }
        )
    }
}
