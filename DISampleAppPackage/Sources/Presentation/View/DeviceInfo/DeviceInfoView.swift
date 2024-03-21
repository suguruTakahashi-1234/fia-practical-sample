
import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct DeviceInfoView<Router: AppRootWireframe, Dependency: DeviceInfoPresenterDependency>: View {
    private let router: Router
    @State private var presenter: DeviceInfoPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        presenter = DeviceInfoPresenter(dependency: dependency)
    }

    public var body: some View {
        List {
            Section("") {
                ForEach(DeviceInfoType.allCases) { deviceInfoType in
                    Button {
                        presenter.onTapDeviceInfo(deviceInfoType)
                    } label: {
                        HStack {
                            Text(deviceInfoType.name)
                            Spacer()
                            Text(presenter.getDeviceInfoValue(deviceInfoType))
                                .lineLimit(1)
                                .truncationMode(.middle)
                        }
                    }
                }
            }
        }
        .navigationTitle("デバイス情報")
        .alert(presenter.copiedAlertTitle, isPresented: $presenter.shouldShowCopyAlert) {
            Button("OK", action: {})
        }
        .task {
            await presenter.onAppear()
        }
        .onDisappear {
            presenter.onDisappear()
        }
    }
}

extension DeviceInfoType: Identifiable {
    public var id: String {
        name
    }

    var name: String {
        switch self {
        case .osVersion:
            "OS Version"
        default:
            "\(self)".camelCaseToSpaces.initialUppercased
        }
    }
}

// MARK: - Preview

import PreviewSnapshots

struct DeviceInfoView_Previews: PreviewProvider, SnapshotTestable {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: standard,
            configure: { state in
                DeviceInfoView(router: AppRootRouter.empty, dependency: state)
                    .navigationStacked()
            }
        )
    }
}
