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
public struct DebugShortcutViewListView<Dependency: AppRootRouterDependency>: View {
    private let dependency: Dependency
    private let debugRouterType: DebugRouterType
    @State private var presenter: DebugShortcutViewListPresenter<Dependency>

    public init(dependency: Dependency, debugRouterType: DebugRouterType) {
        self.dependency = dependency
        self.debugRouterType = debugRouterType
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
        .navigationTitle(String(localized: "画面一覧 - \(debugRouterType.description)", bundle: .module))
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
    func contentView(dependency: some AppRootRouterDependency) -> some View {
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
    static var snapshots: PreviewSnapshots<DebugRouterType> {
        .init(
            configurations: DebugRouterType.allCases.map { debugRouterType in .init(name: debugRouterType.description, state: debugRouterType) },
            configure: { debugRouterType in
                DebugShortcutViewListView(dependency: AppRootRouterDependencyMock.random, debugRouterType: debugRouterType)
                    .navigationStacked()
            }
        )
    }
}
