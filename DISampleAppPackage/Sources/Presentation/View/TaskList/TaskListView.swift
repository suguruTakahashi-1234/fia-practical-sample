
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
            Text("TaskListView")
            Text("Remote Comfig New UI Mode: \(presenter.isEnabledNewFeature ? "true" : "false")")
        }
        .navigationTitle("タスク一覧")
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
                .init(name: "isEnabledNewFeature-Flase", state: .create(cacheDataStore: .init(remoteConfigUpdateErrorSubjecter: .init(), appInfoSubjecter: .init(.defaultValue), variantTestSubjecter: .init(.init(isEnabledNewFeature: false))))),
            ],
            configure: { state in
                TaskListView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
