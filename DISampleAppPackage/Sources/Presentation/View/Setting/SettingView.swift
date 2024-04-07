
import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct SettingView<Router: AppRootWireframe, Dependency: SettingPresenterDependency>: View {
    private let router: Router
    @State private var presenter: SettingPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        presenter = SettingPresenter(dependency: dependency)
    }

    public var body: some View {
        List {
            Section("") {
                NavigationLink {
                    router.createLicenseListView()
                } label: {
                    Label(
                        title: { Text("ライセンス", bundle: .module) },
                        icon: { SFSymbols.licenseplate.image }
                    )
                }

                NavigationLink {
                    router.createDeviceInfoView()
                } label: {
                    Label(
                        title: { Text("デバイス情報", bundle: .module) },
                        icon: { SFSymbols.iphoneGen3.image }
                    )
                }
            }

            Section("") {
                NavigationLink {
                    router.createDebugMenuView()
                } label: {
                    Label(
                        title: { Text("デバッグメニュー", bundle: .module) },
                        icon: { SFSymbols.ladybug.image }
                    )
                }
            }
            .isHidden(!presenter.isDebugBuild, remove: true)
        }
        .navigationTitle(String(localized: "設定", bundle: .module))
        .task {
            await presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct SettingView_Previews: PreviewProvider, SnapshotTestable {
    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: [
                UITestPreviewType.standard.configuration,
                UITestPreviewType.releaseBuildConfiguration.configuration,
            ],
            configure: { state in
                SettingView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
