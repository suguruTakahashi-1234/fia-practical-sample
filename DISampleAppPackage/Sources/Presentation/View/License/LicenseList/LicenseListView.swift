//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import SwiftUI

// MARK: - View

@MainActor
public struct LicenseListView<Dependency: AppRootRouterDependency>: View {
    private let router: AppRootRouter<Dependency>
    @State private var presenter: LicenseListPresenter<Dependency>

    public init(router: AppRootRouter<Dependency>) {
        self.router = router
        presenter = LicenseListPresenter(dependency: router.dependency)
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
            LicenseDetailView(dependency: router.dependency, license: license)
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
    static var snapshots: PreviewSnapshots<AppRootRouterDependencyMock> {
        .init(
            configurations: allSizes + [
                UITestPreviewType.empty.configuration,
            ],
            configure: { dependency in
                LicenseListView(router: AppRootRouter(dependency: dependency))
                    .navigationStacked()
            }
        )
    }
}
