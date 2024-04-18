
import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct SettingView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    @State private var presenter: SettingPresenter<Dependency>

    public init(dependency: Dependency) {
        self.dependency = dependency
        presenter = SettingPresenter(dependency: dependency)
    }

    public var body: some View {
        List {
            Section("") {
                NavigationLink {
                    LicenseListView(dependency: dependency)
                } label: {
                    Label(
                        title: { Text("ライセンス", bundle: .module) },
                        icon: { SFSymbols.licenseplate.image }
                    )
                }

                NavigationLink {
                    DeviceInfoView(dependency: dependency)
                } label: {
                    Label(
                        title: { Text("デバイス情報", bundle: .module) },
                        icon: { SFSymbols.iphoneGen3.image }
                    )
                }
            }

            Section("") {
                Button {
                    presenter.onTapDebugMenu()
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
        .fullScreenCover(isPresented: $presenter.shouldShowDebugMenu, content: {
            DebugMenuView(dependency: dependency)
                .navigationStacked()
        })
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
    static var snapshots: PreviewSnapshots<AppRootDIContainerDependencyMock> {
        .init(
            configurations: [
                UITestPreviewType.standard.configuration,
                UITestPreviewType.releaseBuildConfiguration.configuration,
            ],
            configure: { dependency in
                SettingView(dependency: dependency)
                    .navigationStacked()
            }
        )
    }
}
