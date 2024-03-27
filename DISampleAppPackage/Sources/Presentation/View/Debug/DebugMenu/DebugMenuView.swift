
import DomainLayer
import SwiftUI

// MARK: - Entity

public enum DebugShowViewType {
    case deviceInfo
    case onboarding
//    case viewList
//    case changeDataStore
}

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
                ForEach(DebugShowViewType.allCases) { debugMenu in
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

// MARK: - Extension DebugMenuType

/// for ForEach
extension DebugShowViewType: CaseIterable, Identifiable {
    public var id: String {
        "\(self)"
    }
}

private extension DebugShowViewType {
    var name: String {
        switch self {
        case .deviceInfo:
            String(localized: "デバイス情報", bundle: .module)
        case .onboarding:
            String(localized: "オンボーディング", bundle: .module)
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
        case .onboarding:
            SFSymbols.book.image
//        case .viewList:
//            SFSymbols.rectangleGrid1x2.image
//        case .changeDataStore:
//            SFSymbols.squareAndPencil.image
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
