
import DomainLayer
import SwiftUI

@MainActor
public struct DeviceInfoView<Router: AppRootWireframe, Dependency: DeviceInfoPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: DeviceInfoPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: DeviceInfoPresenter(dependency: dependency))
    }

    public var body: some View {
        NavigationStack {
            Text("DeviceInfoView")
                .navigationTitle("DeviceInfo")
                .task {
                    await presenter.onAppear()
                }
                .onDisappear {
                    presenter.onDisappear()
                }
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct DeviceInfoView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: configurationAllSizesWithEmpty,
            configure: { state in
                DeviceInfoView(router: AppRootRouter.empty, dependency: state)
            }
        )
    }
}
