//
//  Created by sugurutakahashi on 2024/04/06
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct DebugShortcutViewListView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    private let debugDependencyType: DebugDependencyType
    @State private var presenter: DebugShortcutViewListPresenter<Dependency>

    public init(dependency: Dependency, debugDependencyType: DebugDependencyType) {
        self.dependency = dependency
        self.debugDependencyType = debugDependencyType
        presenter = DebugShortcutViewListPresenter(dependency: dependency)
    }

    public var body: some View {
        List {
            Section("") {
                ForEach(DebugShortcutViewType.allCases) { debugMenu in
                    NavigationLink {
                        debugMenu.contentView(dependency: dependency)
                    } label: {
                        debugMenu.label
                    }
                }
            }
        }
        .navigationTitle(String(localized: "画面一覧 - \(debugDependencyType.description)", bundle: .module))
        .task {
            await presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

// MARK: - Extension DebugShortcutViewType

private extension DebugShortcutViewType {
    @MainActor @ViewBuilder
    func contentView(dependency: some AppRootDIContainerDependency) -> some View {
        switch self {
        case .deviceInfo:
            DeviceInfoView(dependency: dependency)
        case .onboarding:
            OnboardingView(dependency: dependency)
        case .licenseList:
            LicenseListView(dependency: dependency)
        case .licenseDetail:
            LicenseDetailView(dependency: dependency, license: .random)
        case .taskList:
            TaskListView(dependency: dependency)
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct DebugShortcutViewListView_Previews: PreviewProvider, SnapshotTestable {
    static var snapshots: PreviewSnapshots<DebugDependencyType> {
        .init(
            configurations: DebugDependencyType.allCases.map { debugDependencyType in .init(name: debugDependencyType.description, state: debugDependencyType) },
            configure: { debugDependencyType in
                DebugShortcutViewListView(dependency: AppRootDIContainerDependencyMock.random, debugDependencyType: debugDependencyType)
                    .navigationStacked()
            }
        )
    }
}
