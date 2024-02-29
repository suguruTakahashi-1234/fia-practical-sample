
import DomainLayer
import SwiftUI

@MainActor
public struct SettingView<Router: SettingWireframe>: View {
    private let router: Router
    @StateObject private var presenter: SettingPresenter

    public init(router: Router, dependency: some SettingPresenterDependency) {
        self.router = router
        _presenter = .init(wrappedValue: SettingPresenter(dependency: dependency))
    }

    public var body: some View {
        Text("SettingView")
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

struct SettingView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: configurationAllSizesWithEmpty,
            configure: { state in
                SettingView(router: AppRootRouter(dependency: AppRootRouterDependencyMock.empty), dependency: state)
            }
        )
    }
}
