
import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct TaskListView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    @State private var presenter: TaskListPresenter<Dependency>

    public init(dependency: Dependency) {
        self.dependency = dependency
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
    static var snapshots: PreviewSnapshots<AppRootDIContainerDependencyMock> {
        .init(
            configurations: [
                .init(name: "isEnabledNewFeature-True", state: .create(cacheDataStoreDriver: .init(remoteConfigUpdateErrorSubjecter: .init(), appInfoSubjecter: .init(.defaultValue), variantTestSubjecter: .init(.init(isEnabledNewFeature: true))))),
                .init(name: "isEnabledNewFeature-False", state: .create(cacheDataStoreDriver: .init(remoteConfigUpdateErrorSubjecter: .init(), appInfoSubjecter: .init(.defaultValue), variantTestSubjecter: .init(.init(isEnabledNewFeature: false))))),
            ],
            configure: { dependency in
                TaskListView(dependency: dependency)
                    .navigationStacked()
            }
        )
    }
}
