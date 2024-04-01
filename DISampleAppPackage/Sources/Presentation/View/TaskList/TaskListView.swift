
import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct TaskListView<Router: AppRootWireframe, Dependency: TaskListPresenterDependency>: View {
    private let router: Router
    @State private var presenter: TaskListPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        presenter = TaskListPresenter(dependency: dependency)
    }

    public var body: some View {
        VStack {
            Text("タスク一覧", bundle: .module)
            Text("Remote Comfig 新 UI モード: \(presenter.isEnabledNewFeature ? String(localized: "オン", bundle: .module) : String(localized: "オフ", bundle: .module))", bundle: .module)
        }
        .navigationTitle(String(localized: "タスク一覧", bundle: .module))
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

struct TaskListView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: [
                .init(name: "isEnabledNewFeature-True", state: .create(cacheDataStore: .init(remoteConfigUpdateErrorSubjecter: .init(), appInfoSubjecter: .init(.defaultValue), variantTestSubjecter: .init(.init(isEnabledNewFeature: true))))),
                .init(name: "isEnabledNewFeature-False", state: .create(cacheDataStore: .init(remoteConfigUpdateErrorSubjecter: .init(), appInfoSubjecter: .init(.defaultValue), variantTestSubjecter: .init(.init(isEnabledNewFeature: false))))),
            ],
            configure: { state in
                TaskListView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
