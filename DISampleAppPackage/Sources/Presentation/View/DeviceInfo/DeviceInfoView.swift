
import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct DeviceInfoView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    @State private var presenter: DeviceInfoPresenter<Dependency>

    public init(dependency: Dependency) {
        self.dependency = dependency
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
        .navigationTitle(String(localized: "デバイス情報", bundle: .module))
        .alert(presenter.copiedAlertTitle, isPresented: $presenter.shouldShowCopyAlert) {
            Button(String(localized: "OK", bundle: .module), action: {})
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
    static var snapshots: PreviewSnapshots<AppRootDIContainerDependencyMock> {
        .init(
            configurations: [
                UITestPreviewType.standard.configuration,
            ],
            configure: { dependency in
                DeviceInfoView(dependency: dependency)
                    .navigationStacked()
            }
        )
    }
}
