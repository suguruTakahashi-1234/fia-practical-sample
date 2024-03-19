
import DomainLayer
import SwiftUI

enum DebugMenuType {
    case deviceInfo
//    case viewList
//    case changeDataStore
}

enum DebugActionType {
    case forceCrash
    case clearUserDefaults
}

extension DebugActionType: CaseIterable, Identifiable {
    var id: String {
        name
    }

    var name: String {
        switch self {
        case .forceCrash:
            "強制クラッシュ"
        case .clearUserDefaults:
            "UserDefaults の初期化"
        }
    }

    var alertTitle: String {
        switch self {
        default:
            "\(name) "
        }
    }
}

@MainActor
public struct DebugMenuView<Router: AppRootWireframe, Dependency: DebugMenuPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: DebugMenuPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: DebugMenuPresenter(dependency: dependency))
    }

    public var body: some View {
        List {
            Section("") {
                ForEach(DebugMenuType.allCases) { debugMenu in
                    NavigationLink {
                        debugMenu.contentView(router: router)
                    } label: {
                        debugMenu.label
                    }
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
        .navigationTitle("デバッグメニュー")
        .alert(presenter.selectedDebugActionType?.alertTitle ?? "Unexpected", isPresented: $presenter.shouldShowAlert, presenting: presenter.selectedDebugActionType) { selectedDebugActionType in
            Button("Cancel", role: .cancel) {}
            Button("OK", role: .destructive) {
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

extension DebugMenuType: CaseIterable, Identifiable {
    var id: String {
        name
    }

    var name: String {
        switch self {
        case .deviceInfo:
            "デバイス情報"
//        case .viewList:
//            "デバッグ画面一覧"
//        case .changeDataStore:
//            "内部データの変更"
        }
    }

    var image: some View {
        switch self {
        case .deviceInfo:
            SFSymbols.iphoneGen3.image
//        case .viewList:
//            SFSymbols.rectangleGrid1x2.image
//        case .changeDataStore:
//            SFSymbols.squareAndPencil.image
        }
    }

    var label: some View {
        Label(
            title: { Text(self.name) },
            icon: { self.image }
        )
    }

    @MainActor @ViewBuilder
    func contentView(router: some AppRootWireframe) -> some View {
        switch self {
        case .deviceInfo:
            router.createDeviceInfoView()
//        case .viewList:
//            router.createDeviceInfoView()
//        case .changeDataStore:
//            router.createDeviceInfoView()
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct DebugMenuView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: standard,
            configure: { state in
                DebugMenuView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
