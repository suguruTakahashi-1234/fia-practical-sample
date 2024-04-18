
import DomainLayer
import SwiftUI

// MARK: - Entity

public enum DebugActionType {
    case forceCrash
    case clearUserDefaults
}

public enum DebugDependencyType {
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

extension DebugDependencyType: CaseIterable {}

// MARK: - View

@MainActor
public struct DebugMenuView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    @State private var presenter: DebugMenuPresenter<Dependency>
    // issue: 【バグ】Environment(\.dismiss) var dismiss を使用すると View の生成の無限ループが発生する #131 https://github.com/suguruTakahashi-1234/fia-practical-sample/issues/131
    @Environment(\.presentationMode) var presentationMode

    /// このように エントリーポイントではなくても任意の保持したい View での dependency の生成は可能である
    private let randomMockDependency = AppRootDIContainerDependencyMock.random
    private let emptyMockDependency = AppRootDIContainerDependencyMock.empty

    public init(dependency: Dependency) {
        self.dependency = dependency
        _presenter = .init(wrappedValue: DebugMenuPresenter(dependency: dependency))
    }

    public var body: some View {
        List {
            Section("") {
                NavigationLink {
                    DebugShortcutViewListView(dependency: dependency, debugDependencyType: DebugDependencyType.original)
                } label: {
                    Label(
                        title: { Text("画面一覧 - \(DebugDependencyType.original.description)", bundle: .module) },
                        icon: { SFSymbols.rectangleOnRectangle.image }
                    )
                }

                NavigationLink {
                    DebugShortcutViewListView(dependency: randomMockDependency, debugDependencyType: DebugDependencyType.randomMock)
                } label: {
                    Label(
                        title: { Text("画面一覧 - \(DebugDependencyType.randomMock.description)", bundle: .module) },
                        icon: { SFSymbols.rectangleOnRectangle.image }
                    )
                }

                NavigationLink {
                    DebugShortcutViewListView(dependency: emptyMockDependency, debugDependencyType: DebugDependencyType.emptyMock)
                } label: {
                    Label(
                        title: { Text("画面一覧 - \(DebugDependencyType.emptyMock.description)", bundle: .module) },
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
    static var snapshots: PreviewSnapshots<AppRootDIContainerDependencyMock> {
        .init(
            configurations: [
                UITestPreviewType.standard.configuration,
            ],
            configure: { dependency in
                DebugMenuView(dependency: dependency)
                    .navigationStacked()
            }
        )
    }
}
