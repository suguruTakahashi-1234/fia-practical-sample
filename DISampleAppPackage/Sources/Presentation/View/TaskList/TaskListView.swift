
import DomainLayer
import SwiftUI

@MainActor
public struct TaskListView<Router: AppRootWireframe, Dependency: TaskListPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: TaskListPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: TaskListPresenter(dependency: dependency))
    }

    public var body: some View {
        NavigationStack {
            Text("TaskListView")
                .navigationTitle("タスク一覧")
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

struct TaskListView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: configurationAllSizesWithEmpty,
            configure: { state in
                TaskListView(router: AppRootRouter.empty, dependency: state)
            }
        )
    }
}
