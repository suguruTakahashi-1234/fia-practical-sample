
import DomainLayer
import SwiftUI

@MainActor
public struct SettingView: View {
    private let router: any SettingWireframe
    @StateObject private var presenter: SettingPresenter

    public init(router: some SettingWireframe, dependency: some SettingPresenterDependency) {
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
                SettingView(router: AppRootRouter<AppRootRouterDependencyMock>(dependency: AppRootRouterDependencyMock.empty), dependency: state)
            }
        )
    }
}
