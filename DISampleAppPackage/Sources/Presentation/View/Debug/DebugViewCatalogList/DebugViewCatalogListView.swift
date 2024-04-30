//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct DebugViewCatalogListView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    @State private var presenter: DebugViewCatalogListPresenter<Dependency>

    public init(dependency: Dependency) {
        self.dependency = dependency
        presenter = DebugViewCatalogListPresenter(dependency: dependency)
    }

    public var body: some View {
        List {
            Section("View List") {
                ForEach(DebugShortcutViewType.allCases) { debugMenu in
                    NavigationLink {
                        debugMenu.testCaseListView
                    } label: {
                        debugMenu.label
                    }
                }
            }
            .textCase(nil)
        }
        .navigationTitle(String(localized: "View Catalog", bundle: .module))
        .task {
            await presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

private extension DebugShortcutViewType {
    @MainActor @ViewBuilder
    var testCaseListView: some View {
        switch self {
        case .deviceInfo:
            Text("// TODO: DeviceInfo")
        case .onboarding:
            Text("// TODO: Onboarding")
        case .licenseList:
            TestCaseListView<LicenseListViewTestCase>()
        case .licenseDetail:
            Text("// TODO: LicenseDetail")
        case .taskList:
            Text("// TODO: TaskList")
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct DebugViewCatalogListView_Previews: PreviewProvider, SnapshotTestable {
    static var snapshots: PreviewSnapshots<AppRootDIContainerDependencyMock> {
        .init(
            configurations: [
                UITestPreviewType.standard.configuration,
            ],
            configure: { dependency in
                DebugViewCatalogListView(dependency: dependency)
                    .navigationStacked()
            }
        )
    }
}
