
import DomainLayer
import SwiftUI

// MARK: - Entity

public enum DebugActionType {
    case forceCrash
    case clearUserDefaults
}

// MARK: - View

@MainActor
public struct DebugMenuView<Router: AppRootWireframe, Dependency: DebugMenuPresenterDependency>: View {
    private let router: Router
    @State private var presenter: DebugMenuPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: DebugMenuPresenter(dependency: dependency))
    }

    public var body: some View {
        List {
            Section("") {
                NavigationLink {
                    router.createDebugShortcutViewListView()
                } label: {
                    Label(
                        title: { Text("画面一覧", bundle: .module) },
                        icon: { SFSymbols.rectangleOnRectangle.image }
                    )
                }

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
            configure: { state in
                DebugMenuView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
