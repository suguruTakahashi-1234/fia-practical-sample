//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct LicenseListView<Dependency: AppRootDIContainerDependency>: View {
    private let dependency: Dependency
    @State private var presenter: LicenseListPresenter<Dependency>

    public init(dependency: Dependency) {
        self.dependency = dependency
        presenter = LicenseListPresenter(dependency: dependency)
    }

    public var body: some View {
        VStack {
            if presenter.isEmptyLicense {
                Text(String(localized: "ライセンスはありません", bundle: .module))
                    .padding()
                Spacer()
            } else {
                List {
                    Section("") {
                        ForEach(presenter.licenseList) { license in
                            Button {
                                presenter.onTapLicense(license: license)
                            } label: {
                                Text(license.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(String(localized: "ライセンス", bundle: .module))
        .sheet(item: $presenter.selectedLicense, content: { license in
            LicenseDetailView(dependency: dependency, license: license)
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

struct LicenseListView_Previews: PreviewProvider, SnapshotTestable {
    static var snapshots: PreviewSnapshots<AppRootDIContainerDependencyMock> {
        .init(
            configurations: allSizes + [
                UITestPreviewType.empty.configuration,
            ],
            configure: { dependency in
                LicenseListView(dependency: dependency)
                    .navigationStacked()
            }
        )
    }
}
