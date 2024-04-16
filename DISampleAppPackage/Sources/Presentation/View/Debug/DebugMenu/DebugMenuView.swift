
import DomainLayer
import SwiftUI

// MARK: - Entity

public enum DebugActionType {
    case forceCrash
    case clearUserDefaults
}

public enum DebugRouterType {
    case original
    case randomMock
    case emptyMock

    var description: String {
        switch self {
        case .original:
            String(localized: "Original", bundle: .module)
        case .randomMock:
            String(localized: "Random", bundle: .module)
        case .emptyMock:
            String(localized: "Empty", bundle: .module)
        }
    }
}

extension DebugRouterType: CaseIterable {}

// MARK: - View

@MainActor
public struct DebugMenuView<Dependency: AppRootRouterDependency>: View {
    private let router: AppRootRouter<Dependency>
    @State private var presenter: DebugMenuPresenter<Dependency>
    // issue: 【バグ】Environment(\.dismiss) var dismiss を使用すると View の生成の無限ループが発生する #131 https://github.com/suguruTakahashi-1234/DISample/issues/131
    @Environment(\.presentationMode) var presentationMode

    /// このように エントリーポイントではなくても任意の保持したい View での Router の生成は可能である
    private let randomMockRouter = AppRootRouter(dependency: AppRootRouterDependencyMock.random)
    private let emptyMockRouter = AppRootRouter(dependency: AppRootRouterDependencyMock.empty)

    public init(router: AppRootRouter<Dependency>) {
        self.router = router
        _presenter = .init(wrappedValue: DebugMenuPresenter(dependency: router.dependency))
    }

    public var body: some View {
        List {
            Section("") {
                NavigationLink {
                    router.createDebugShortcutViewListView(debugRouterType: DebugRouterType.original)
                } label: {
                    Label(
                        title: { Text("画面一覧 - \(DebugRouterType.original.description)", bundle: .module) },
                        icon: { SFSymbols.rectangleOnRectangle.image }
                    )
                }

                NavigationLink {
                    randomMockRouter.createDebugShortcutViewListView(debugRouterType: DebugRouterType.randomMock)
                } label: {
                    Label(
                        title: { Text("画面一覧 - \(DebugRouterType.randomMock.description)", bundle: .module) },
                        icon: { SFSymbols.rectangleOnRectangle.image }
                    )
                }

                NavigationLink {
                    emptyMockRouter.createDebugShortcutViewListView(debugRouterType: DebugRouterType.emptyMock)
                } label: {
                    Label(
                        title: { Text("画面一覧 - \(DebugRouterType.emptyMock.description)", bundle: .module) },
                        icon: { SFSymbols.rectangleOnRectangle.image }
                    )
                }
            }

            Section("") {
                NavigationLink {
                    SFSymbolsListView()
                } label: {
                    Label(
                        title: { Text("アイコン一覧", bundle: .module) },
                        icon: { SFSymbols.squareGrid2x2.image }
                    )
                }
            }

            Section("") {
                ForEach(DebugActionType.allCases) { debugAction in
                    Button(debugAction.name) {
                        presenter.onTapDebugAction(debugAction)
                    }
                }
            }
        }
        .navigationTitle(String(localized: "デバッグメニュー", bundle: .module))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    SFSymbols.xmark.image
                }
            }
        }
        .alert(presenter.selectedDebugActionType?.alertTitle ?? String(localized: "予期せぬエラー", bundle: .module), isPresented: $presenter.shouldShowAlert, presenting: presenter.selectedDebugActionType) { selectedDebugActionType in
            Button(String(localized: "キャンセル", bundle: .module), role: .cancel) {}
            Button(String(localized: "OK", bundle: .module), role: .destructive) {
                presenter.onTapAlertOk(selectedDebugActionType)
            }
        }
        .task {
            await presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

// MARK: - Extension DebugActionType

/// for ForEach
extension DebugActionType: CaseIterable, Identifiable {
    public var id: String {
        "\(self)"
    }
}

private extension DebugActionType {
    var name: String {
        switch self {
        case .forceCrash:
            String(localized: "強制クラッシュ", bundle: .module)
        case .clearUserDefaults:
            String(localized: "UserDefaults の初期化", bundle: .module)
        }
    }

    var alertTitle: String {
        switch self {
        default:
            name
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct DebugMenuView_Previews: PreviewProvider, SnapshotTestable {
    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: [
                UITestPreviewType.standard.configuration,
            ],
            configure: { dependency in
                DebugMenuView(router: AppRootRouter(dependency: dependency))
                    .navigationStacked()
            }
        )
    }
}
