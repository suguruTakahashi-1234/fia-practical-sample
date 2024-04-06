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
public struct DebugShortcutViewListView<Router: AppRootWireframe, Dependency: DebugShortcutViewListPresenterDependency>: View {
    private let router: Router
    @State private var presenter: DebugShortcutViewListPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        presenter = DebugShortcutViewListPresenter(dependency: dependency)
    }

    public var body: some View {
        List {
            Section("") {
                ForEach(DebugShortcutViewType.allCases) { debugMenu in
                    NavigationLink {
                        debugMenu.contentView(router: router)
                    } label: {
                        debugMenu.label
                    }
                }
            }
        }
        .navigationTitle(String(localized: "画面一覧", bundle: .module))
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
            String(localized: "ライセンス", bundle: .module)
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
    func contentView(router: some AppRootWireframe) -> some View {
        switch self {
        case .deviceInfo:
            router.createDeviceInfoView()
        case .onboarding:
            router.createOnboardingView()
        case .licenseList:
            router.createLicenseListView()
        case .licenseDetail:
            router.createLicenseDetailView(license: .random)
        case .taskList:
            router.createTaskListView()
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct DebugShortcutViewListView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: [
                UITestPreviewType.standard.configuration,
            ],
            configure: { state in
                DebugShortcutViewListView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
