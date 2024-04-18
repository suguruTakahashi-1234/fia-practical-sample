//
//  Created by sugurutakahashi on 2024/04/06
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

public enum DebugShortcutViewType {
    case deviceInfo
    case onboarding
    case licenseList
    case licenseDetail
    case taskList
}

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

/// for ForEach
extension DebugShortcutViewType: CaseIterable, Identifiable {
    public var id: String {
        "\(self)"
    }
}

private extension DebugShortcutViewType {
    var name: String {
        switch self {
        case .deviceInfo:
            String(localized: "デバイス情報", bundle: .module)
        case .onboarding:
            String(localized: "オンボーディング", bundle: .module)
        case .licenseList:
            String(localized: "ライセンス一覧", bundle: .module)
        case .licenseDetail:
            String(localized: "ライセンス詳細", bundle: .module)
        case .taskList:
            String(localized: "タスク一覧", bundle: .module)
        }
    }

    var image: some View {
        switch self {
        case .deviceInfo:
            SFSymbols.iphoneGen3.image
        case .onboarding:
            SFSymbols.book.image
        case .licenseList:
            SFSymbols.licenseplate.image
        case .licenseDetail:
            SFSymbols.licenseplateFill.image
        case .taskList:
            SFSymbols.pencilAndListClipboard.image
        }
    }

    var label: some View {
        Label(
            title: { Text(name) },
            icon: { self.image }
        )
    }

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
