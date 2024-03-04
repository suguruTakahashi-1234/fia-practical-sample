
import DomainLayer
import SwiftUI

@MainActor
public struct DeviceInfoView<Router: AppRootWireframe, Dependency: DeviceInfoPresenterDependency>: View {
    private let router: Router
    @StateObject private var presenter: DeviceInfoPresenter<Dependency>

    public init(router: Router, dependency: Dependency) {
        self.router = router
        _presenter = .init(wrappedValue: DeviceInfoPresenter(dependency: dependency))
    }

    public var body: some View {
        NavigationStack {
            List {
                Section("Device Info") {
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
                .textCase(nil)
            }
            .navigationTitle("Device Info")
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
            configurations: configurationEmpty,
            configure: { state in
                DeviceInfoView(router: AppRootRouter.empty, dependency: state)
            }
        )
    }
}
